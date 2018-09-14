//
// Created by Insomnia on 2018/9/14.
//

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/socket.h>

#define TTL 64
#define BUF_SIZE 30

void errorHandling(const char *message);

int main() {
    int sendSock;
    struct sockaddr_in mulAddr;

    int time_live = TTL;
    FILE *fp;
    char buf[BUF_SIZE];

    sendSock = socket(AF_INET, SOCK_STREAM, 0);

    memset(&mulAddr, 0, sizeof(mulAddr));
    mulAddr.sin_family = AF_INET;
    mulAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    mulAddr.sin_port = htons(8080);

    setsockopt(sendSock, IPPROTO_IP, IP_MULTICAST_TTL, (void *)&time_live, sizeof(time_live));

    if ((fp =fopen("/Users/inso/Desktop/Go/src/MyMind/TCP-IP-Programming/ch14/news.txt", "r")) == NULL) {
       errorHandling("fopen err");
    }

    while (!feof(fp)) {
        fgets(buf, BUF_SIZE, fp);
        sendto(sendSock, buf, strlen(buf), 0, (struct sockaddr *) &mulAddr, sizeof(mulAddr));
        sleep(3);
    }

    fclose(fp);
    close(sendSock);
    return 0;
}

void errorHandling(const char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}