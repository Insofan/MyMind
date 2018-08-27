//
// Created by Insomnia on 2018/8/27.
//

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <iostream>
#include <arpa/inet.h>
#include <string>
#include <sys/socket.h>

using namespace std;

#define BUF_SIZE 1024
#define OPSZ 4

void errorHandling(char *message);
int calculate(int opnum, int opnds[], char op);

int main() {
    struct sockaddr_in servAddr, clientAddr;

    int servSock;
    servSock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (servSock < 0) {
        errorHandling("socket err");
    }

    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servAddr.sin_port = htons(7777);

    if (bind(servSock, (struct sockaddr *) &servAddr, sizeof(servAddr)) < 0) {
        errorHandling("bind error");
    }

    if (listen(servSock, 5) < 0) {
        errorHandling("listen error");
    }
    socklen_t  clientLen;
    clientLen = sizeof(clientAddr);

    int clientSock;
    int opCount;
    int recvLen;
    int recvCount;
    char opInfo[BUF_SIZE];
    int res;
    for (int i = 0; i < 5; ++i) {
        opCount = 0;
        clientSock = accept(servSock, (struct sockaddr *) &clientAddr, &clientLen);
        read(clientSock, &opCount, 1);
        recvLen = 0;
        while (recvLen < (opCount * OPSZ + 1)) {
            recvCount = read(clientSock, &opInfo, BUF_SIZE - 1);
            recvLen += recvCount;
        }

        res = calculate(opCount, (int *)opInfo, opInfo[recvLen - 1]);
        write(clientSock, (char *)&res, sizeof(res));
        close(clientSock);
    }

    close(servSock);
    return 0;
}
void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}

int calculate(int opnum, int opnds[], char op){
    int result = opnds[0], i;
    switch (op) {
        case '+':
            for (int i = 1; i < opnum; ++i) {
                result += opnds[i];
            }
            break;
        case '-':
            for (int i = 1; i < opnum; ++i) {
                result -= opnds[i];
            }
            break;
        case '*':
            for (int i = 1; i < opnum; ++i) {
                result *= opnds[i];
            }
            break;
    }
    return result;
}