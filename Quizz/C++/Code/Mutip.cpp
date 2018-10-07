// 
// Created by Insomnia on 18-10-7.
//

#include <stdio.h>
#include <iostream>
//时间复杂度位n的情况下, 不使用条件语句打印乘法口诀表

using namespace std;
int mutip(int n) {
    int row = 1;
    int col = 1;
    char change[3] = " \n";

    while (row <= n) {
        cout << row << "*" << col << " = " << row * col << change[col/row];
        int tmp = col % row + 1;
        row = row + (col / row);
        col = tmp;
    }
}
int main() {
    mutip(9);
    return 0;
}