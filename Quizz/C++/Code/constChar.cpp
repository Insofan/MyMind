// 
// @ClassName constChar
// @Description 指针常量与字符串常量的冲突
// @Date 18-11-4 下午8:48
// @Created by Insomnia
//

#include <iostream>
using namespace std;
int main() {
    char * const str = "apple";
    *str = "orange";
    cout << str << endl;
    return 0;
}
