//
//  Person.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/12.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Person.h"

@implementation Person
// 无参数 无返回值
- (void)noArgumentsAndNoReturnValue
{
    NSLog(@"方法名：%s", __FUNCTION__);
}

// 带一个参数 无返回值
- (void)hasArguments:(NSString *)arg
{
    NSLog(@"方法名：%s, 参数：%@", __FUNCTION__, arg);
}

// 无参数 有返回值
- (NSString *)noArgumentsButReturnValue
{
    NSLog(@"方法名：%s, 返回值：%@", __FUNCTION__, @"不带参数，但是带有返回值");
    return @"不带参数，但是带有返回值";
}

// 带两个参数 有返回值
- (int)hasArguments:(NSString *)arg andReturnValue:(int)arg1
{
    NSLog(@"方法名：%s, 参数：%@, 返回值：%d", __FUNCTION__, arg, arg1);
    return arg1;
}

- (NSString *)sayHello:(NSString *)name age:(NSInteger)age {
    NSLog(@"method: %s name: %@ age: %tu", __func__, name, age);
    return [NSString stringWithFormat:@"%@ age %tu say hello", name, age];
}

@end
