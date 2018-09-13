//
// Created by Insomnia on 2018/9/12.
//

#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/socket.h>


#define BUF_SZIE 30

int main() {

    fd_set reads, temps;
    int result, strLen;
    char buf[BUF_SZIE];
    struct timeval timeout;
    //初始化fd set 变量
    FD_ZERO(&reads);
    FD_SET(0, &reads);

    while (1) {
        //记住初始值
        temps = reads;

        timeout.tv_sec = 5;
        timeout.tv_usec = 0;
        //有数据输出大于0, 无等于0
        result = select(1, &temps, 0, 0, &timeout);

        if (result == -1) {
            puts("select() err");
            break;
        } else if (result == 0) {
            puts("time out");
        } else {
            //验证标准输出
            if (FD_ISSET(0, &temps)) {
                strLen = read(0, buf, BUF_SZIE);
                buf[strLen] = 0;
                printf("message from console: %s", buf);
            }
        }
    }

    return 0;
}
