//
// Created by Insomnia on 2018/8/29.
//

#include <stdio.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>
#include <iostream>
#include <string>

#define  BUF_SIZE 30

void errorHandling(char *message);

using namespace std;

int main() {
    int servSd, clientSd;
    FILE *fp;
    char buf[BUF_SIZE];
    int readCount;

    struct sockaddr_in servAddr, clientAddr;

    socklen_t clientAddrSize;
    //路径问题
    fp = fopen("/Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch7/ch7fileServer.cpp", "rb");

    servSd = socket(AF_INET, SOCK_STREAM, 0);
    if (servSd < 0) {
        errorHandling("sock err");
    }
    memset(&servAddr, 0, sizeof(servAddr));

    servAddr.sin_family      = AF_INET;
//    servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servAddr.sin_addr.s_addr = inet_addr("192.168.0.104");
    servAddr.sin_port = htons(6666);

    int bindFlag = bind(servSd, (struct sockaddr*)&servAddr, sizeof(servAddr));
    if (bindFlag < 0) {
        errorHandling("bind err");
    }

    listen(servSd, 5);

    clientAddrSize = sizeof(clientAddr);
    clientSd = accept(servSd, (struct sockaddr*)&clientAddr, &clientAddrSize);
//    cout << "Client Addr: " << clientAddr << endl;

    while (1) {
        readCount = fread((void *)buf, 1, BUF_SIZE, fp);
        if (readCount < BUF_SIZE) {
            write(clientSd, buf, readCount);
            break;
        }

        write(clientSd, buf, readCount);
    }

    shutdown(clientSd, SHUT_WR);
    read(clientSd, buf, BUF_SIZE);
    cout << "Message from client: " << buf << endl;
    fclose(fp);
    close(clientSd);
    close(servSd);


    return 0;
}


void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}