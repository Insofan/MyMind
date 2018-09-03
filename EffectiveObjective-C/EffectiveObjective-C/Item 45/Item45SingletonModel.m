//
//  Item45SingletonModel.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/3.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item45SingletonModel.h"

@implementation Item45SingletonModel
+ (id)sharedInstance {
    static Item45SingletonModel* shared = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}
@end
