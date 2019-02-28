// 
// @ClassName e1
// @Description TODO
// @Date 19-3-1 上午12:13
// @Created by Insomnia
//

#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);

    if ( 1 < n) {
        int sum = (1 + n) * n / 2;
        printf("%d\n", sum);
    }

    return 0;
}