// 
// @ClassName e2
// @Description TODO
// @Date 19-3-2 下午1:14
// @Created by Insomnia
//
#include <stdio.h>
#include <math.h>
#include <vector>

using namespace std;


int main() {


    for (int i = 100; i <= 999; i++) {
        int firNum = i / 100;
        int secNum = (i / 10 ) % 10;
        int thirNum = i % 10;

        if (i == (pow(firNum, 3) + pow(secNum, 3) + pow(thirNum, 3))) {
            printf("%d\n", i);
        }
    }

    return 0;
}