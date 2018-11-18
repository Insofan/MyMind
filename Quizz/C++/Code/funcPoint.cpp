// 
// @ClassName funcPoint
// @Description 函数指针
// @Date 18-11-18 下午7:55
// @Created by Insomnia
//

#include <iostream>

using namespace std;

int max(int a, int b) {
    return  a > b ? a : b;
}
int (*p)(int, int) = max;
int main() {
    int x = 10;
    int y = 20;
    //这两种写法相等,
    //int z = p(x, y);
            int z = (*p) (x, y);
    cout << z << endl;
    return 0;
}
