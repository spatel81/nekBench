project(axhelm)

add_executable(axhelm 
  main.cpp 
  ${CMAKE_SOURCE_DIR}/core/meshBasis.cpp
)

target_include_directories(axhelm PUBLIC ${CMAKE_SOURCE_DIR}/core)
target_link_libraries(axhelm 
  PUBLIC
    MPI::MPI_C 
    libocca
    ${BLAS_LIBRARIES} 
    ${LAPACK_LIBRARIES}
)

add_compile_definitions(axhelm PUBLIC "DBP=\"\"")

install(TARGETS axhelm RUNTIME DESTINATION ".")
install(DIRECTORY kernel/ DESTINATION kernel)