// 
// @ClassName e2
// @Description TODO
// @Date 19-3-2 下午1:51
// @Created by Insomnia
//

#include <stdio.h>
#include <math.h>

int main () {
    int n, m;

    while (scanf("%d%d", &n, &m)) {
        double sum = 0;
        if (m <= n || m >= 1e6) {
            return -1;
        }

        while (n <= m) {
           sum += ( 1.0 / pow(n, 2));
           n++;
        }
        printf("%.5f\n", sum);
    }
    return 0;
}