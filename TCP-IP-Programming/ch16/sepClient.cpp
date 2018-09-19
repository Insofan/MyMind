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
    int                sock;
    char               buf[BUF_SIZE];
    struct sockaddr_in servAddr;

    FILE *readfp;
    FILE *writefp;

    sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family      = PF_INET;
    servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servAddr.sin_port        = htons(7777);

    connect(sock, (struct sockaddr *) &servAddr, sizeof(servAddr));
    readfp  = fdopen(sock, "r");
    writefp = fdopen(sock, "w");

    while (1) {
        if (fgets(buf, sizeof(buf), readfp) == NULL) {
            break;
        }
        fputs(buf, stdout);
        fflush(stdout);
    }
    fputs("FROM CLIENT: Thank you! \n", writefp);
    fflush(writefp);
    fclose(writefp);
    fclose(readfp);
    return 0;
}
