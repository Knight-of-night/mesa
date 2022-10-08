#!/bin/bash
# .gitlab-ci/container/debian/x86_build-mingw-source-deps.sh
wd=$PWD
CMAKE_TOOLCHAIN_MINGW_PATH=$wd/.gitlab-ci/container/debian/x86_mingw-toolchain.cmake
mkdir -p ~/tmp
pushd ~/tmp

# Building LLVM
git clone --depth=1 \
https://github.com/llvm/llvm-project llvm-project

mkdir llvm-project/build
pushd llvm-project/build
cmake ../llvm \
-DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_MINGW_PATH \
-DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32/ \
-GNinja -DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CROSSCOMPILING=1 \
-DLLVM_ENABLE_RTTI=ON \
-DLLVM_ENABLE_PROJECTS="clang" \
-DLLVM_TARGETS_TO_BUILD="X86" \
-DLLVM_OPTIMIZED_TABLEGEN=TRUE \
-DLLVM_INCLUDE_UTILS=OFF \
-DLLVM_INCLUDE_RUNTIMES=OFF \
-DLLVM_INCLUDE_TESTS=OFF \
-DLLVM_INCLUDE_EXAMPLES=OFF \
-DLLVM_INCLUDE_GO_TESTS=OFF \
-DLLVM_INCLUDE_BENCHMARKS=OFF \
-DLLVM_BUILD_LLVM_C_DYLIB=OFF \
-DLLVM_ENABLE_DIA_SDK=OFF \
-DCLANG_BUILD_TOOLS=ON \

ninja install
popd

popd # ~/tmp

# Cleanup ~/tmp
rm -rf ~/tmp
