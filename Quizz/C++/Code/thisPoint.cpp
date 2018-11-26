// 
// @ClassName thisPoint
// @Description TODO
// @Date 18-11-26 下午10:03
// @Created by Insomnia
//

#include <iostream>

using namespace std;

class Student {
private:
    int age;

public:
    void setAge(int age){this->age = age;}
    int getAge(){ return this->age;}
};

int main() {
    Student std = Student();
    std.setAge(20);
    cout << std.getAge() << endl;
    getchar();
}