//
// Created by Insomnia on 2018/7/6.
//

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <zconf.h>

void errorHandling(char *message);
int main(void) {
    int fd;
    char buf[] = "Let's go!\n";

    fd = open("data.txt", O_CREAT|O_WRONLY|O_TRUNC);

    if (fd == -1) {
       errorHandling("open() error!");
    }

    if (write(fd, buf, sizeof(buf)) == -1) {
        errorHandling("write() error!");
    }
    close(fd);
    return 0;
}


void errorHandling(char *message) {
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}
