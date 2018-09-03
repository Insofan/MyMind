//
// Created by Insomnia on 2018/9/3.
//

#include <stdio.h>
#include <unistd.h>


int main() {
    pid_t pid = fork();

    if (pid == 0) {
        puts("Hi, I am child process\n");
    } else {
        printf("Child process id %d\n", pid);
        sleep(30);
    }

    if (pid == 0) {
        puts("End child process");
    } else {
        puts("End Parent process");
    }

    return 0;
}
