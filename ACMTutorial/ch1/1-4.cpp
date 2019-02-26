// 
// @ClassName 1
// @Description TODO
// @Date 19-2-26 下午11:41
// @Created by Insomnia
//

#include <stdio.h>

int main() {
    int n, m;
    scanf("%d%d", &n, &m);

    int x, y;

    y = (m / 2) - n;
    x = 2 * n - (m / 2);

    if (x < 0 || y < 0 || m % 2 == 1) {
        printf("No Answer\n");
        return -1;
    }

    printf("%d %d\n", x, y);
    return 0;
}
