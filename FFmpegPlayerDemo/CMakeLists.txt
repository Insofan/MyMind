cmake_minimum_required(VERSION 3.10)

project(FFmpegPlayerDemo)

include_directories(./include/)
link_directories(./lib/)

set(SOURCE_FILE main.cpp)

add_executable(FFmpegPlayerDemo ${SOURCE_FILE})
target_link_libraries(
        FFmpegPlayerDemo
        avcodec
        avdevice
        avfilter
        avformat
        avresample
        avutil
        postproc
        swresample
        swscale
)