//
// Created by Insomnia on 2018/9/4.
//

#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>

//bug 程序
#define BUF_SIZE 30

void errorHandling(char *message);
void readChildproc(int sig);

int main() {
    int servSock, clientSock;
    struct sockaddr_in servAddr, clientAddr;

    pid_t pid;
    struct sigaction act;
    socklen_t addrSize;
    int strLen, state;
    char buf[BUF_SIZE];

    act.sa_handler = readChildproc;
    act.sa_flags   = 0;
    sigemptyset(&act.sa_mask);
    sigaction(SIGCHLD,&act, 0);

    servSock = socket(AF_INET, SOCK_STREAM, 0);
    servAddr.sin_family      = AF_INET;
    servAddr.sin_addr.s_addr = inet_addr("192.168.0.104");
    servAddr.sin_port = htons(6666);

    if(0 != bind(servSock, (struct sockaddr*)&servAddr, sizeof(servAddr))){
        errorHandling("bind() error!");
    }

    if(0 != listen(servSock, 5)){
        errorHandling("listen() error!");
    }

    socklen_t  clientAddrLen = sizeof(clientAddr);

    while(1){
        clientSock = accept(servSock, (struct sockaddr*)&clientAddr, &clientAddrLen);
        if(clientSock == -1){
            continue;
        }
        else{
            puts("new client connected...");
        }

        pid_t pid = fork();

        if(pid == -1){
            close(clientSock);
            continue;
        }

        if(pid > 0){
            close(clientSock);
        }
        else{
            close(servSock);

            char buf[BUF_SIZE];
            int receivedByte = 0;
            while((receivedByte = read(clientSock,buf, sizeof(buf)))>0){
                write(clientSock, buf, receivedByte);
            }

            close(clientSock);

            puts("client disconnected...");

            return 0;
        }
    }

    close(servSock);

    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}

void readChildproc(int sig) {
    pid_t pid;
    int status;
    pid = waitpid(-1, &status, WNOHANG);
    printf("removed proc id: %d\n", pid);

}