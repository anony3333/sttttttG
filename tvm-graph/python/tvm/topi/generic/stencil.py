from tvm import te
from .default import default_schedule as _default_schedule

def schedule_stencil_star2d2r(outs):
    return _default_schedule(outs, False)

def schedule_stencil_star1d4r(outs):
    return _default_schedule(outs, False)

def default_stencil_schedule(outs):
    return _default_schedule(outs, False)
