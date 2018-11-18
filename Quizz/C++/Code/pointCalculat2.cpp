// 
// @ClassName pointCalculat2
// @Description 函数指针实现四则运算
// @Date 18-11-18 下午8:32
// @Created by Insomnia
//

#include <iostream>

using namespace std;

int add(int a, int b) { return  a + b;}
int myMinus(int a, int b) { return a - b;}
int multi(int a, int b) { return  a * b;}

int process(int a, int b, int (*func) (int, int)) {
    return func(a, b);
}

int main() {

    int a = 10, b = 20;
    int res1 = process(a, b, add);
    int res2 = process(a, b, myMinus);
    int res3 = process(a, b, multi);

    cout << res1 << " " << res2 << " " << res3 << endl;

    return 0;
}