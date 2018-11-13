// 
// @ClassName ptrArr
// @Description 简述指针数组与指向指针的指针的区别
// @Date 18-11-13 下午11:17
// @Created by Insomnia
//

#include <iostream>

using namespace std;

int main() {

    char *str[4] = {"welcome", "to", "new", "Beijing"};
    char **p = str + 1;

    str[0] = (*p++) + 1;
    str[1] = *(p + 1);
    str[2] = p[1] + 3;
    str[3] = p[0] + (str[2] - str[1]);
    
    cout << str[0] << endl;
    cout << str[1] << endl;
    cout << str[2] << endl;
    cout << str[3] << endl;

    return 0;
}
