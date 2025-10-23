#!/bin/bash
set -ex

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PREFIX -DCMAKE_INSTALL_PREFIX=$PREFIX
# With testing: cmake .. -DBUILD_TESTING=ON
# With debug: cmake .. -D=DCMAKE_BUILD_TYPE=Debug
# With optimization level option {O2: full, O3: aggressive (default)}: cmake .. -DOPTIMIZATION_LEVEL=full
# Without optimization: cmake .. -DOPTIMIZATION_LEVEL=generic
make
make -j
make install
