// 
// @ClassName 1
// @Description TODO
// @Date 19-2-26 下午11:29
// @Created by Insomnia
//


#include <iostream>

void swap1(int &x, int &y) {
    x = x ^ y;
    y = x ^ y;
    x = x ^ y;
}

void swap2(int &x, int &y) {
    x = x + y;
    y = x - y;
    x = x - y;
}

int main() {
    int x, y;
    scanf("%d%d",&x, &y);
    //swap1(x, y);
    swap2(x, y);
    printf("x: %d y:%d\n",x, y);

    return 0;
}