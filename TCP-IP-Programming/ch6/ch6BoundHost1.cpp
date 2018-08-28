//
// Created by Insomnia on 2018/8/28.
//

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
    int                sock;
    char               message[BUF_SIZE];
    struct sockaddr_in myAddr, yourAddr;
    socklen_t          addrSize;
    int                strLength;

    sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) {
        errorHandling("socket err");
    }
    memset(&myAddr, 0, sizeof(myAddr));
    myAddr.sin_family      = AF_INET;
    myAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    myAddr.sin_port        = htons(6666);

    int bindFlag = bind(sock, (struct sockaddr *) &myAddr, sizeof(myAddr));

    if (bindFlag < 0) {
        errorHandling("bind err");
    }

    for (int i = 0; i < 3; ++i) {
        sleep(5);
        addrSize  = sizeof(yourAddr);
        strLength = recvfrom(sock, message, BUF_SIZE, 0, (struct sockaddr *) &yourAddr, &addrSize);
        cout << "Message " << i + 1 << ": " << message << endl;
    }
    close(sock);
    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}