//
// Created by Insomnia on 19-3-6.
// MIT License
//

#include <iostream>

using namespace std;

#define maxn 105
//逆序输出
int a[maxn];

int main() {
    int x , n = 0;
    while (scanf("%d", &x) == 1) {
        a[n++] = x;
    }

    for (int i = n - 1; i >= 1; i--) {
        cout << a[i] << " ";
    }
    cout << a[0] << endl;
    // int a[maxn] b[maxn]
    // memcpy(b, a, sizeof(int))

    return 0;
}