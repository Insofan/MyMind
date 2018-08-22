cmake_minimum_required(VERSION 3.10)
include_directories(${PROJECT_SOURCE_DIR}/include)
target_link_libraries(List ${PROJECT_SOURCE_DIR}/lib)
project(FFmpegPlayerDemo)

set(CMAKE_CXX_STANDARD 11)

add_executable(FFmpegPlayerDemo main.cpp)

