// 
// @ClassName ex3
// @Description TODO
// @Date 19-3-9 下午9:54
// @Created by Insomnia
//
#include <iostream>
#include <string.h>

using namespace std;

//scanf 这个函数碰到tab 或者空格会停止, 所以不能用来输入文章
int main() {

    int c, q = 1;
    while (c = getchar() != EOF) {
        if (c == '"') {
            printf("%s", q == 1 ? "``" : "''");
            q = !q;
        } else {
            printf("%c", c);
        }
    }

    return 0;
}