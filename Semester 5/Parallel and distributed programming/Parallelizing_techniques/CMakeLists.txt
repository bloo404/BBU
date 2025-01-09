cmake_minimum_required(VERSION 3.24)
project(Parallelizing_techniques)

set(CMAKE_CXX_STANDARD 17)

add_executable(Parallelizing_techniques "polynomial_sequential.cpp" polynomial_sequential_karatsuba.cpp poly_parallel.cpp poly_parallel_karatsuba.cpp)
