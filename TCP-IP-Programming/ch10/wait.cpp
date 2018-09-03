
//
// Created by Insomnia on 2018/9/3.
//

#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <iostream>

using namespace std;


//pid_t wait(int *statloc); 返回终止的子进程ID, 失败时返回 -1
int main() {

    int status;
    pid_t pid = fork();

    if (pid == 0) {
        return  3;
    } else {
        cout << "Child PID: " << pid << endl;
        pid = fork();

        if (pid == 0) {
            exit(7);
        } else {
            cout << "Child PID: " << pid << endl;
            wait(&status);

            //WIFEXITED 验证是否正常退出, 如果正常退出 输出返回值;
            if (WIFEXITED(status)) {
                cout << "Child send one : " <<  WEXITSTATUS(status)<< endl;
            }

            wait(&status);

            //WIFEXITED 验证是否正常退出, 如果正常退出 输出返回值;
            if (WIFEXITED(status)) {
                cout << "Child send two: " <<  WEXITSTATUS(status)<< endl;
            }

            sleep(30);
        }
    }

    return 0;
}
