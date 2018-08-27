//
// Created by Insomnia on 2018/7/6.
//

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>

using namespace std;

#define BUF_SIZE 100

void errorHandling(char *message);

int main() {
    int fd;


    char buf[BUF_SIZE];

    fd = open("data.txt", O_RDONLY);
    if (fd == -1) {
        errorHandling("open() error!");
    }
    cout << "file descriptor: " << fd << endl;

    if (read(fd, buf, sizeof(buf)) == -1) {
        errorHandling("read() error!");
    }

    cout << "file data: " << buf << endl;
    close(fd);
    return 0;
}

void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}

