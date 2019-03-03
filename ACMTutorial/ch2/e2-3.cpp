// 
// @ClassName e2
// @Description TODO
// @Date 19-3-2 下午1:45
// @Created by Insomnia
//
#include <stdio.h>
#include <cstdint>

int main() {
    int n;

    scanf("%d", &n);
    if (n > 20) {
        return -1;
    }

    int space = 0;
    while (n) {
        for (int i = 0; i < space; i++) {
            printf(" ");
        }
        space++;
        for (int i = 0; i < 2 * n - 1; i++) {
            printf("#");
        }
        printf("\n");
        n--;
    }

    return 0;
}