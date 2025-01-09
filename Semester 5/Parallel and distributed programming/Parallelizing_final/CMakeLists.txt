cmake_minimum_required(VERSION 3.27)
project(Parallelizing_final)

set(CMAKE_CXX_STANDARD 17)

add_executable(Parallelizing_final
        polynomial_sequential_karatsuba.cpp
        polynomial_sequential.cpp
        poly_parallel_karatsuba.cpp
        poly_parallel.cpp
)
