// 
// @ClassName 2
// @Description TODO
// @Date 19-3-1 下午11:55
// @Created by Insomnia
//

#include <stdio.h>
#include <math.h>

int main() {
    //double pi = acos(-1);
    //printf("%.3f\n", pi);

    double sum = 0;

    for (int i = 0;;i++) {
        double  term = 1.0 / (i * 2 + 1);
        if (i % 2 == 0) {
            sum += term;
        } else {
            sum -= term;
        }

        if (term < 1e-6) {
            break;
        }
    }

    printf("%.6f %.6f\n", sum, acos(-1) / 4);

    return 0;
}
