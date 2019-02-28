// 
// @ClassName e1
// @Description TODO
// @Date 19-3-1 上午12:16
// @Created by Insomnia
//

#include <stdio.h>
#include <math.h>

int main() {
    int n;
    scanf("%d", &n);
    double pi = acos(-1);
    double co = cos(n * acos(- 1) / 180);
    double si = sin(n * acos(- 1) / 180);

    printf("%.3f %.3f %.3f\n", co, si, pi);

    return 0;
}