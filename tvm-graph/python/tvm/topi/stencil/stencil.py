import tvm
from tvm import te

def star2d2r(data, weight, placeholder_arg):
    x, y = data.shape
    rx = te.reduce_axis((0, 5), name="rx")
    out = te.compute(
        (x - 4, y - 4),
        lambda i, j: data[i - 2, j] * weight[0, 2] + data[i - 1, j] * weight[1, 2] + \
                    data[i, j - 2] * weight[2, 0] + data[i, j - 1] * weight[2, 1] + data[i, j] * weight[2, 2] + \
                    data[i, j + 1] * weight[2, 3] + data[i, j + 2] * weight[2, 4]+ \
                    data[i + 1, j] * weight[3, 2] + data[i + 2, j] * weight[4, 2],
        name="compute"
    )
    return te.compute(
        data.shape,
        lambda i, j:
            te.if_then_else(
                te.all(i > 1, i < x - 2, j > 1, j < x - 2),
                out[i - 2, j - 2],
                tvm.tir.const(0, data.dtype)
            ),
        name="out"
    )

def star1d4r_regular(data, weight):
    L = data.shape[0]
    assert weight.shape[0] == 9
    rx = te.reduce_axis((0, 9), name="rx")
    out = te.compute(
        (L - 8, ),
        lambda i: te.sum(data[i + rx] * weight[rx], axis=[rx]),
        name="compute"
    )
    return te.compute(
        data.shape,
        lambda i:
            te.if_then_else(
                te.all(i > 3, i < L - 4),
                out[i - 4],
                tvm.tir.const(0, data.dtype)
            ),
        name="out"
    )
