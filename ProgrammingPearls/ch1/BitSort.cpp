//
// Created by Insomnia on 2018/10/15.
//

#include <stdio.h>
#include <bitset>
#include <vector>
#include <iostream>
#include "../utils/RandomVec.h"
#include <climits>


using namespace std;

void printVec(vector<int> &vec) {
    for (auto val : vec) {
        cout << val  << " ";
    }
    cout << endl;
}

int main() {

    RandomVec randomVec;
    vector<int> vec = randomVec.randomUniqueVec(10, 12);
    cout << "Before Sort :" << endl;
    printVec(vec);

    bitset<12> bitMap;


    for (auto val : vec) {
        bitMap.set(val);
    }

    vector<int> res;
    vector<int> missRes;
    for (int i = 0; i < bitMap.size(); ++i) {
        if (bitMap.test(i)) {
            res.push_back(i);
        } else {
            missRes.push_back(i);
        }
    }

    cout << "After Sort :" << endl;
    printVec(res);
    cout << "Miss Number :" << endl;
    printVec(missRes);





    return 0;
}
