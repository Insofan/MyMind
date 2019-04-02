// 
// @ClassName 2
// @Description TODO
// @Date 19-3-2 上午12:18
// @Created by Insomnia
//

#include <stdio.h>

int getSum(int n) {
    int sum = 1;
    while (n) {
        sum *= n--;
    }
    return sum;
}

int main() {
    int n;

    scanf("%d", &n);

    if (n > 1e6){
        printf("over flow\n");
        return -1;
    }

    int sum = 0;

    for (int i = 1; i <= n; i++) {
       sum += getSum(i);
    }

    sum %= 1000000;

    printf("%d\n", sum);

    return 0;
}
