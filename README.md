# Artifact

## Code structure
```sh
|-- realworld_stencil 
|-- scripts
|   |-- evaluation_scripts
|   |   |-- change.py
|   |   |-- my_run.py
|   |   |-- parsing_performance.py
|   |   |-- shape-inference.sh
|   |   `-- util.h
|   `-- figure_scripts
|       |-- overall_speedup.py for Figure7
|       |-- performance.py for Figure8(a)
|       |-- solution.py for Figure8(b)
|       `-- speedup_case_study.py for Figure9
|-- test_cases
|-- tvm-graph
```


## Software dependencies 

We provide both source codes on Github and docker images

## Build OpenEarth

Assuming llvm and openearth are installed in the root directory /.

First, clone llvm and openearth.

```sh
apt install git cmake python3 ninja-build 
PWD=`pwd`

git clone https://github.com/spcl/open-earth-compiler
git clone https://github.com/llvm/llvm-project llvm-openearth

PATH_TO_LLVM=$PWD/llvm-openearth

cd llvm-openearth
git checkout e59d336e75f4

cp ../open-earth-compiler/patches/runtime.patch ./
git apply runtime.patch
```

In docker, we already clone llvm, but we did't build it in order to reduce the size of the docker. So if you use docker provided by us, you can start here. 


Build llvm first before build openearth and set environment variables.

```sh
cd $PATH_TO_LLVM
mkdir build && cd build
cmake -G Ninja ../llvm -DLLVM_BUILD_EXAMPLES=OFF -DLLVM_TARGETS_TO_BUILD="host;NVPTX" -DCMAKE_INSTALL_PREFIX=. -DLLVM_ENABLE_PROJECTS="mlir;clang" -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_ENABLE_OCAMLDOC=OFF -DLLVM_ENABLE_BINDINGS=OFF -DLLVM_INSTALL_UTILS=ON -DMLIR_CUDA_RUNNER_ENABLED=ON
cmake --build .

echo "export PATH=$PATH_TO_LLVM/build/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$PATH_TO_LLVM/build/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc
```

Now build open-earth.

```sh
cd $PWD/open-earth-compiler
mkdir build $$ cd build 
PREFIX=$PATH_TO_LLVM/build
BUILD_DIR=$PATH_TO_LLVM/build

cmake -G Ninja .. -DMLIR_DIR=$PREFIX/lib/cmake/mlir -DLLVM_EXTERNAL_LIT=$BUILD_DIR/bin/llvm-lit
cmake --build . --target check-oec-opt
echo "export PATH=`pwd`/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
```

## Build tvm-graph
Since we implement the function IR based on TVM Relay, so we need to build TVM modified by us.


First, clone llvm and build it.


```sh
git clone https://github.com/llvm/llvm-project llvm-10-tvm
TVM_LLVM=`pwd`/llvm-10-tvm
cd llvm-10-tvm
git checkout release/10.x

sudo apt-get install -y python3 python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev

mkdir build && cd build
cmake -G ninja -DCMAKE_BUILD_TYPE=Release ../llvm
ninja
```

Clone TVM modified by us and build.

```sh

git clone --recursive tvm_graph_address
mkdir build && cd build
cp ../cmake/config.cmake ./

sed -i "s@USE_LLVM ON@USE_LLVM $TVM_LLVM/build/bin/llvm-config@g" config.cmake
echo "export PYTHONPATH=$TVM_HOME/python:\${PYTHONPATH}" >> ~/.bashrc
source ~/.bashrc
pip install numpy decoprator scipy attrs
```


## How to reproduce our results 
We have tested on a platform consisting of two Intel E5-2680 V4 CPUs with NVIDIA V100. The CUDA version is 11.7 and the driver version is 515.43.04.

Copy all files in scripts/evaluation_script into test_cases and copy shape_inference.sh into /tmp.

First, Go to directory scripts/evaluation_script.

```bash
bash setup_env.sh
```

Then go to directory `test_cases`.

```sh
python3 run.py
```

Test will run automaticly and for each mlir, it will create a directory named by mlir name. Tests will be runned and result will be stored in the directory.

Then run 

```
python3 parsing_performance.py
```

This script will get into each directory and parse performance and streamlist. It will generate performance_V100.json and streamlist_V100.json

In directory `scripts/figure_scripts`:

Run `python3 overall_speedup.py` for Figure7 (eva-overall-speedup-v100.pdf)

Run `python3 performance.py` for Figure8(a) (eva-overall-performance-v100-part.pdf)

Run `python3 solution.py` for Figure8(b) (eva-searching-v100-part.pdf)

To run realworld stencil, go to directory 
realworld_stencil and run 

```sh
python3 run_real.py
python3 parsing_performance.py
```
In directory `scripts/figure_scripts`:
Run `python3 speedup_case_study.py` for Figure9 (eva-speedup-case-study-V100.pdf)