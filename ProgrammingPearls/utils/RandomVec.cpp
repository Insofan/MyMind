//
// Created by Insomnia on 2018/10/15.
//


#include "RandomVec.h"
#include <set>

vector<int> RandomVec::randomVec(int len, int maxNum) {
    srand((unsigned) time(NULL));
    vector<int> res;

    for (int i = 0; i < len; i++) {
        int x = rand() % maxNum;
        res.push_back(x);
    }
    return res;
}

vector<int> RandomVec::randomUniqueVec(int len, int maxNum) {
   set<int> s;
   srand((unsigned) time(NULL));
   vector<int> res;
   while (s.size() <  len) {
       int x = rand() % maxNum;
       if (s.count(x) == 0) {
           s.insert(x);
           res.push_back(x);
       }
   }
   return res;
}

