//
// Created by Insomnia on 2018/9/14.
//

#include<unistd.h>
#include<stdlib.h>
#include<stdio.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<string.h>

#define TTL 64
#define BUF_SIZE 30

void errorHandling(const char *message);

int main() {
    int recvSock;
    int strLen;
    char buf[BUF_SIZE];

    struct sockaddr_in adr;
    struct ip_mreq joinAdr;

    recvSock = socket(AF_INET, SOCK_DGRAM, 0);
    memset(&adr, 0, sizeof(adr));
    adr.sin_family = AF_INET;
//    adr.sin_addr.s_addr = inet_addr("127.0.0.1");
//    adr.sin_port = htons(8080);
    adr.sin_addr.s_addr = htonl(INADDR_ANY);
    adr.sin_port = htons(8080);

    if (bind(recvSock, (struct sockaddr*)&adr, sizeof(adr)) == -1) {
        errorHandling("bind err");
    }

//    joinAdr.imr_multiaddr.s_addr = inet_addr("127.0.0.1");
//    joinAdr.imr_interface.s_addr = inet_addr("127.0.0.1");
    //加入多播组
    joinAdr.imr_multiaddr.s_addr = inet_addr("127.0.0.1");
    joinAdr.imr_interface.s_addr = htonl(INADDR_ANY);
    setsockopt(recvSock, IPPROTO_IP, IP_ADD_MEMBERSHIP, (void *)&joinAdr, sizeof(joinAdr));

    while (1) {
        strLen = recvfrom(recvSock, buf, BUF_SIZE - 1, 0, NULL, 0);
        if (strLen < 0) {
            break;
        }

        buf[strLen] = 0;
        fputs(buf, stdout);
    }

    close(recvSock);

    return 0;
}

void errorHandling(const char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}