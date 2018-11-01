// 
// @ClassName ConstPointErr
// @Description 指针常量和常量指针的错误
// @Date 18-11-1 下午10:01
// @Created by Insomnia
//
#include <iostream>
using namespace std;
int main() {
    int m = 10;
    const int n = 20;

    const int *ptr1 = &m;
    int * const ptr2 = &m;

    ptr1 = &n;
    ptr2 = &n;

    *ptr1 = 3;
    *ptr2 = 4;

    int *ptr3 = &n;
    const int *ptr4 = &n;

    int *const ptr5;
    ptr5 = &m;

    const int *const ptr6 = &m;
    *ptr6 = 5;
    ptr6 = &n;


    return 0;
}
