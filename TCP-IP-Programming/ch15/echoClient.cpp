//
// Created by Insomnia on 2018/9/19.
//
#include <stdlib.h>
#include <stdio.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <string.h>
#include <unistd.h>


#define BUF_SIZE 1024

void errorHandling(char *message);

int main() {
    int sock;
    char message[BUF_SIZE];
    sock = socket(PF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        errorHandling("Sock error");
    }

    struct sockaddr_in servaddr;

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servaddr.sin_port = htons(7777);

    printf("current port %hu\n", servaddr.sin_port);

    int connFlag = connect(sock, (struct sockaddr *) &servaddr, sizeof(servaddr));
    if (connFlag == -1) {
        errorHandling("connect error");
    } else {
        puts("connect");
    }
    FILE *readfp;
    FILE *writefp;

    readfp = fdopen(sock, "r");
    writefp = fdopen(sock, "w");

    while (1) {
        fputs("Input message(Q to quit): ", stdout);
        fgets(message, BUF_SIZE, stdin);
        if (!strcmp(message, "q\n") || !strcmp(message, "Q\n")) {
            break;
        }

        fputs(message, writefp);
        fflush(writefp);
        fgets(message, BUFSIZ, readfp);
        printf("Message from server: %s", message);
    }

    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}