import numpy as np
import tvm
from tvm import relay
from tvm.relay.transform.dnn_fusion import StencilFuseOps, MappingType, PrintOpType, register_tag_pattern
from tvm.relay.transform.mlir import BuildGraph, MLIRCodeGen
from change import gen_mlir_file
import os
import shutil
import os.path
import copy
import signal
import subprocess
import time

import sys




mesh_size_list = [64, 128, 256, 512]
# mesh_size_list = [512]


# mlir_file_list = ['S9-I11-O3-E33.mlir']

mlir_file_list = [x for x in sorted(os.listdir()) if x.endswith('.mlir')]

# mlir_file_list = ['depart_canon.mlir','depart_canon-2.mlir', 'depart_canon-3.mlir','depart6_conon.mlir','depart7_conon.mlir']

HALO_WIDTH = 8
cwd = os.getcwd()
tag_list = ["StencilG", "baseline", "fuse-max", "parallel-max"]
def is_runned(f, index, mesh_size, halo_width, dirs):
    if index == 0:
        return False
    for dir in dirs:
        if "log" in dir and f"{tag_list[index]}" in dir and f"{mesh_size}-{halo_width}" in dir:
            print(f"{f[:-5]}-{mesh_size}-{halo_width}-{tag_list[index]} has been runned")
            return True
    return False

def bench():
    global HALO_WIDTH
    for f in mlir_file_list:
        assert f.endswith('.mlir')
        try:
            os.mkdir(os.path.join(cwd, f[:-5]))
        except:
            print('folder already exists')
            if os.path.exists(os.path.join(cwd, f[:-5], "done")):
                print(f[:-5] + "has been runned completely, continue")
                continue
            # pass
        f_stdout = open(os.path.join(cwd, f"time-{f[:-5]}.txt"), 'a')
        sys.stdout = f_stdout
        single_bench_start = time.time()
        shutil.copy(os.path.join(cwd, 'util.h'), os.path.join(cwd, f[:-5]))
        print(f'run {f[:-5]}')
        for mesh_size in mesh_size_list:
            mlir_code = gen_mlir_file(os.path.join(cwd, f), 64, 4, mesh_size, HALO_WIDTH)
            # with open(f"inline-{mesh_size}.mlir", 'w') as ff:
            #     print(mlir_code, file=ff)
            #     continue
            mlir_code = mlir_code.split("\n")
            os.chdir(os.path.join(cwd, f[:-5]))
            config_list = [(1, 1, 0), (0, 0, 0), (0, 0, 1), (0, 1, 0)]
            # config_list = [(1, 1, 0)]

            for index, config in enumerate(config_list):
                # print(mlir_code)
                # if is_runned(f, index, mesh_size, HALO_WIDTH, os.listdir()):
                #     continue
                codegen = MLIRCodeGen(mesh_size, HALO_WIDTH,FUSION = config[0], STREAM = config[1], INLINE = config[2], output_on=False)

                codegen.from_mlir(copy.copy(mlir_code), f[:-5])
                try:
                    codegen.fuse_op()
                except KeyboardInterrupt as interrupt:
                    raise interrupt
                except Exception as e:
                    print(f"config FUSION, STREAM, INLINE = {config} encounter a problem; continue to run")
                    print(e)
        os.mkdir(os.path.join(cwd, f[:-5], "done"))
        single_bench_end = time.time()
        print(f"bench {f[:-5]} spend {single_bench_end - single_bench_start}s")
        f_stdout.close()


def watch(gap = 0.1, output_path = "out.txt"):
    # if os.path.exists(output_path):
    #     os.remove(output_path)
    # f = open('/dev/null', 'w')
    with open('/dev/null', 'w') as f:
        watch_cmd = "watch -n 0.1"
        watch_cmd = watch_cmd.split()
        exec_cmd = "gpustat | grep GB | awk \'{print $6}\' | head -n 1 |tee -a " + output_path
        watch_cmd.append(exec_cmd)
        p = subprocess.Popen(watch_cmd, stdout=f)
    return p

def util():
    for f in mlir_file_list:
        if not os.path.exists(os.path.join(cwd, f[:-5], "done")):
            print(f"{f[:-5]} not finished")
            continue
        os.chdir(os.path.join(cwd, f[:-5]))
        now_cwd = os.getcwd()
        util_test_dir = [x for x in os.listdir() if x.startswith('512') and x.endswith('log')]
        for x in util_test_dir:
            print(f"test {x[:-4]}")
            with open(os.path.join(now_cwd, "utilization.txt"), 'a') as f1:
                print(f'test {x[:-4]}', file=f1)
            os.chdir(os.path.join(now_cwd, x))
            p = watch(0.1, os.path.join(now_cwd, "utilization.txt"))
            time.sleep(2)
            subprocess.call([f"./demo-{x[:-4]}"])
            time.sleep(5)
            p.send_signal(signal.SIGINT)
            with open(os.path.join(now_cwd, "utilization.txt"), 'a') as f1:
                print('+', file=f1)
                

bench()
# util()
# mesh_size = 256
# BuildGraph().get_call_list(mod.functions[mod.get_global_var("main")])
# codegen = MLIRCodeGen(mesh_size, 8,output_on=False)

# with open("fastwaves.mlir", "r") as f:

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
