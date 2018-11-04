// 
// @ClassName ArrayPoint
// @Description 数组指针与二维数组的区别
// @Date 18-11-4 下午9:05
// @Created by Insomnia
//

#include <iostream>

using namespace std;

int main() {
    int a[2][5] = {{1, 2, 3, 4, 5},{6, 7, 8, 9, 10}};
    int (*p)[5] = a;
    cout << p << endl;
    cout << p + 1 << endl;
    
    cout << *p << endl;
    cout << *(p + 1) << endl;
    cout << *p + 1  << endl;
    
    cout << **p << endl;
    cout << **(p + 1) << endl;
    cout << *(*p + 1) << endl;
    
    return 0;
}
