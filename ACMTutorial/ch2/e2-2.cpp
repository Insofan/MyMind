// 
// @ClassName e2
// @Description TODO
// @Date 19-3-2 下午1:24
// @Created by Insomnia
//

#include <stdio.h>
#include <math.h>
#include <vector>

using namespace std;

//韩信点兵
int main() {

    int n = 0;
    int a, b, c;
    int x;
    while (scanf("%d%d%d", &a, &b,&c) != EOF) {
        int i = 10;
        for (; i <= 100; i++) {
            if (i % 3 == a && i % 5 == b && i % 7 == c) {
                printf("%d\n", i);
                break;
            }
        }
        if (i > 100) {
            printf("No answer\n", i);
        }
    }




    return 0;
}