// 
// Created by Insomnia on 2018/7/7.
//

#include <stdio.h>
#include <iostream>
#include <arpa/inet.h>

using namespace std;

int main(int argc, char *argv[]) {
    unsigned short hostPort = 0x1234;
    unsigned short netPort;
    unsigned long hostAddr = 0x12345678;
    unsigned long netAddr;

    netPort = htons(hostPort);
    netAddr = htonl(hostAddr);

    printf("Host ordered port: %#x \n", hostPort);
    printf("Network ordered port: %#x \n", netPort);
    printf("Host ordered address: %#x \n", hostAddr);
    printf("Network ordered address: %#x \n", netAddr);

    return 0;
}
