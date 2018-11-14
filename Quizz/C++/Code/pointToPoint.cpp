// 
// @ClassName pointToPoint
// @Description 简述指向指针的指针
// @Date 18-11-14 下午7:25
// @Created by Insomnia
//

#include <iostream>

using namespace std;

int main() {
    int a = 10, b = 20;
    int *q = &a;
    int **p = &q;
    **p = 30;
    
    cout << a << endl;
    cout << b << endl;
    return 0;
}
