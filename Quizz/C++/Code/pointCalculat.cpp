// 
// @ClassName pointCalculat
// @Description 函数指针实现四则运算
// @Date 18-11-18 下午8:19
// @Created by Insomnia
//


#include <iostream>

using namespace std;

int add(int a, int b) { return  a + b;}
int myMinus(int a, int b) { return a - b;}
int multi(int a, int b) { return  a * b;}

int process(int a, int b, char operation) {
    switch (operation) {
        case '+':
            return add(a, b);
        case '-':
            return myMinus(a, b);
        case '*':
            return multi(a, b);
        default:
            return 0;
    }
}

int main() {

    int a = 10, b = 20;
    int res1 = process(a, b, '+');
    int res2 = process(a, b, '-');
    int res3 = process(a, b, '*');

    cout << res1 << " " << res2 << " " << res3 << endl;

    return 0;
}