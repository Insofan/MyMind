//
// Created by Insomnia on 19-3-9.
// MIT License
//

#include <iostream>
#include <string.h>

using namespace std;

//记住sprintf , strlen, strchr(str, char) == NULL , %5d 按照5位输出 函数的用法
int main() {
    char s[20], buf[99];
    int count = 0;

    scanf("%s", s);

    for (int abc = 100; abc <= 999; abc++) {
        for (int de = 10; de <= 99; de++) {
           int x = abc * (de % 10), y = abc * (de / 10), z = abc * de;
           sprintf(buf, "%d%d%d%d%d", abc, de, x, y, z);
           int ok = 1;
           for (int i = 0; i < strlen(buf); i++) {
               if (strchr(s,buf[i]) == NULL) ok = 0;
           }
           if (ok) {
               printf("<%d>\n", ++count);
               printf("%5d\nX%4d\n-----\n%5d\n%4d\n-----\n%5d\n\n", abc, de, x, y, z);
           }
        }
    }
    printf("Total %d solutions\n", count);
    return 0;
}