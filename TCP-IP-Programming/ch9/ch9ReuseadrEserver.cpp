//
// Created by Insomnia on 2018/8/31.
//

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <iostream>
#include <arpa/inet.h>

using namespace std;

#define TRUE 1
#define FALSE 1

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}


int main() {
    int  servSock, clientSock;
    char message[30];
    int  option, strLen;

    socklen_t          optLen, clientAddrSize;
    struct sockaddr_in servAddr, clientAddr;
    servSock = socket(PF_INET, SOCK_STREAM, 0);
    if (servSock < 0) {
        errorHandling("sock err");
    }

    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family      = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("192.168.0.104");
    servAddr.sin_port = ntohs(6666);

    int bindFlag = bind(servSock, (struct sockaddr*)&servAddr, sizeof(servAddr));
    if (bindFlag < 0) {
        errorHandling("bind err");
    }
    
    int listenFlag = listen(servSock, 5);
    
    if (listenFlag < 0) {
        errorHandling("listen error");
    }
    
    clientAddrSize = sizeof(clientAddr);
    clientSock = accept(servSock, (struct sockaddr *)&clientAddr, &clientAddrSize);
    
    while ((strLen = read(clientSock, message, sizeof(message))) != 0) {
        write(clientSock, message, strLen);
        write(1, message, strLen);
    }
    
    close(clientSock);
    close(servSock);

    return 0;
}
