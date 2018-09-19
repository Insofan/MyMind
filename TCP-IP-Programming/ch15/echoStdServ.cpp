//
// Created by Insomnia on 2018/9/19.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>

#define BUF_SIZE 1024

void errorHandling(char *message);

int main() {
    int servSock, clntSock;
    char message[BUF_SIZE];
    int strLen, i;

    struct sockaddr_in servaddr, clntAdr;
    socklen_t clntAdrSz;

    servSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

    FILE *readfp;
    FILE *writefp;

    servaddr.sin_family = PF_INET;
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servaddr.sin_port = htons(7777);

    if (bind(servSock, (struct sockaddr *) &servaddr, sizeof(servaddr)) < 0) {
        errorHandling("bind error");
    }

    if (listen(servSock, 5) < 0) {
        errorHandling("listen error");
    }

    clntAdrSz = sizeof(clntAdr);


    for (int i = 0; i < 5; i++) {
        clntSock = accept(servSock, (struct sockaddr *)&clntAdr, &clntAdrSz);
        if (clntSock == -1) {
            errorHandling("accept err");
        } else {
            printf("Coonnected client %d \n", i + 1);
        }

        readfp = fdopen(clntSock, "r");
        writefp = fdopen(clntSock, "w");

        while (!feof(readfp)) {
            fgets(message, BUF_SIZE, readfp);
            fputs(message, writefp);
            //清除读写缓冲区，需要立即把输出缓冲区的数据进行物理写入时
            fflush(writefp);
        }

        fclose(readfp);
        fclose(writefp);
    }
    return 0;
}


void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}


