//
// Created by Insomnia on 19-3-6.
// MIT License
//

#include <iostream>
#include <string.h>

#define maxn 20

int a [maxn][maxn];

using namespace std;

int main() {
    int n, x, y, tot = 0;
    memset(a, 0 , sizeof(a));
    scanf("%d", &n);

    //这种写法, 第一次见
    tot = a[x = 0][y = n - 1] = 1;

    while (tot <  n * n) {
        while (x + 1 < n && !a[x + 1][y]) a[++x][y] = ++tot;
        while (y - 1 >= 0 && !a[x][y - 1]) a[x][--y] = ++tot;
        while (x - 1 >= 0 && !a[x - 1][y]) a[--x][y] = ++tot;
        while (y + 1 < n && !a[x][y + 1]) a[x][++y] = ++tot;
    }

    for (x = 0; x < n; x++) {
        for (y = 0; y < n; y++) {
            cout << a[x][y] << " ";
        }
        cout << endl;
    }


    return 0;
}