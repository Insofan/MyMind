// 
// Created by Insomnia on 2019/4/24.
//


#include <libavformat/avformat.h>

int main(int argc, char *argv[]) {
    // cmd: clang -g -o ffmpeg_del ffmpeg_file.c `pkg-config --libs libavformat`
    int ret;
    ret = avpriv_io_delete("./mytestfile.txt");
    if (ret < 0) {
        av_log(NULL, AV_LOG_ERROR, "Faile del file\n");
    }

    return 0;
}