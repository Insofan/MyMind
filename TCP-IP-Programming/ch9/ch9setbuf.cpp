//
// Created by Insomnia on 2018/8/31.
//

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <iostream>

using namespace std;

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}

int main() {
    int sock;
    int sendBuf = 1024 * 3;
    int recvBuf = 1024 * 3;

    int       state;
    socklen_t len;

    sock  = socket(PF_INET, SOCK_STREAM, 0);
    state = setsockopt(sock, SOL_SOCKET, SO_RCVBUF, (void *) &recvBuf, sizeof(recvBuf));
    if (state) {
        errorHandling("setsocket err");
    }

    state = setsockopt(sock, SOL_SOCKET, SO_SNDBUF, (void *) &sendBuf, sizeof(sendBuf));
    if (state) {
        errorHandling("setsocket err");
    }

    len   = sizeof(sendBuf);
    state = getsockopt(sock, SOL_SOCKET, SO_SNDBUF, (void *) &sendBuf, &len);
    if (state) {
        errorHandling("getsocket err");
    }

    len   = sizeof(recvBuf);
    state = getsockopt(sock, SOL_SOCKET, SO_RCVBUF, (void *) &recvBuf, &len);
    if (state) {
        errorHandling("getsocket err");
    }

    cout << "Output buffer size: " << sendBuf << endl;
    cout << "Input buffer size: " << recvBuf << endl;
    return 0;
}
