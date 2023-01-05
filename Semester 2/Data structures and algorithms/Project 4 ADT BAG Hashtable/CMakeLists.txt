cmake_minimum_required(VERSION 3.21)
project(Project_4_ADT_BAG_Hashtable)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(Project_4_ADT_BAG_Hashtable
        App.cpp
        Bag.cpp
        Bag.h
        BagIterator.cpp
        BagIterator.h
        ExtendedTest.cpp
        ExtendedTest.h
        ShortTest.cpp
        ShortTest.h)
