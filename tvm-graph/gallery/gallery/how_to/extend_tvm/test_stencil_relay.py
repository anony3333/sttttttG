import numpy as np
import tvm
from tvm import relay

def example():
    data = relay.var("data", shape=(12, 12))
    weight = relay.var("weight", shape=(3, 3))
    out = relay.stencil.star2d2r(data, weight)
    return relay.Function([data, weight], out), (12, 12), (3, 3)

def example2():
    data = relay.var("data", shape=(10,))
    weight = relay.var("weight", shape=(9,))
    out = relay.stencil.star1d4r(data, weight, regular=True, tag="abc")
    return relay.Function([data, weight], out), (10,), (9,)

def example3():
    L, M, N = 12, 12, 12
    shape = (L, M, N)
    cons_1 = relay.var("cons_1", shape=shape)
    cons_2 = relay.var("cons_2", shape=shape)
    cons_3 = relay.var("cons_3", shape=shape)
    flux_0 = relay.stencil.grid1stencil(cons_1, "flux_0_stage0")
    flux_0 = relay.stencil.grid2stencil(flux_0, cons_2, "flux_0_stage1")
    flux_0 = relay.stencil.grid2stencil(flux_0, cons_3, "flux_0_stage2")
    return flux_0, shape

# f, data_shape, weight_shape = example()
# f, data_shape, weight_shape = example2()
f, grid_shape = example3()
mod = tvm.IRModule.from_expr(f)
mod = relay.transform.InferType()(mod)

print(mod)

with tvm.transform.PassContext(opt_level=3):
    executor = relay.build_module.create_executor(
        "graph", mod, tvm.cpu(0), "llvm"
    ).evaluate()

dtype="float32"
cons_1 = np.random.random(grid_shape).astype(dtype)
cons_2 = np.random.random(grid_shape).astype(dtype)
cons_3 = np.random.random(grid_shape).astype(dtype)
print("input")
print(cons_1)
tvm_output = executor(tvm.nd.array(cons_1), tvm.nd.array(cons_2), tvm.nd.array(cons_3)).numpy()
print("output")
print(tvm_output[5, 5, 5])
