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
#include <signal.h>
#include <fcntl.h>

#define BUF_SIZE 32

void errorHandling(const char *message);
void urlHandler(int signo);

int acptSock;
int recvSock;

int main() {
    struct sockaddr_in recvAddr, servAddr;
    int strLen, state;
    socklen_t  servAddrSize;
    struct sigaction act;
    char buf[BUF_SIZE];

    act.sa_handler = urlHandler;
    sigemptyset(&act.sa_mask);
    act.sa_flags = 0;

    acptSock = socket(AF_INET, SOCK_STREAM, 0);
    memset(&recvAddr, 0, sizeof(recvAddr));
    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("192.168.0.103");
    servAddr.sin_port = htons(6666);

    if (bind(acptSock, (struct sockaddr *)&recvAddr, sizeof(recvAddr)) == -1) {
        errorHandling("bind() error");
    }
    listen(acptSock, 5);

    servAddrSize = sizeof(servAddr);
    recvSock = accept(acptSock, (struct sockaddr *)&servAddr, &servAddrSize);

    fcntl(recvSock, F_SETOWN, getpid());
    state = sigaction(SIGURG, &act, 0);

    while ((strLen = recv(recvSock, buf, sizeof(buf), 0)) != 0 ) {
        if (strLen == -1) {
            continue;
        }
        buf[strLen] = 0;
        puts(buf);
    }

    close(recvSock);
    close(acptSock);


    return 0;
}

void errorHandling(const char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}

void urlHandler(int signo) {
    int strLen;
    char buf[BUF_SIZE];
    strLen = recv(recvSock, buf, sizeof(buf) - 1, MSG_OOB);
    buf[strLen] = 0;
    printf("Urgent message: %s \n", buf);
}