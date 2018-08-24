#include <iostream>


#define __STDC_CONSTANT_MACROS

extern "C" {
#include <libavformat/avformat.h>
#include <libavcodec/avcodec.h>
}

#include <sstream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    std::cout << avcodec_configuration() << std::endl;
    return 0;
}