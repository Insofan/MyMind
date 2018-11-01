// 
// @ClassName PointConst
// @Description 关于指针常量和常量指针的代码
// @Date 18-11-1 下午9:24
// @Created by Insomnia
//
#include <iostream>

using namespace std;

int main() {
    int a = 10, b = 20;
    //指针常量

    int * const p = &a;
    cout << a << endl;
    cout << p << endl;
    p = &b;
    *p = 30;
    cout << a << endl;
    cout << p << endl;

    //常量指针
    int c = 10, d = 20;
    const int *q = &c;
    cout << c << endl;
    cout << q << endl;
    q = &d;
    cout << c << endl;
    cout << q << endl;
    return 0;
}
