from collections import defaultdict
from typing import List
import sys


class Kernel:
    def __init__(self, name, variables: list = None):
        self.name = name
        self.variables = variables
        # self.output_variables = output_varibles
    def __str__(self):
        return f"name : {self.name}; variables : {self.variables}"


class GenMain:
    def __init__(self, domain_size=64, halo_width = 4, variables=[], kernels: List[Kernel] = None, stream_list=[], output_on=True):
        self.domain_size = domain_size
        self.halo_width = halo_width
        self.kernels = kernels
        self.stream_list = stream_list
        self.sync_var_length = defaultdict(int)
        self.run_step = 1
        self.stream_size = 0
        self.output_on = output_on

        self.init_stream_list(stream_list)
        self.variables = variables  # dict key all_varibles, in_varibles, mid_varibles, useless_varibles
        self.all_variables = self.variables['all_variables']
        self.in_variables = self.variables['in_variables']
        self.out_variables = self.variables['out_variables']
        self.mid_variables = self.variables['mid_variables']
        self.useless_variables = self.variables['useless_variables']

        self.code = []
        self.name2kernel = {}
        for kernel in kernels:
            self.name2kernel[kernel.name] = kernel

    def init_stream_list(self, stream_list):
        self.stream_size = len(stream_list)
        for index, stream in enumerate(stream_list):
            for ele in stream:
                if isinstance(ele, str) and ele.startswith("sync_"):
                    self.sync_var_length[ele] += 1

    def gen_struct_parameter(self, varibles: dict):
        paras_list = [f'Storage{var_dim}D {var_name};' for var_name, var_dim in varibles.items()]
        paras = "\n  ".join(paras_list)
        struct_parameter = \
            f'''
struct parameter
{{
  {paras}
}};
'''
        self.code.append(struct_parameter)

    def gen_header(self, domain_size, halo_width):
        sync_vars = [f'std::atomic<int> {k}(0);' for k in self.sync_var_length]
        sync_vars_str = "\n".join(sync_vars)
        header = \
            f'''
#include <cmath>
#include <chrono>
#include <atomic>

// define the domain size and the halo width
int32_t domain_size = {domain_size};
int32_t domain_height = {domain_size};
int32_t halo_width = {halo_width};
const int N = 1 << 20;

typedef double ElementType;
std::atomic<int> START(0);
{sync_vars_str}
#include "util.h"

'''
        self.code.append(header)
        return header

    def gen_kernel_def(self):
        single_kernel_defs = []
        for ken in self.kernels:
            params = []
            for k in ken.variables:
                params.append("Storage" + str(self.all_variables[k]) + "D *")
            params = ", ".join(params)
            single_kernel_def = f"void _mlir_ciface_{ken.name}({params});"
            single_kernel_defs.append(single_kernel_def)

        kernel_def = \
            '''
extern "C" {
  ${single_kernel_defs}
}
'''
        kernel_def = kernel_def.replace("${single_kernel_defs}", "\n".join(single_kernel_defs))
        self.code.append(kernel_def)
        return kernel_def

    # 生成打印存储的函数printStorage
    def gen_printStorage(self):
        printStorage = \
            '''
void printStorage(Storage3D &ref) {

for (int i = 0; i < domain_size; i++) 
      for (int j = 0; j < domain_size; j++) 
          for (int k = 0; k < domain_height; k++) {
              std::cout << ref(i,j,k) << std::endl;
          }
}
'''
        self.code.append(printStorage)

        return printStorage

    def gen_warmup_kernel(self):
        warmup_kernel = \
            '''
__global__ void kernel(float *x, int n)
{
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    for (int i = tid; i < n; i += blockDim.x * gridDim.x) {
        x[i] = sqrt(pow(3.14159,i));
    }
}
'''
        self.code.append(warmup_kernel)

    def gen_launch_kernels(self):
        for index, stream in enumerate(self.stream_list):
            self.code.append(self.gen_launch_kernel(stream, index))

    def gen_launch_kernel(self, stream, stream_index):
        def gen_synchronize_var(var):
            statement = \
                f'''
    cudaStreamSynchronize(0);
    {var}+=1;
    while({var}!={self.sync_var_length[var]});
'''
            return statement

        def gen_kernel_call(var):
            kernel = self.name2kernel[var]
            varibles = kernel.variables

            l = list(map(lambda x: "&" + x, varibles))
            params = ", ".join(l)

            call = f"_mlir_ciface_{kernel.name}({params});"
            return call

        def gen_single_call(var):
            if var.startswith("sync_"):
                return gen_synchronize_var(var)
            return gen_kernel_call(var)

        z = set()
        for var in stream:
            if isinstance(var, str) and not var.startswith("sync_"):
                z = z | set(self.name2kernel[var].variables)

        var_assign_statement = [f'Storage{self.all_variables[var_name]}D {var_name} = p->{var_name};' for var_name in
                                sorted(list(z))]
        var_assign_statement_str = "\n  ".join(var_assign_statement)

        calls = [gen_single_call(var) for var in stream]
        calls_str = "\n    ".join(calls)

        launch_kernel = \
            f'''
void *launch_kernel_{stream_index}(void* arg)
{{   
    struct parameter *p =(parameter*)arg;
    {var_assign_statement_str}
    float *data;
    cudaMalloc(&data, N * sizeof(float));
    kernel<<<1, 64>>>(data, N);
    cudaStreamSynchronize(0);
    START+=1;
    while(START!={self.stream_size});
    {calls_str}
    cudaStreamSynchronize(0);
    return NULL;

}}
'''
        # self.code.append(launch_kernel)
        return launch_kernel

    # 生成main函数的前半部分
    def gen_main_start(self):

        main_part1 = \
            r'''
int main(int argc, char **argv) {

  if(argc == 3) {
      domain_size = atoi(argv[1]);
      domain_height = atoi(argv[2]);
  } else if (argc == 1) {
  } else {
      std::cout << "Either provide the domain size and domain height like this \"./kernel 128 60\" or do not provide any arguments at all in which case the program is ran with domain size 64 and domain heigh 60" << std::endl;
      exit(1);
  }

  const int32_t sizes1D = domain_size + 2 * halo_width;
  const std::array<int32_t, 3> sizes3D = {domain_size + 2 * halo_width,
                                      domain_size + 2 * halo_width,
                                      domain_height + 2 * halo_width};
'''
        self.code.append(main_part1)
        return main_part1

    def gen_var_def(self, varibles):
        struct_para = "  struct parameter *p =  new parameter;"
        self.code.append(struct_para)

        var_def = [f'p->{var_name} = allocateStorage(sizes{var_dim}D);' for var_name, var_dim in varibles.items()]
        self.code.append("\n  ".join(var_def))

    def gen_init_statement(self):
        init_values = [3.2, 7.0, 2.5, 6.1, 3.0, 2.3]
        out_init_statement = '  initValue(${var_name}, ${init_val}, domain_size, domain_height);'
        in_init_statement = '  fillMath(${init_values}, ${var_name}, domain_size, domain_height);'
        index = 0
        for k, v in self.all_variables.items():
            if k in self.in_variables:
                init_values_str = ', '.join(list(map(lambda x: str(x + index), init_values)))
                self.code.append(in_init_statement.replace('${var_name}', "p->" + k).replace('${init_values}', init_values_str))
                index += 1

            # elif k in (self.out_variables | self.mid_variables):
            #     self.code.append(out_init_statement.replace('${var_name}',"p->"+  k).replace('${init_val}', "0"))

    # 生成将所有内存
    def gen_mem2d(self):
        mem2d_copy = ' memH2D(p->${var_name}, true);'
        mem2d_memset = ' memH2D(p->${var_name}, false);'
        
        # for kernel in self.kernels:
        #     varibles = kernel.variables
        for k in sorted(list(self.all_variables.keys() - self.useless_variables)):
            if k in self.in_variables:
                mem2d_gen = mem2d_copy.replace("${var_name}", k)
            else:
                mem2d_gen = mem2d_memset.replace("${var_name}", k)
            self.code.append(mem2d_gen)

    #  生成pthread调用的相关代码
    def gen_timing_and_run(self):
        def gen_init_device_mem():
            return "\n    ".join([f"initDeviceMemZero(p->{out_var});" for out_var in self.out_variables])

        def gen_pthread_create():
            create = []
            for index, stream in enumerate(self.stream_list):
                create.append(f'pthread_create(&threads[{index}], NULL, launch_kernel_{index}, p);')
            return "\n    ".join(create)

        def gen_pthread_join():
            join = []
            for index, stream in enumerate(self.stream_list):
                join.append(f'pthread_join(threads[{index}], NULL);')

            return "\n    ".join(join)

        def init_sync_vars():
            sync_vars = ["START"]
            sync_vars += list(self.sync_var_length.keys())
            init = [f"{var}=0;" for var in sync_vars]
            return "\n    ".join(init)

        timing = \
            f'''
  cudaEvent_t start, stop;
  float elapsed = 0.0;
  // double sum=0.0;
  // double min_time = 100000.0;
  // double max_time = 0.0;
  pthread_t threads[8];
  {gen_init_device_mem()}

  int steps = {self.run_step};
  for(int i = 0; i < steps; i++){{
    {init_sync_vars()}
    {gen_pthread_create()}
    while(START!={self.stream_size});

    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);
    {gen_pthread_join()}
    cudaDeviceSynchronize();

    cudaEventRecord(stop, 0);
    cudaEventSynchronize(start);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&elapsed, start, stop);

    std::cout << "time : " << elapsed << std::endl;
  }}'''

        self.code.append(timing)

    def gen_mem_out(self):

        for out in self.out_variables:
            self.code.append(f"  memD2H(p->{out});")
            self.code.append(f'  printf("-------{out}-------");')

            self.code.append(f"  printStorage(p->{out});")

            self.code.append(f"  freeStorage(p->{out});")

           

    def gen_main_end(self):
        main_end = \
            '''
  return 0;
}
'''

        self.code.append(main_end)

    def gen(self, file=sys.stdout):
        self.gen_header(self.domain_size, self.halo_width)
        self.gen_kernel_def()
        self.gen_printStorage()
        self.gen_warmup_kernel()
        self.gen_struct_parameter(self.all_variables)
        self.gen_launch_kernels()
        self.gen_main_start()
        self.gen_var_def(self.all_variables)
        self.gen_init_statement()
        self.gen_mem2d()
        self.gen_timing_and_run()
        if self.output_on:
            self.gen_mem_out()
        self.gen_main_end()
        print("\n".join(self.code), file=file)


if __name__ == '__main__':
    kernel_name = "fastwavesuv"  # kernel 名
    varibles = {
        'uin': 3,
        'utens': 3,
        'vin': 3,
        'vtens': 3,
        'wgtfac': 3,
        'ppuv': 3,
        'hhl': 3,
        'rho': 3,
        'uout': 3,
        'vout': 3,
        'fx': 1
    }  # 变量名和形状，按照mlir调用顺序
    output_varibles = ['uout', 'vout']  # 结果变量
    stream_list = []

    k1 = Kernel(kernel_name, varibles, output_varibles)
    main = GenMain(64, [k1])
    main.gen()
