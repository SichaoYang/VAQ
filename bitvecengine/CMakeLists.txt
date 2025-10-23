# add_library(
#   BitVecEngine SHARED
#   BitVecEngine.cpp
# )

find_package(Armadillo REQUIRED)
find_library(GLPK_LIBRARY glpk REQUIRED)
add_library(
  VAQ SHARED
  utils/Heap.cpp
  VAQ.cpp
)
target_link_directories(VAQ PUBLIC ${CMAKE_PREFIX_PATH}/lib)
target_link_libraries(VAQ PUBLIC armadillo glpk)

# Utils library
add_library(
  FPGrowth SHARED
  "utils/FPGrowth/fptree.cpp"
)

find_package(pybind11 REQUIRED)
pybind11_add_module(pyvaq VAQ_binding.cpp)
target_link_libraries(pyvaq PUBLIC VAQ FPGrowth)

FIND_PACKAGE(OpenMP)
IF(OPENMP_FOUND)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
ENDIF()

