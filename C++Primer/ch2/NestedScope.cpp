// 
// @ClassName NestedScope
// @Description TODO
// @Date 19-3-3 下午11:44
// @Created by Insomnia
//

#include <iostream>

using namespace std;

// global
int reused = 42;

int main() {

    int unique = 0;

    //global
    std::cout << reused << " " << unique << std::endl;
    //local
    int reused = 0;
    std::cout << reused << " " << unique << std::endl;
    //global
    std::cout << ::reused << " " << unique << std::endl;
    return 0;
}
