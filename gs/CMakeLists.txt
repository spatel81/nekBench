project(gs-bench)

add_executable(gs-bench
  main.cpp
  ping_pong.cpp
  mygs.cpp
  ${CMAKE_SOURCE_DIR}/core/timer.cpp
  ${CMAKE_SOURCE_DIR}/core/meshSetup.cpp
  ${CMAKE_SOURCE_DIR}/core/meshBasis.cpp
  ${CMAKE_SOURCE_DIR}/core/setupAide.cpp
)

target_include_directories(gs-bench PUBLIC ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(gs-bench 
  PUBLIC
    MPI::MPI_C 
    libocca
    ogs
    BLAS::BLAS
    LAPACK::LAPACK
)

# target_compile_definitions(gs-bench 
#   PUBLIC
#     "USE_OCCA_MEM_BYTE_ALIGN=64"
#     "dfloat=double"
#     "dfloatString=\"double\""
#     "dfloatFormat=\"%lf\""
#     "dlong=long int"
#     "dlongString=\"long int\""
#     "dlongFormat=\"%ld\""
#     "hlong=long long int"
#     "hlongString=\"long long int\""
#     "hlongFormat=\"%lld\""
#     "MPI_DFLOAT=MPI_DOUBLE"
#     "MPI_DLONG=MPI_LONG_INT"
#     "MPI_HLONG=MPI_LONG_LONG_INT"
# )

install(TARGETS gs-bench RUNTIME DESTINATION ".")
install(FILES gs_dummy.okl DESTINATION ".")