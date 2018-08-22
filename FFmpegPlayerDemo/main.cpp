#include <iostream>

extern "C" {
#include <libavformat/avformat.h>
#include <libavcodec/avcodec.h>
}

int main() {
    std::cout << "Hello, World!" << std::endl;
    std::cout << avcodec_configuration() << std::endl;
    return 0;
}