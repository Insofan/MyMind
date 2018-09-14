//
// Created by Insomnia on 2018/9/14.
//

#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<sys/select.h>
#include<string.h>

#define BUF_SIZE 32

void errorHandling(const char *message);

int main() {

    int sock;
    struct sockaddr_in recvAddr;

    sock = socket(AF_INET, SOCK_STREAM, 0);
    memset(&recvAddr, 0, sizeof(recvAddr));
    recvAddr.sin_family = AF_INET;
    recvAddr.sin_addr.s_addr = inet_addr("192.168.0.103");
    recvAddr.sin_port = htons(6666);

    if (connect(sock, (struct sockaddr*)&recvAddr, sizeof(recvAddr)) < 0 ) {
        errorHandling("connect error");
    }

    write(sock, "123", strlen("123"));
    send(sock, "4", strlen("4"), MSG_OOB);
    write(sock, "567", strlen("567"));
    send(sock, "890", strlen("980"), MSG_OOB);
    close(sock);

    return 0;
}

void errorHandling(const char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}