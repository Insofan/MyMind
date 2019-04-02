// 
// @ClassName 2
// @Description TODO
// @Date 19-3-1 下午11:27
// @Created by Insomnia
//

#include <stdio.h>
#include <math.h>

void sqrt1() {
        for (int i = 1; i <= 9; i++) {
            for (int j = 0; j <= 9; j++) {
                int n = 1100 * i + 11 * j;
                //注意这个技巧, 大量计算例如1后变成0.9999999999, 为了减小误差, 一般改成四舍五入.
                int m = sqrt(n + 0.5);
                if (m * m == n) {
                    printf("%d\n", n);
                }
            }
        }
}

void sqrt2() {
    for (int i = 32; i <= 99; i++) {
        int m = i * i;
        int hi = m / 100;
        int low = m % 100;
        if ((hi / 10 == hi % 10) && (low / 10 == low % 10)) {
            printf("%d\n", m);
        }
    }
}
int main() {

    sqrt2();

    return 0;
}