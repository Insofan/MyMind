//
// Created by Insomnia on 2018/8/27.
//

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <iostream>
#include <arpa/inet.h>
#include <string>
#include <sys/socket.h>

using namespace std;

#define BUF_SIZE 1024
#define RLT_SIZE 4
#define OPSZ 4


void errorHandling(char *message);


int main() {
    int sock;
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
       errorHandling("sock err");
    }

    struct sockaddr_in servAddr;
    memset(&servAddr, 0, sizeof(servAddr));
    servAddr.sin_family = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servAddr.sin_port = htons(7777);
    cout << "current port: " << servAddr.sin_port << endl;

    int connFlag = connect(sock, (struct sockaddr *)&servAddr, sizeof(servAddr));
    if (connFlag < 0) {
        errorHandling("connect err");
    } else {
        cout << "connet---------------------------" << endl;
    }

    int opCount;
    char opmsg[BUF_SIZE];
    fputs("Operand count: ", stdout);
    
    scanf("%d", &opCount);
    opmsg[0] = (char)opCount;
    for (int i = 0; i < opCount; ++i) {
        cout << "Opserand " << i+1 << ": ";
        scanf("%d", (int *)&opmsg[i*OPSZ + 1]);
        cout << opmsg[i] << endl;
    }
    fgetc(stdin);
    fputs("Operator: ", stdout);
    scanf("%c", &opmsg[opCount * OPSZ + 1]);
    write(sock, opmsg, opCount * OPSZ + 2);
    int result;
    read(sock, &result, RLT_SIZE);
    cout << "Operation result: " << result << endl;
    close(sock);

    return 0;
}
void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}