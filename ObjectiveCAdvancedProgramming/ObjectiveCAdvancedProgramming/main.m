//
//  main.m
//  ObjectiveCAdvancedProgramming
//
//  Created by Insomnia on 2018/10/29.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    //clang -rewrite-objc main.m
    void (^blk) (void) = ^ {
        printf("Block\n");
    };
    blk();
    return 0;
}
