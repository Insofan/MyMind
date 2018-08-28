//
// Created by Insomnia on 2018/8/28.
//

#include <stdio.h>
#include <iostream>
#include <string>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

using namespace std;

#define  BUF_SIZE 30

void errorHandling(char *message);

int main() {
    int sock;
    char msg1[] = "Hi!";
    char msg2[] = "I'm another UDP host!";
    char msg3[] = "Nice to meet you";

    struct sockaddr_in yourAddr;
    socklen_t  yourAddrSize;

    sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) {
        errorHandling("socket err");
    }
    memset(&yourAddr, 0, sizeof(yourAddr));
    yourAddr.sin_family      = AF_INET;
    yourAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    yourAddr.sin_port        = htons(6666);

    sendto(sock, msg1, sizeof(msg1), 0, (struct sockaddr *)&yourAddr, sizeof(yourAddr));
    sendto(sock, msg2, sizeof(msg2), 0, (struct sockaddr *)&yourAddr, sizeof(yourAddr));
    sendto(sock, msg3, sizeof(msg3), 0, (struct sockaddr *)&yourAddr, sizeof(yourAddr));

    close(sock);
    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}