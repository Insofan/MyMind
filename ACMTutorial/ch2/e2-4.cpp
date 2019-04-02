// 
// @ClassName e2
// @Description TODO
// @Date 19-3-2 下午1:51
// @Created by Insomnia
//

#include <stdio.h>
#include <iostream>
#include <math.h>

using namespace std;
int main () {
    int n, m;

    while (cin >> n >> m) {
         double sum = 0.0;
        if (n == 0 || m == 0 || n == m || m >= 1e6) {
            break;
        }

        while (n <= m) {
            //因为连乘会导致溢出, 所以需要连触发
            sum += (1.0/ n/ n);
            n++;
        }

        printf("%.5f\n", sum);
    }

    return 0;
}