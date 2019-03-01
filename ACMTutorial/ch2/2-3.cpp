// 
// @ClassName 2
// @Description TODO
// @Date 19-3-1 下午11:47
// @Created by Insomnia
//

#include <stdio.h>

int main() {

    int n;

    scanf("%d", &n);
    long long n2 = n;

    int res = 0;
    //当输入 987654321时, 3 * n 溢出了
    while (n2 > 1) {
        res++;
        if (n2 % 2 == 0) {
            n2/= 2;
        } else {
            n2 = 3 *n2 + 1;
        }
    }

    printf("%d\n", res);
}