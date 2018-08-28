//
// Created by Insomnia on 2018/8/28.
//

#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string>
#include <iostream>


#define  BUF_SIZE 30

void errorHandling(char *message);

using namespace std;

int main() {
    int                servSock;
    char               message[BUF_SIZE];
    int                strLen;
    socklen_t          clientAddrSize;
    struct sockaddr_in servAddr, clientAddr;

    servSock = socket(AF_INET, SOCK_DGRAM, 0);
    if (servSock < 0) {
        errorHandling("udp sock err");
    }

    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family      = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servAddr.sin_port = ntohs(6666);

    int bindFlag = bind(servSock, (struct sockaddr*)&servAddr, sizeof(servAddr));
    if (bindFlag < 0) {
        errorHandling("bind err");
    }

    while (1) {
       clientAddrSize = sizeof(clientAddr);
       strLen = recvfrom(servSock, message, BUF_SIZE, 0, (struct sockaddr *) &clientAddr, &clientAddrSize);
       cout << "Message from client: " << message << endl;
       sendto(servSock, message, strLen, 0, (struct sockaddr *)&clientAddr, clientAddrSize);
    }
    close(servSock);
    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}