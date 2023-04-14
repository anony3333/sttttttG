import numpy as np
import tvm
from tvm import relay
from tvm.relay.transform.dnn_fusion import StencilFuseOps, MappingType, PrintOpType, register_tag_pattern
from tvm.relay.transform.mlir import MLIRCodeGen


register_tag_pattern("stencil_19", MappingType.Parallel)
register_tag_pattern("stencil_20", MappingType.Parallel)

def example(dim_size):
    data_14 = relay.var("data_14", shape=(dim_size, dim_size, dim_size))
    data_15 = relay.var("data_15", shape=(dim_size, dim_size, dim_size))
    data_16 = relay.var("data_16", shape=(dim_size, dim_size, dim_size))
    data_17 = relay.var("data_17", shape=(dim_size, dim_size, dim_size))
    data_18 = relay.var("data_18", shape=(dim_size, dim_size, dim_size))
    data_19 = relay.var("data_19", shape=(dim_size, dim_size, dim_size))
    data_20 = relay.var("data_20", shape=(dim_size, dim_size, dim_size))
    data_21 = relay.var("data_21", shape=(dim_size, dim_size, dim_size))

    data_22 = relay.stencil.grid1stencil(data_14, tag="stencil_22")
    data_23 = relay.stencil.grid2mostencil(data_14, data_22, tag="stencil_23", output_num=4)
    data_23_0, data_23_1, data_23_2, data_23_3 = relay.TupleGetItem(data_23, 0), relay.TupleGetItem(data_23, 1), relay.TupleGetItem(data_23, 2), relay.TupleGetItem(data_23, 3)
    data_24 = relay.stencil.grid6stencil(data_14, data_16, data_23_0, data_23_1, data_23_2, data_23_3, tag="stencil_24")
    data_25 = relay.stencil.grid2stencil(data_20, data_24, tag="stencil_25")
    data_26 = relay.stencil.grid4stencil(data_14, data_21, data_25, data_18, tag="stencil_26")

    data_27 = relay.stencil.grid1stencil(data_26, tag="stencil_27")
    data_28 = relay.stencil.grid2mostencil(data_26, data_27, tag="stencil_28", output_num=4)
    data_28_0, data_28_1, data_28_2, data_28_3 = relay.TupleGetItem(data_28, 0), relay.TupleGetItem(data_28, 1), relay.TupleGetItem(data_28, 2), relay.TupleGetItem(data_28, 3)
    data_29 = relay.stencil.grid6stencil(data_26, data_15, data_28_0, data_28_1, data_28_2, data_28_3, tag="stencil_29")

    data_30 = relay.stencil.grid1stencil(data_14, tag="stencil_30")
    data_31 = relay.stencil.grid2mostencil(data_14, data_30, tag="stencil_31", output_num=4)
    data_31_0, data_31_1, data_31_2, data_31_3 = relay.TupleGetItem(data_31, 0), relay.TupleGetItem(data_31, 1), relay.TupleGetItem(data_31, 2), relay.TupleGetItem(data_31, 3)
    data_32 = relay.stencil.grid6stencil(data_14, data_15, data_31_0, data_31_1, data_31_2, data_31_3, tag="stencil_32")

    data_33 = relay.stencil.grid2stencil(data_19, data_32, tag="stencil_33")
    data_34 = relay.stencil.grid4stencil(data_14, data_21, data_33, data_17, tag="stencil_34")
    data_35 = relay.stencil.grid1stencil(data_34, tag="stencil_35")
    data_36 = relay.stencil.grid2mostencil(data_34, data_35, tag="stencil_36", output_num=4)
    data_36_0, data_36_1, data_36_2, data_36_3 = relay.TupleGetItem(data_36, 0), relay.TupleGetItem(data_36, 1), relay.TupleGetItem(data_36, 2), relay.TupleGetItem(data_36, 3)
    data_37 = relay.stencil.grid6stencil(data_34, data_16, data_36_0, data_36_1, data_36_2, data_36_3, tag="stencil_37")

    data_38 = relay.stencil.grid3stencil(data_29, data_32, data_19, tag="stencil_38")
    data_39 = relay.stencil.grid3stencil(data_37, data_24, data_20, tag="stencil_39")

  
    return relay.Function([data_14, data_15, data_16, data_17, data_18, data_19, data_20, data_21], relay.Tuple([data_26, data_34, data_38, data_32, data_39, data_24]))


# f = example(512)

# mod = tvm.IRModule.from_expr(f)
# mod = relay.transform.InferType()(mod)
# mod = PrintOpType()(mod)
# mod = StencilFuseOps()(mod)

# print(mod)

codegen = MLIRCodeGen()

with open("new_fvtp2d.mlir", "r") as f:
    mlir_code = f.readlines()
codegen.from_mlir(mlir_code)
codegen.fuse_op()
# print(codegen.ir_module)
# codegen.codegen()
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
