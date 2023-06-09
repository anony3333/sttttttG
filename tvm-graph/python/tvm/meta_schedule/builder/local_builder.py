# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
"""Local builder that compile on the local host"""
import logging
import os
import tempfile
from typing import Callable, Dict, List, Optional, Union

from tvm._ffi import register_func
from tvm.ir import IRModule
from tvm.runtime import Module, NDArray, load_param_dict, save_param_dict
from tvm.target import Target

from ...contrib.popen_pool import MapResult, PopenPoolExecutor, StatusKind
from ..utils import cpu_count, get_global_func_with_default_on_worker
from .builder import BuilderInput, BuilderResult, PyBuilder


logger = logging.getLogger(__name__)  # pylint: disable=invalid-name


def _serialize_params(params: Optional[Dict[str, NDArray]]) -> Optional[bytearray]:
    if params is None:
        return None
    return save_param_dict(params)


def _deserialize_params(params: Optional[bytearray]) -> Optional[Dict[str, NDArray]]:
    if params is None:
        return None
    return load_param_dict(params)


class LocalBuilder(PyBuilder):
    """A builder that builds the given input on local host.

    Parameters
    ----------
    pool : PopenPoolExecutor
        The process pool to run the build.
    timeout_sec : float
        The timeout in seconds for the build.
    f_build : Union[None, str, LocalBuilder.T_BUILD]
        Name of the build function to be used.
        Defaults to `meta_schedule.builder.default_build`.
    f_export : Union[None, str, LocalBuilder.T_EXPORT]
        Name of the export function to be used.
        Defaults to `meta_schedule.builder.default_export`.

    Attributes
    ----------
    T_BUILD : typing._GenericAlias
        The signature of the function `f_build`, which is

        .. code-block:: python

        def default_build(
            mod: IRModule,
            target: Target,
            params: Optional[Dict[str, NDArray]]
        ) -> Module:
            ...

    T_EXPORT : typing._GenericAlias
        The signature of the function `f_export`, which is

        .. code-block:: python

        def default_export(mod: Module) -> str:
            ...

    Note
    ----
    The build function and export function should be registered in the worker process.
    The worker process is only aware of functions registered in TVM package,
    if there are extra functions to be registered,
    please send the registration logic via initializer.
    """

    T_BUILD = Callable[[IRModule, Target, Optional[Dict[str, NDArray]]], Module]
    T_EXPORT = Callable[[Module], str]

    pool: PopenPoolExecutor
    timeout_sec: float
    f_build: Union[None, str, T_BUILD]
    f_export: Union[None, str, T_EXPORT]

    def __init__(
        self,
        *,
        max_workers: Optional[int] = None,
        timeout_sec: float = 30.0,
        f_build: Union[None, str, T_BUILD] = None,
        f_export: Union[None, str, T_EXPORT] = None,
        initializer: Optional[Callable[[], None]] = None,
    ) -> None:
        """Constructor.

        Parameters
        ----------
        max_workers : Optional[int]
            The maximum number of worker processes to be used.
            Defaults to number of CPUs.
        timeout_sec : float
            The timeout in seconds for the build.
        f_build : LocalBuilder.T_BUILD
            Name of the build function to be used.
            Defaults to `meta_schedule.builder.default_build`.
        f_export : LocalBuilder.T_EXPORT
            Name of the export function to be used.
            Defaults to `meta_schedule.builder.default_export`.
        initializer : Optional[Callable[[], None]]
            The initializer to be used for the worker processes.
        """
        super().__init__()

        if max_workers is None:
            max_workers = cpu_count(logical=True)
        logger.info("LocalBuilder: max_workers = %d", max_workers)

        self.pool = PopenPoolExecutor(
            max_workers=max_workers,
            timeout=timeout_sec,
            initializer=initializer,
        )
        self.timeout_sec = timeout_sec
        self.f_build = f_build
        self.f_export = f_export
        self._sanity_check()

    def build(self, build_inputs: List[BuilderInput]) -> List[BuilderResult]:
        results: List[BuilderResult] = []
        map_result: MapResult

        # Dispatch the build inputs to the worker processes.
        for map_result in self.pool.map_with_error_catching(
            lambda x: LocalBuilder._worker_func(*x),
            [
                (
                    self.f_build,
                    self.f_export,
                    build_input.mod,
                    build_input.target,
                    _serialize_params(build_input.params),
                )
                for build_input in build_inputs
            ],
        ):
            if map_result.status == StatusKind.COMPLETE:
                results.append(BuilderResult(map_result.value, None))
            elif map_result.status == StatusKind.TIMEOUT:
                results.append(
                    BuilderResult(
                        None,
                        f"LocalBuilder: Timeout, killed after {self.timeout_sec} seconds",
                    )
                )
            elif map_result.status == StatusKind.EXCEPTION:
                results.append(
                    BuilderResult(
                        None,
                        "LocalBuilder: An exception occurred\n" + str(map_result.value),
                    )
                )
            else:
                raise ValueError("Unreachable: unexpected result: {map_result}")
        return results

    def _sanity_check(self) -> None:
        def _check(f_build, f_export) -> None:
            get_global_func_with_default_on_worker(name=f_build, default=None)
            get_global_func_with_default_on_worker(name=f_export, default=None)

        value = self.pool.submit(_check, self.f_build, self.f_export)
        value.result()

    @staticmethod
    def _worker_func(
        _f_build: Union[None, str, T_BUILD],
        _f_export: Union[None, str, T_EXPORT],
        mod: IRModule,
        target: Target,
        params: Optional[bytearray],
    ) -> str:
        # Step 0. Get the registered functions
        f_build: LocalBuilder.T_BUILD = get_global_func_with_default_on_worker(
            _f_build,
            default_build,
        )
        f_export: LocalBuilder.T_EXPORT = get_global_func_with_default_on_worker(
            _f_export,
            default_export,
        )
        # Step 1. Build the IRModule
        rt_mod: Module = f_build(mod, target, _deserialize_params(params))
        # Step 2. Export the Module
        artifact_path: str = f_export(rt_mod)
        return artifact_path


@register_func("meta_schedule.builder.default_build")
def default_build(mod: IRModule, target: Target, _params: Optional[Dict[str, NDArray]]) -> Module:
    """Default build function.

    Parameters
    ----------
    mod : IRModule
        The IRModule to be built.
    target : Target
        The target to be built.
    _params : Optional[Dict[str, NDArray]]
        The parameters to be used for the build. Must be None.

    Returns
    -------
    rt_mod : Module
        The built Module.
    """
    # pylint: disable=import-outside-toplevel
    from tvm.driver import build as tvm_build
    from tvm.ir.transform import PassContext

    # pylint: enable=import-outside-toplevel
    with PassContext(disabled_pass=["tir.CommonSubexprElimTIR"]):
        return tvm_build(mod, target=target)


@register_func("meta_schedule.builder.default_export")
def default_export(mod: Module) -> str:
    """Default export function.

    Parameters
    ----------
    mod : Module
        The Module to be exported.

    Returns
    -------
    artifact_path : str
        The path to the exported Module.
    """
    from tvm.contrib.tar import tar  # pylint: disable=import-outside-toplevel

    artifact_path = os.path.join(tempfile.mkdtemp(), "tvm_tmp_mod." + tar.output_format)
    mod.export_library(artifact_path, tar)
    return artifact_path
