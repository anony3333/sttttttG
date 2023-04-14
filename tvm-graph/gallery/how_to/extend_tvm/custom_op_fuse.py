import numpy as np
import tvm
from tvm import te
import tvm.relay as relay
from tvm.relay.transform.custom_fuse_ops import CustomFuseOps
from tvm.relay.transform.dnn_fusion import PrintOpType, DNNFuseOps


def example():
    shape = (1, 64, 54, 54)
    c_data = np.empty(shape).astype("float32")
    c = relay.const(c_data)
    weight = relay.var("weight", shape=(64, 64, 3, 3))
    x = relay.var("x", relay.TensorType((1, 64, 56, 56), "float32"))
    conv = relay.nn.conv2d(x, weight)
    y = relay.add(c, c)
    y = relay.multiply(y, relay.const(2, "float32"))
    y = relay.add(conv, y)
    z = relay.add(y, c)
    z1 = relay.add(y, c)
    z2 = relay.add(z, z1)
    return relay.Function([x, weight], z2)

def example():
    shape = (1, 64, 56, 56)
    c_data = np.empty(shape).astype("float32")
    c = relay.const(c_data)
    weight = relay.var("weight", shape=(64, 64, 1, 1))
    x = relay.var("x", relay.TensorType((1, 64, 56, 56), "float32"))
    x1 = relay.add(x, c)
    y = relay.multiply(x1, relay.const(2, "float32"))
    conv = relay.nn.conv2d(y, weight)
    z = relay.add(conv, x1)
    return relay.Function([x, weight], z)


f = example()
mod = tvm.IRModule.from_expr(f)
mod = relay.transform.InferType()(mod)
# mod = relay.transform.FuseOps(fuse_opt_level=0)(mod)
# exit(0)

print(mod)
custom_pass = CustomFuseOps(fuse_opt_level=3)
mod2 = DNNFuseOps()(mod)
print(mod2)
exit(0)
# mod = PrintOpType()(mod)
assert custom_pass.info.name == "CustomFuseOps"
mod3 = custom_pass(mod)
print(mod3)


mod4 = relay.transform.FuseOps(fuse_opt_level=3)(mod)
print(mod4)
##############################################################################
# Debug a Pass
# ------------
# TVM provides users a plug-and-play style debugging pass that print the IR
# after a certain pass is done through a special pass (``PrintIR``) to dump the IR of the
# whole module. A slightly modified version of the sequential pass example
# could be like the following to enable IR dumping for ``FoldConstant`` optimization.

f = example()
mod = tvm.IRModule.from_expr(f)
seq = tvm.transform.Sequential(
    [
        relay.transform.FoldConstant(),
        tvm.transform.PrintIR(),
        relay.transform.EliminateCommonSubexpr(),
        relay.transform.FuseOps(),
    ]
)

###############################################################################
# By inserting the ``PrintIR`` pass after ``FoldConstant``, the pass infra will
# dump out the module IR when ``FoldConstant`` is done. Users can plug in this
# pass after any pass they want to debug for viewing the optimization effect.
#
# There is a more flexible debugging mechanism. One can implement a ``PassInstrument``
# class to execute arbitrary code not only before and/or after each pass but also
# at entering/exiting ``PassContext``. See :ref:`pass_instrument_cpp_backend`
# for more details.
#
# Here we use :py::func`tvm.instrument.pass_instrument` decorator to implement
# a PassInsturment class printing IR before execution of each passes:


@tvm.instrument.pass_instrument
class PrintIR:
    """Print the name of the pass, the IR, only before passes execute."""

    def run_before_pass(self, mod, info):
        print("Running pass: {}", info)
        print(mod)


with tvm.transform.PassContext(opt_level=3, instruments=[PrintIR()]):
    with tvm.target.Target("llvm"):
        # Perform the optimizations.
        mod = seq(mod)
print(mod)

print("done")

##############################################################################
# Summary
# -------
# This tutorial has covered how we can write and invoke passes in TVM more
# conveniently using the pass infra. Different ways of invoking a pass are also
# disucssed. Using :py:class:`tvm.transform.Sequential` can largely help
# users to ease the work of handling multiple optimization passes and their
# dependencies. In addition, an example is provided to illustrate
# how we can debug a pass using the ``PrintIR`` and tracing.
