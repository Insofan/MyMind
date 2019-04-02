// 
// @ClassName e2
// @Description TODO
// @Date 19-3-4 上午1:03
// @Created by Insomnia
//

#include <stdio.h>
#include <iostream>

using namespace std;
int main () {
    // 不对
    for (int i = 123456789; i <= 987654321; i++) {
        int tmp = i / 10;
        if (i % tmp == 0) {
            continue;
        }
        int low = i % 100;
        int mid = (i / 100) % 100;
        int high = (i / 100000);

        if (mid / low == 2 && high / low == 3) {
            cout << i << endl;
        }
    }

    return 0;
}