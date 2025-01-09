cmake_minimum_required(VERSION 3.24)
project(Personal_project)

set(CMAKE_CXX_STANDARD 14)

include_directories(domain)

add_executable(Personal_project
        domain/Bill.cpp
        domain/Bill.h
        domain/Inventory.cpp
        domain/Inventory.h
        domain/Product.cpp
        domain/Product.h
        main.cpp)
