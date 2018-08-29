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
    int sock;
    char message[BUF_SIZE];
    int strLen;
    socklen_t addrSize;
    
    struct sockaddr_in servAddr, fromAddr;
    
    sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0) {
        errorHandling("sock err");
    }
    
    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family = AF_INET;
//    servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servAddr.sin_addr.s_addr = inet_addr("192.168.0.104");
    servAddr.sin_port = htons(6666);
    
    while (1) {
        fputs("input message(Q to quit): ", stdout);
        fgets(message, BUF_SIZE, stdin);
        if (!strcmp(message, "q\n") || !strcmp(message, "Q\n")) {
            break;
        }
        
        sendto(sock, message, strlen(message), 0, (struct sockaddr*) &servAddr, sizeof(servAddr));
        addrSize = sizeof(fromAddr);
        
        strLen = recvfrom(sock, message, BUF_SIZE, 0, (struct sockaddr *)&fromAddr, &addrSize);
        message[strLen] = 0;
        cout << "Message from server : " << message << endl;
    }
    close(sock);

    return 0;
}
void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}