// 
// Created by Insomnia on 2018/7/8.
//

#include <arpa/inet.h>
#include <stdlib.h>
#include <stdio.h>
#include <string>

int main() {
    /*
    struct sockaddr_in addr1, addr2;
    char *str_ptr;
    char str_arr[20];
    addr1.sin_addr.s_addr = htonl(0x1020304);
    addr1.sin_addr.s_addr = htonl(0x1010101);

    str_ptr = inet_ntoa(addr1.sin_addr);
    strcpy(str_arr, str_ptr);
    printf("Dotted-Decimal notation1: %s \n", str_ptr);

    str_ptr = inet_ntoa(addr2.sin_addr);
    printf("Dotted-Decimal notation2: %s \n", str_ptr);
    printf("Dotted-Decimal notation3: %s \n", str_arr);
    */

    struct in_addr addr;
    addr.s_addr = htonl(0x1020304);

    char* str = inet_ntoa(addr);

    char sockAddr[32];
    strcpy(sockAddr, str);

    printf("sockAddr: %s \n", sockAddr);
    return 0;
}
