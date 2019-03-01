// 
// @ClassName UnknownNumOfInputs
// @Description TODO
// @Date 19-3-1 上午12:43
// @Created by Insomnia
//


#include <iostream>
using namespace std;

int main() {
    int sum = 0, value = 0;
    //这种读取时, 不为int则可以停止输入
    while (cin >> value) {
        sum += value;
    }

    cout << "Sum is " << sum << endl;
    return 0;
}
