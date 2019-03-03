// 
// @ClassName e2
// @Description TODO
// @Date 19-3-2 下午2:04
// @Created by Insomnia
//

#include <stdio.h>

int main () {
    int a , b, c;

    while (scanf("%d%d%d", &a, &b, &c)) {
        if (a > 1e6 || b > 1e6 || c > 100) {
            break;
        }

        printf("%.*d\n", (double)a / b, c);

        if (a == b && b == c && a == 0) {
            break;
        }
    }
    return 0;
}