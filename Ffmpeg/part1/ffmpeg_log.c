// 
// Created by Insomnia on 2019/4/24.
//

#include <stdio.h>
#include <libavutil/log.h>

int main() {
    // complie： clang -g -o ffmpeg_log ffmpeg_log.c -lavutil
    av_log_set_level(AV_LOG_DEBUG);
    av_log(NULL, AV_LOG_INFO, "Hello World!\n");
    return 0;
}