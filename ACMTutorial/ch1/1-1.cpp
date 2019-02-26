// 
// @ClassName 1
// @Description TODO
// @Date 19-2-26 下午11:18
// @Created by Insomnia
//

#include <stdio.h>
#include <math.h>

int main() {

    const double pi = acos(-1.0);
    double r, h, s1, s2, s;
    scanf("%lf%lf", &r, &h);

    s1 = 2 * pi * r * h;
    s2 = 2 * pi * pow(r, 2);

    s = s1 + s2;
    printf("Area = %.3f\n", s);

    return 0;
}
