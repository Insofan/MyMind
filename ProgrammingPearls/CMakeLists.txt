cmake_minimum_required(VERSION 3.10)
project(ProgrammingPearls)

set(CMAKE_CXX_STANDARD 11)

add_executable(ProgrammingPearls main.cpp)
add_executable(BitSort ch1/BitSort.cpp utils/RandomVec.cpp)
#add_executable(RandomVec )
