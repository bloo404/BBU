cmake_minimum_required(VERSION 3.21)
project(Project_5_SortedBag_linked_representation_dynamic_allocation)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(Project_5_SortedBag_linked_representation_dynamic_allocation
        App.cpp
        ExtendedTest.cpp
        ExtendedTest.h
        ShortTest.cpp
        ShortTest.h
        SortedBag.cpp
        SortedBag.h
        SortedBagIterator.cpp
        SortedBagIterator.h)
