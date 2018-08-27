// 
// Created by Insomnia on 2018/7/8.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>

#define BUF_SIZE 1024

void errorHandling(char *message);

int main(int argc, char *argv[]) {
    int servSock, clntSock;
    char message[BUF_SIZE];
    int strLen, i;

    struct sockaddr_in servaddr, clntAdr;
    socklen_t clntAdrSz;

    servSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

    if (servSock == -1) {
        errorHandling("Socket error");
    }

    memset(&servaddr, 0, sizeof(servaddr));
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

    for (int j = 0; j < 5; ++j) {
        printf("current port %hu\n", servaddr.sin_port);
        clntSock = accept(servSock, (struct sockaddr *) &clntAdr, &clntAdrSz);
        if (clntSock == -1) {
            errorHandling("accept error");
        } else {
            printf("Commected client %d \n", i + 1);
        }

        while ((strLen = read(clntSock, message, BUF_SIZE)) != 0) {
            write(clntSock, message, strLen);
        }
        close(clntSock);
    }
    close(servSock);
    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}



