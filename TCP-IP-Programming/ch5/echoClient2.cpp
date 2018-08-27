//
// Created by Insomnia on 2018/8/27.
//

#include <stdio.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <string>
#include <iostream>
#include <unistd.h>

#define BUF_SIZE 1024

void errorHandling(char *message);

using namespace std;

int main() {
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        errorHandling("sock err");
    }

    struct sockaddr_in servAddr;
    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servAddr.sin_port = htons(7777);

    cout << "current port: " << servAddr.sin_port << endl;

    int connFlag = connect(sock, (struct sockaddr *) &servAddr, sizeof(servAddr));
    if (connFlag == -1) {
        errorHandling("conn err");
    } else {
        cout << "conn sucess" << endl;
    }

    char message[BUF_SIZE];
    int strLen;
    int recvLen;
    int readLen;

    while (1) {
        cout << "Input message(Q to quit): " << endl;
        fgets(message, BUF_SIZE, stdin);

        if (!strcmp(message, "q\n") || !strcmp(message, "Q\n")) {
            break;
        }
        
        strLen = write(sock, message, strlen(message));
        recvLen = 0;
        while (recvLen < strLen) {
            readLen = read(sock, &message[recvLen], BUF_SIZE - 1);
            if (readLen == -1) {
                errorHandling("read err");
            }
            recvLen += readLen; 
        }
        message[recvLen] = 0;
        cout << "message from server : " << message << endl;
    }
    close(sock);
    return 0;
}


void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}