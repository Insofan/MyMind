// 
// Created by Insomnia on 2018/7/8.
//

#include <stdio.h>
#include <stdlib.h>
#include <arpa/inet.h>
void errHandling(char *message);

int main(int argc, char *argv[]) {
    char *addr = "127.232.124.79";
    struct sockaddr_in addrInet;
    if (!inet_aton(addr, &addrInet.sin_addr)) {
       errHandling("Conversion error");
    } else {
        printf("Network ordered integer addr: %#x \n", addrInet.sin_addr.s_addr);
    }
    return 0;
}
void errHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}
