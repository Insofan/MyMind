//
// Created by Insomnia on 19-3-6.
// MIT License
//

#include <iostream>
#include <string.h>

using namespace std;
#define len 1200

int light[len];

void mySol(int n) {
    //只可以置为0 不可以设置为1
    memset(light, 0, sizeof(light));
    for (int i = 2; i <= n; i++) {
        int j = 2;
        while (j * i <= n) {
           light[i * j++] = 1;
        }
    }

    for (int i = 1; i <= n; i++) {
        if (light[i] == 0) {
            cout << i << " ";
        }
    }
    cout << endl;
}
int main() {
    int n;
    scanf("%d", &n);
    mySol(n);

    return 0;
}