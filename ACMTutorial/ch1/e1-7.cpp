// 
// @ClassName e1
// @Description TODO
// @Date 19-3-1 上午12:22
// @Created by Insomnia
//
#include <stdio.h>
#include <math.h>

int main() {
    int n;
    scanf("%d", &n);

    if (n % 400 == 0 || (n % 4 == 0 && n % 100 != 0)) {
        printf("true\n");
        return 0;
    }
    printf("false\n");

    return 0;
}