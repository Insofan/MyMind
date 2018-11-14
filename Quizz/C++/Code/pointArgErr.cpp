// 
// @ClassName pointArgErr
// @Description 指针作为参数的常见错误
// @Date 18-11-14 下午9:16
// @Created by Insomnia
//


#include <iostream>

using namespace std;

int find(char *s, char ch, char *sub) {
    for (int i = 0; *(s + i) != '\0'; i++) {
        if (*(s + i) == ch) {
           sub = s +i + 1;
            return i;
        }
    }
    return 0;
}


int find2(char *s, char ch, char **psub) {
    for (int i = 0; *(s + i) != '\0'; i++) {
        if (*(s + i) == ch) {
            *psub = s +i + 1;
            return i;
        }
    }
    return 0;
}

int main() {

    char fullName[] = {"Jordan#Michael"};
    char *givenName;

    int cnt = find(fullName, '#', givenName);

    //cout << givenName << "has a " << cnt << " characters'family name" << endl;
    char fullName2[] = {"Jordan#Michael"};
    char *givenName2 = NULL;
    int cnt2 = find2(fullName2, '#', &givenName2);
    cout << givenName2 << " has a " << cnt2 << " characters'family name" << endl;

    return 0;
}
