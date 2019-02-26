// 
// @ClassName 1
// @Description TODO
// @Date 19-2-26 下午11:26
// @Created by Insomnia
//

#include <stdio.h>

int main() {
    int input;
    scanf("%d", &input);

    int res = 0;

    while (input) {
        res *= 10;
        res += input % 10;
        input /= 10;
    }

    printf("%d", res);
    return 0;
}