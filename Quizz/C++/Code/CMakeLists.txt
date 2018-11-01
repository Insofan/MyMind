cmake_minimum_required(VERSION 3.10)
project(Code)

set(CMAKE_CXX_STANDARD 11)

add_executable(Code main.cpp)
add_executable(Mutip Mutip.cpp)
add_executable(PointConst PointConst.cpp)
add_executable(ConstPointErr ConstPointErr.cpp)