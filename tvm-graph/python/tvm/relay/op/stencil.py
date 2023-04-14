from . import _make

def star2d2r(data, weight, placeholder=False):
    return _make.star2d2r(data, weight, placeholder)

def star1d4r(data, weight, regular=True, use_weight=False, accumulate=False, tag="regular"):
    return _make.star1d4r(data, weight, regular, use_weight, accumulate, tag)

def grid1stencil(grid1, tag="default"):
    return _make.grid1stencil(grid1, tag)

def grid2stencil(grid1, grid2, tag="default"):
    return _make.grid2stencil(grid1, grid2, tag)

def grid3stencil(grid1, grid2, grid3, tag="default"):
    return _make.grid3stencil(grid1, grid2, grid3, tag)

def grid4stencil(grid1, grid2, grid3, grid4, tag="default"):
    return _make.grid4stencil(grid1, grid2, grid3, grid4, tag)

def grid5stencil(grid1, grid2, grid3, grid4, grid5, tag="default"):
    return _make.grid5stencil(grid1, grid2, grid3, grid4, grid5, tag)

def grid6stencil(grid1, grid2, grid3, grid4, grid5, grid6, tag="default"):
    return _make.grid6stencil(grid1, grid2, grid3, grid4, grid5, grid6, tag)

def grid2mostencil(grid1, grid2, tag="default", output_num=1):
    return _make.grid2mostencil(grid1, grid2, tag, output_num)
