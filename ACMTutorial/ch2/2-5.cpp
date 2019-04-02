// 
// @ClassName 2
// @Description TODO
// @Date 19-3-2 下午12:37
// @Created by Insomnia
//

#include <stdio.h>
#include <cstdint>

int main() {
    int x, n , s = 0 ;
    int min = INT32_MAX;
    int max = INT32_MIN;
    
    while (scanf("%d", &x) == 1) {
        s += x;
        if (x < min) {
            min = x;
        }
        if (x > max) {
            max = x;
        }
        n++;
    }
    
    printf("%d %d %.3f\n", min, max, (double)s / n);
    
    return 0;
}