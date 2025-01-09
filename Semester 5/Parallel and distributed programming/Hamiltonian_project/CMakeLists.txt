cmake_minimum_required(VERSION 3.27)
project(Hamiltonian_project)

set(CMAKE_CXX_STANDARD 17)

add_executable(Hamiltonian_project main.cpp
        Graph.cpp
        Vertex.cpp
        GraphGenerator.h)
