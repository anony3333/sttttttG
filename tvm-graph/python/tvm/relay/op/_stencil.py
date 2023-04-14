from . import op as reg
from .op import OpPattern
from . import strategy

reg.register_strategy("stencil.star2d2r", strategy.stencil_2d2r_strategy)
# reg.register_pattern("stencil.star2d2r", OpPattern.OUT_ELEMWISE_FUSABLE)

reg.register_strategy("stencil.star1d4r", strategy.stencil_1d4r_strategy)

reg.register_strategy("stencil.grid1stencil", strategy.stencil_1grid_strategy)
reg.register_strategy("stencil.grid2stencil", strategy.stencil_2grid_strategy)
reg.register_strategy("stencil.grid3stencil", strategy.stencil_3grid_strategy)
reg.register_strategy("stencil.grid4stencil", strategy.stencil_4grid_strategy)
reg.register_strategy("stencil.grid5stencil", strategy.stencil_5grid_strategy)
reg.register_strategy("stencil.grid6stencil", strategy.stencil_6grid_strategy)

reg.register_strategy("stencil.grid2mostencil", strategy.stencil_2mogrid_strategy)
