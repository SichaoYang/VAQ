cmake_minimum_required(VERSION 3.13)

project(BitVecEngine)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "-I${CMAKE_PREFIX_PATH}/include -Wall -Wextra -Wpedantic -Wno-psabi -Wno-sign-compare")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

IF(NOT OPTIMIZATION_LEVEL)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -ffast-math -mfma")
  add_definitions(-DVAQ_OPTIMIZE)
  add_definitions(-march=haswell)
  add_definitions(-mavx -mavx2)
ELSEIF(OPTIMIZATION_LEVEL STREQUAL "full")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2")
ELSEIF(OPTIMIZATION_LEVEL STREQUAL "aggressive")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")
ELSEIF(OPTIMIZATION_LEVEL STREQUAL "generic")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
ENDIF()

include_directories(external/eigen)

add_subdirectory(bitvecengine)

IF(BUILD_TESTING)
  add_subdirectory(test)
  add_custom_target(test COMMAND Test --durations yes)
ENDIF()

add_definitions(-DEIGEN_USE_BLAS -DEIGEN_USE_LAPACKE)
add_definitions(-DEIGEN_DONT_PARALLELIZE)

find_package(OpenMP)
IF(OPENMP_FOUND)
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
ENDIF()

install(TARGETS VAQ FPGrowth DESTINATION lib)
IF(DEFINED ENV{SP_DIR})
install(TARGETS pyvaq DESTINATION $ENV{SP_DIR})
ELSE()
install(TARGETS pyvaq DESTINATION lib)
ENDIF()
