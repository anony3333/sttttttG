from tvm.topi.generic import default_stencil_schedule
from tvm.topi.stencil import hypterm_1_flux_0, hypterm_2_flux_0, hypterm_3_flux_0

class StencilImplementation:
    def __init__(self) -> None:
        self._compute = None
        self._schedule = default_stencil_schedule
    
    @property
    def compute(self):
        assert self._compute, "compute is None"
        return self._compute
    
    @property
    def schedule(self):
        assert self._schedule, "schedule is None"
        return self._schedule
    
    def set_compute(self, compute):
        self._compute = compute
    
    def set_schedule(self, schedule):
        self._schedule = schedule



class TagDispatch:
    def __init__(self) -> None:
        self._dispatch_stencil: dict[str, StencilImplementation] = {}
    
    def register_compute(self, tag, compute):
        if tag not in self._dispatch_stencil.keys():
            self._dispatch_stencil[tag] = StencilImplementation()
        self._dispatch_stencil[tag].set_compute(compute)
    
    def register_schedule(self, tag, schedule):
        if tag not in self._dispatch_stencil.keys():
            self._dispatch_stencil[tag] = StencilImplementation()
        self._dispatch_stencil[tag].set_schedule(schedule)
    
    def get_compute(self, tag):
        assert tag in self._dispatch_stencil.keys(), f"{tag} not register"
        return self._dispatch_stencil[tag].compute
    
    def get_schedule(self, tag):
        assert tag in self._dispatch_stencil.keys(), f"{tag} not register"
        return self._dispatch_stencil[tag].schedule

stencil_register = TagDispatch()

stencil_register.register_compute("flux_0_stage0", hypterm_1_flux_0)
stencil_register.register_compute("flux_0_stage1", hypterm_2_flux_0)
stencil_register.register_compute("flux_0_stage2", hypterm_3_flux_0)