// 
// Created by Insomnia on 2018/7/6.
//

#include <stdio.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>

using namespace std;

int main() {
    int fd1, fd2, fd3;

    fd1 = socket(PF_INET, SOCK_STREAM, 0);
    fd2 = open("test.dat", O_CREAT | O_WRONLY | O_TRUNC);
    fd3 = socket(PF_INET, SOCK_DGRAM, 0);

    cout << "file descriptor 1: " << fd1 << endl;
    cout << "file descriptor 2: " << fd2 << endl;
    cout << "file descriptor 3: " << fd3 << endl;
    return 0;
}