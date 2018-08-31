//
// Created by Insomnia on 2018/8/31.
//

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}

int main() {
    int tcpSock, udpSock;
    int sockType;
    socklen_t optLen;
    int state;
    
    optLen = sizeof(sockType);
    tcpSock = socket(AF_INET, SOCK_STREAM, 0);
    udpSock = socket(AF_INET, SOCK_DGRAM, 0);
    cout <<  "SOCK_STREAM " << SOCK_STREAM << endl;
    cout << "SOCK_DGRAM " << SOCK_DGRAM << endl;
    
    state = getsockopt(tcpSock, SOL_SOCKET, SO_TYPE, (void *)&sockType, &optLen);
    if (state) {
        errorHandling("getsocket err");
    }
    
    cout << "Socket type one : " << sockType << endl;

    state = getsockopt(udpSock, SOL_SOCKET, SO_TYPE, (void *)&sockType, &optLen);

    if (state) {
        errorHandling("getsocket err");
    }
    
    cout << "Socket type two : " << sockType << endl;
    
    return 0;
}
