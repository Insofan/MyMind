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


int main() {
    int servSock, clntSock;

    FILE* readfp;
    FILE* writefp;

    struct sockaddr_in servaddr, clntAdr;
    socklen_t clntAdrSz;

    char buf[BUF_SIZE] = {0,};

    servSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = PF_INET;
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servaddr.sin_port = htons(7777);

    bind(servSock, (struct sockaddr *) &servaddr, sizeof(servaddr));
    listen(servSock, 5);
    clntAdrSz  = sizeof(clntAdr);
    clntSock = accept(servSock, (struct sockaddr*)&clntAdr, &clntAdrSz);

    readfp = fdopen(clntSock, "r");
    writefp = fdopen(clntSock, "w");

    fputs("From server: hi ~ client? \n", writefp);
    fputs("I love all of the world \n", writefp);
    fputs("You are awesome! \n", writefp);
    fflush(writefp);

    fclose(writefp);
    fgets(buf, sizeof(buf), readfp);
    fputs(buf, stdout);
    fclose(readfp);


    return 0;
}
