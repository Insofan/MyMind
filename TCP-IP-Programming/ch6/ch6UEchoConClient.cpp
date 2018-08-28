//
// Created by Insomnia on 2018/8/28.
//
// udp 带连接

#include <stdio.h>
#include <string>
#include <stdlib.h>
#include <unistd.h>
#include <iostream>
#include <arpa/inet.h>
#include <sys/socket.h>

using namespace std;
#define  BUF_SIZE 30

void errorHandling(char *message);


int main() {
    int sock;
    char message[BUF_SIZE];
    int strLength;
    socklen_t addrSize; //多余变量

    struct sockaddr_in servAddr, fromAddr; //不在需要from addr

    sock = socket(AF_INET, SOCK_DGRAM, 0);

    if (sock < 0) {
        errorHandling("sock err");
    }

    memset(&servAddr,0, sizeof(servAddr));
    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servAddr.sin_port= htons(6666);

    connect(sock, (struct sockaddr*)&servAddr, sizeof(servAddr));

    while (1) {
        fputs("input message(Q to quit): ", stdout);
        fgets(message, BUF_SIZE, stdin);
        if (!strcmp(message, "q\n") || !strcmp(message, "Q\n")) {
            break;
        }

        write(sock, message , strlen(message));
        strLength = read(sock, message, sizeof(message) - 1);
        message[strLength] = 0;
        cout << "Message from server: " << message << endl;
    }
    close(sock);
    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}