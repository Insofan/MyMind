// 
// @ClassName 2
// @Description TODO
// @Date 19-3-2 下午1:00
// @Created by Insomnia
//

// 有bug
#include <stdio.h>
#define INF 1000000

int main() {
    int x, n = 0, min = INF, max = -INF, s = 0, kcase = 0;

    while (scanf("%d", &n) == 1 && n) {
        s = 0;

        for (int i = 0; i < n; i++) {
            scanf("d", &x);
            s += x;
            if (x < min) {
                min = x;
            }
            if (x > max) {
                max = x;
            }
        }
        if (kcase) printf("\n");
    }
    printf("Case %d: %d %d %.3f\n", ++kcase, min, max, (double)s / n);
    return 0;
}