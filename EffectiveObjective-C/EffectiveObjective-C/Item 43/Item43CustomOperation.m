//
//  Item43CustomOperation.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/31.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item43CustomOperation.h"

@implementation Item43CustomOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}

@end
