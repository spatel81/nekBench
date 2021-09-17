#!/bin/bash
set -x
#-----
BUILD_TYPE=Release
PREFIX_PATHS="${NVHPC_ROOT}/cuda;${NVHPC_ROOT}/math_libs"

CXXFLAGS="-pgf90libs"
ENABLE_OPENMP="OFF"

# Default build parameters
: ${BUILD_DIR:=`pwd`/build}
: ${INSTALL_DIR:=`pwd`/install}
: ${BUILD_TYPE:="RelWithDebInfo"}

: ${CC:="gcc"}
: ${CXX:="g++"}
: ${FC:="gfortran"}

: ${MPICC:="mpicc"}
: ${MPICXX:="mpicxx"}
: ${MPIFC:="mpif77"}

: ${EXTERNAL_BLASLAPACK:="ON"}

# OCCA Configuration
: ${ENABLE_DPCPP:="ON"}
: ${ENABLE_OPENCL:="ON"}
: ${ENABLE_CUDA:="ON"}
: ${ENABLE_HIP="ON"}
: ${ENABLE_OPENMP="ON"}
: ${ENABLE_METAL="OFF"}
: ${ENABLE_MPI="OFF"}

rm -rf ${BUILD_DIR} ${INSTALL_DIR}

cmake -S . -B ${BUILD_DIR} \
  -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
  -DCMAKE_PREFIX_PATH=${PREFIX_PATHS} \
  -DCMAKE_C_COMPILER=${CC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DCMAKE_Fortran_COMPILER=${FC} \
  -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
  -DMPI_C_COMPILER=${MPICC} \
  -DMPI_CXX_COMPILER=${MPICXX} \
  -DMPI_Fortran_COMPILER=${MPIFC} \
  -DEXTERNAL_BLASLAPACK=${EXTERNAL_BLASLAPACK} \
  -DENABLE_OPENCL=${ENABLE_OPENCL} \
  -DENABLE_CUDA=${ENABLE_CUDA} \
  -DENABLE_HIP=${ENABLE_HIP} \
  -DENABLE_OPENMP=${ENABLE_OPENMP} \
  -DENABLE_METAL=${ENABLE_METAL} \
  -DENABLE_MPI=${ENABLE_MPI}

cmake --build ${BUILD_DIR} --parallel 4 && \
cmake --install ${BUILD_DIR} --prefix ${INSTALL_DIR}