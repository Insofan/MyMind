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
    int sd;
    FILE *fp;

    char buf[BUF_SIZE];
    int readCount;
    struct sockaddr_in servAddr;
    fp = fopen("receive.txt", "wb");
    sd = socket(AF_INET, SOCK_STREAM, 0);

    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("192.168.0.104");
    servAddr.sin_port = htons(6666);

    connect(sd, (struct sockaddr*)&servAddr, sizeof(servAddr));

    readCount = read(sd, buf, BUF_SIZE);

    while (readCount != 0) {
        fwrite((void*)buf, 1, readCount, fp);
        readCount--;
    }

    cout << "Received file data" << endl;
    write(sd, "Thank you", 10);
    fclose(fp);
    close(sd);
    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}