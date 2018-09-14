//
// Created by Insomnia on 2018/9/14.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

#define TTL 64    //数据包生存时间，即最多可以传递经过第64个路由时销毁
#define BUF_SIZE 30
void error_handling(char *message);

int main(int argc, const char * argv[]) {
    int send_sock;
    struct sockaddr_in mul_adr;
    int time_live = TTL;
    FILE *fp;
    char buf[BUF_SIZE];
    if (argc != 3) {
        printf("Usage : %s <GroupIp> <Port> \n", argv[0]);
        exit(1);
    }

    //基于UDP的多播
    send_sock = socket(PF_INET, SOCK_DGRAM, 0);
    memset(&mul_adr, 0, sizeof(mul_adr));
    mul_adr.sin_family = AF_INET;
    mul_adr.sin_addr.s_addr = inet_addr(argv[1]);
    mul_adr.sin_port = htons(atoi(argv[2]));

    //设置生存时间(除了这里其它基本和UDP编写一样)
    setsockopt(send_sock, IPPROTO_IP, IP_MULTICAST_TTL, (void *)&time_live, sizeof(time_live));

    if((fp = fopen("/Users/inso/Desktop/Go/src/MyMind/TCP-IP-Programming/ch14/news.txt", "r")) == NULL)
        error_handling("fopen() error");

    while (!feof(fp)) //如果文件结束，则返回非0值，否则返回0
    {
        fgets(buf, BUF_SIZE, fp);
        sendto(send_sock, buf, strlen(buf), 0, (struct sockaddr *)&mul_adr, sizeof(mul_adr));
        sleep(1); //只是为了加个传输数据时间间隔，没有特殊意义
    }

    fclose(fp);
    close(send_sock);
    return 0;
}

void error_handling(char *message)
{
    fputs(message, stderr);
    fputc('\n', stderr);
    exit(1);
}
