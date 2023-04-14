import tvm
from tvm import te

def hypterm_1_flux_0(cons_1):
    L, M, N = cons_1.shape
    return te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -((0.8 * (cons_1[k, j, i + 1] - cons_1[k, j, i - 1]) - 0.2 * (cons_1[k, j, i + 2] - cons_1[k, j, i - 2]) + 0.038 * (cons_1[k, j, i + 3] - cons_1[k, j, i - 3]) - 0.0035 *(cons_1[k, j, i + 4] - cons_1[k, j, i - 4])) * 1),
                tvm.tir.const(0, dtype=cons_1.dtype)
            ),
            name="flux_0_stage0"
    )


def hypterm_2_flux_0(flux_0, cons_2):
    L, M, N = flux_0.shape
    update = te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -((0.8 * (cons_2[k, j, i + 1] - cons_2[k, j, i - 1]) - 0.2 * (cons_2[k, j, i + 2] - cons_2[k, j, i - 2]) + 0.038 * (cons_2[k, j, i + 3] - cons_2[k, j, i - 3]) - 0.0035 *(cons_2[k, j, i + 4] - cons_2[k, j, i - 4])) * 1),
                tvm.tir.const(0, dtype=cons_2.dtype)
            ),
            name="flux_0_stage1"
    )
    return flux_0 + update

def hypterm_3_flux_0(flux_0, cons_3):
    L, M, N = flux_0.shape
    update = te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -((0.8 * (cons_3[k, j, i + 1] - cons_3[k, j, i - 1]) - 0.2 * (cons_3[k, j, i + 2] - cons_3[k, j, i - 2]) + 0.038 * (cons_3[k, j, i + 3] - cons_3[k, j, i - 3]) - 0.0035 *(cons_3[k, j, i + 4] - cons_3[k, j, i - 4])) * 1),
                tvm.tir.const(0, dtype=cons_3.dtype)
            ),
            name="flux_0_stage1"
    )
    return flux_0 + update

def hypterm_1_flux_1(cons_1, q_1, q_4):
    L, M, N = cons_1.shape
    return te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -((0.8*(cons_1[k,j,i+1]*q_1[k,j,i+1]-cons_1[k,j,i-1]*q_1[k,j,i-1]+(q_4[k,j,i+1]-q_4[k,j,i-1]))-0.2*(cons_1[k,j,i+2]*q_1[k,j,i+2]-cons_1[k,j,i-2]*q_1[k,j,i-2]+(q_4[k,j,i+2]-q_4[k,j,i-2]))+0.038*(cons_1[k,j,i+3]*q_1[k,j,i+3]-cons_1[k,j,i-3]*q_1[k,j,i-3]+(q_4[k,j,i+3]-q_4[k,j,i-3]))-0.0035*(cons_1[k,j,i+4]*q_1[k,j,i+4]-cons_1[k,j,i-4]*q_1[k,j,i-4]+(q_4[k,j,i+4]-q_4[k,j,i-4])))*1),
                tvm.tir.const(0, dtype=cons_1.dtype)
            ),
            name="flux_1_stage1"
    )


def hypterm_2_flux_1(flux_1, cons_1, q_2):
    L, M, N = flux_1.shape
    update = te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -(0.8*(cons_1[k,j+1,i]*q_2[k,j+1,i]-cons_1[k,j-1,i]*q_2[k,j-1,i])-0.2*(cons_1[k,j+2,i]*q_2[k,j+2,i]-cons_1[k,j-2,i]*q_2[k,j-2,i])+0.038*(cons_1[k,j+3,i]*q_2[k,j+3,i]-cons_1[k,j-3,i]*q_2[k,j-3,i])-0.0035*(cons_1[k,j+4,i]*q_2[k,j+4,i]-cons_1[k,j-4,i]*q_2[k,j-4,i])),
                tvm.tir.const(0, dtype=flux_1.dtype)
            ),
            name="flux_1_stage2"
    )
    return flux_1 + update

def hypterm_3_flux_1(flux_1, cons_1, q_3):
    L, M, N = flux_1.shape
    update = te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -(0.8*(cons_1[k+1,j,i]*q_3[k+1,j,i]-cons_1[k-1,j,i]*q_3[k-1,j,i])-0.2*(cons_1[k+2,j,i]*q_3[k+2,j,i]-cons_1[k-2,j,i]*q_3[k-2,j,i])+0.038*(cons_1[k+3,j,i]*q_3[k+3,j,i]-cons_1[k-3,j,i]*q_3[k-3,j,i])-0.0035*(cons_1[k+4,j,i]*q_3[k+4,j,i]-cons_1[k-4,j,i]*q_3[k-4,j,i])),
                tvm.tir.const(0, dtype=flux_1.dtype)
            ),
            name="flux_1_stage3"
    )
    return flux_1 + update


def hypterm_1_flux_2(cons_2, q_1):
    L, M, N = cons_2.shape
    return te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -((0.8*(cons_2[k,j,i+1]*q_1[k,j,i+1]-cons_2[k,j,i-1]*q_1[k,j,i-1])-0.2*(cons_2[k,j,i+2]*q_1[k,j,i+2]-cons_2[k,j,i-2]*q_1[k,j,i-2])+0.038*(cons_2[k,j,i+3]*q_1[k,j,i+3]-cons_2[k,j,i-3]*q_1[k,j,i-3])-0.0035*(cons_2[k,j,i+4]*q_1[k,j,i+4]-cons_2[k,j,i-4]*q_1[k,j,i-4]))*1),
                tvm.tir.const(0, dtype=cons_2.dtype)
            ),
            name="flux_2_stage1"
    )


def hypterm_2_flux_2(flux_2, cons_2, q_2, q_4):
    L, M, N = flux_2.shape
    update = te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -(0.8*(cons_2[k,j+1,i]*q_2[k,j+1,i]-cons_2[k,j-1,i]*q_2[k,j-1,i]+(q_4[k,j+1,i]-q_4[k,j-1,i]))-0.2*(cons_2[k,j+2,i]*q_2[k,j+2,i]-cons_2[k,j-2,i]*q_2[k,j-2,i]+(q_4[k,j+2,i]-q_4[k,j-2,i]))+0.038*(cons_2[k,j+3,i]*q_2[k,j+3,i]-cons_2[k,j-3,i]*q_2[k,j-3,i]+(q_4[k,j+3,i]-q_4[k,j-3,i]))-0.0035*(cons_2[k,j+4,i]*q_2[k,j+4,i]-cons_2[k,j-4,i]*q_2[k,j-4,i]+(q_4[k,j+4,i]-q_4[k,j-4,i]))),
                tvm.tir.const(0, dtype=flux_2.dtype)
            ),
            name="flux_2_stage2"
    )
    return flux_2 + update

def hypterm_3_flux_2(flux_2, cons_2, q_3):
    L, M, N = flux_2.shape
    update = te.compute(
        (L, M, N),
        lambda k, j, i:
            te.if_then_else(
                te.all(k >= 4, k <= L - 5, j >= 4, j <= M - 5, i >= 4, i <= N - 5),
                -(0.8*(cons_2[k+1,j,i]*q_3[k+1,j,i]-cons_2[k-1,j,i]*q_3[k-1,j,i])-0.2*(cons_2[k+2,j,i]*q_3[k+2,j,i]-cons_2[k-2,j,i]*q_3[k-2,j,i])+0.038*(cons_2[k+3,j,i]*q_3[k+3,j,i]-cons_2[k-3,j,i]*q_3[k-3,j,i])-0.0035*(cons_2[k+4,j,i]*q_3[k+4,j,i]-cons_2[k-4,j,i]*q_3[k-4,j,i])),
                tvm.tir.const(0, dtype=flux_2.dtype)
            ),
            name="flux_2_stage3"
    )
    return flux_2 + update
