import numpy as np
import tvm
from tvm import relay
from tvm.relay.transform.dnn_fusion import StencilFuseOps, MappingType, PrintOpType, register_tag_pattern
from tvm.relay.transform.mlir import BuildGraph, MLIRCodeGen

register_tag_pattern("stencil_20", MappingType.OneToOne)
register_tag_pattern("stencil_21", MappingType.OneToOne)
register_tag_pattern("stencil_22", MappingType.Parallel)
register_tag_pattern("stencil_23", MappingType.Parallel)

def example(dim_size):
    data_11 = relay.var("data_11", shape=(dim_size, dim_size, dim_size))
    data_12 = relay.var("data_12", shape=(dim_size, dim_size, dim_size))
    data_13 = relay.var("data_13", shape=(dim_size, dim_size, dim_size))
    data_14 = relay.var("data_14", shape=(dim_size, dim_size, dim_size))
    data_15 = relay.var("data_15", shape=(dim_size, dim_size, dim_size))
    data_16 = relay.var("data_16", shape=(dim_size, dim_size, dim_size))
    data_17 = relay.var("data_17", shape=(dim_size, dim_size, dim_size))
    data_18 = relay.var("data_18", shape=(dim_size, dim_size, dim_size))
    data_19 = relay.var("data_19", shape=(1, dim_size, 1))

    data_20 = relay.stencil.grid2stencil(data_15, data_16, tag="stencil_20")
    data_21 = relay.stencil.grid1stencil(data_20, tag="stencil_21")
    data_22 = relay.stencil.grid3stencil(data_16, data_21, data_17, tag="stencil_22")
    data_23 = relay.stencil.grid3stencil(data_16, data_21, data_17, tag="stencil_23")
    data_24 = relay.stencil.grid5stencil(data_11, data_12, data_22, data_18, data_19, tag="stencil_24")
    data_25 = relay.stencil.grid4stencil(data_13, data_14, data_23, data_18, tag="stencil_25")

    return relay.Function([data_11, data_12, data_13, data_14, data_15, data_16, data_17, data_18, data_19], relay.Tuple([data_24, data_25]))


f = example(512)

mod = tvm.IRModule.from_expr(f)
mod = relay.transform.InferType()(mod)
# mod = PrintOpType()(mod)
mod = StencilFuseOps()(mod)

# BuildGraph().get_call_list(mod.functions[mod.get_global_var("main")])
codegen = MLIRCodeGen()

with open("fastwavesuv.mlir", "r") as f:
    mlir_code = f.readlines()
codegen.from_mlir(mlir_code)
codegen.fuse_op()
# codegen.codegen()
# print(mod)
exit(0)
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
