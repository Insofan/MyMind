//
// Created by Insomnia on 2018/7/6.
//


#include <stdio.h>
#include <netinet/in.h>
#include <cstdlib>
#include <cstring>
#include <zconf.h>

void errorHandling(char *message);

int main(int argc, char *argv[]) {
    int servSock;
    int clntSock;

    struct sockaddr_in servAddr;
    struct sockaddr_in clntAddr;
    socklen_t  clntAddrSize;

    char message[] = "Hello World!";

    if (argc!=2) {
        printf("Usage :%s <port> \n", argv[0]);
        exit(1);
    }

    servSock = socket(PF_INET, SOCK_STREAM, 0);
    if (servSock == -1) {
        errorHandling("socket() error");
    }

    //csstring, 清空
    memset(&servAddr, 0, sizeof(servAddr));

    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servAddr.sin_port = htons(atoi(argv[1]));

    if (bind(servSock, (struct sockaddr*) &servAddr, sizeof(servAddr)) == -1) {
        errorHandling("bind() error");
    }

    if (listen(servSock, 5) == -1) {
        errorHandling("listen() error");
    }

    clntAddrSize = sizeof(clntAddr);

    clntSock = accept(servSock, (struct sockaddr*) &clntAddr, &clntAddrSize);
    if (clntSock == -1) {
        errorHandling("accpet() error");
    }

    write(clntSock, message, sizeof(message));
    close(clntSock);
    close(servSock);
    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}
