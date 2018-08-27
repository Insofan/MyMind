// 
// Created by Insomnia on 2018/7/7.
//

#include <stdio.h>
#include <arpa/inet.h>

int main(int argc, char *argv[]) {
    char *addr1 = "1.2.3.4";
    char *addr2 = "1.2.3.256";

    //可以将 点分转为32位 还可以检测无效地址
    unsigned long convAddr = inet_addr(addr1);
    if (convAddr == INADDR_NONE) {
        printf("Error occured!\n");
    } else {
        printf("Network ordered integer addr : %#lx \n", convAddr);
    }

    convAddr = inet_addr(addr2);

    if (convAddr == INADDR_NONE) {
        printf("Error occureded \n");
    } else {
        printf("Network ordered integer addr: %#lx \n\n", convAddr);
    }
    return 0;
}