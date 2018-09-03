//
// Created by Insomnia on 2018/9/3.
//

#include <stdio.h>
#include <unistd.h>

int gval = 10;
int main() {
    //重点
    //父进程: fork函数返回子进程id
    //子进程: fork返回0
    pid_t  pid;
    int lval = 20;
    gval++, lval += 5;

    pid = fork();
    if (pid == 0) {
        gval+=2, lval+=2;
    } else {
        gval-=2, lval-=2;
    }

    if (pid == 0) {
        printf("Child proc :%d, %d \n", gval, lval);
    } else {
        printf("Parent proc: %d, %d \n", gval, lval);
    }

    return 0;
}
