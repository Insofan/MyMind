//
// Created by Insomnia on 2018/7/6.
//

#include <cstdio>
#include <cstdlib>
#include <netinet/in.h>
#include <cstring>
#include <arpa/inet.h>
#include <zconf.h>

void errorHandling(char *message);

int main(int argc, char *argv[]) {
    int sock;

    struct sockaddr_in servAddr;
    char message[30];
    int strLen;

    if (argc != 3) {
        printf("Usage : %s <IP> <port> \n", argv[0]);
        exit(1);
    }

    sock = socket(PF_INET, SOCK_STREAM, 0);

    if (sock == -1) {
        errorHandling("socket() error");
    }

    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr(argv[1]);
    servAddr.sin_port = htons(atoi(argv[2]));

    if (connect(sock, (struct sockaddr *) &servAddr, sizeof(servAddr)) == -1) {
        errorHandling("connect() error!");
    }

    strLen = read(sock, message, sizeof(message) - 1);
    if (strLen == -1) {
        errorHandling("read() error!");
    }

    printf("Message from server : %s \n", message);
    close(sock);

    return 0;
}


void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}

