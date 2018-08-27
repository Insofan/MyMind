//
//  Item38Tool.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item38Tool.h"

@implementation NSObject(Item38Tool)
+ (NSInteger)item38_tool:(ArgumentWithReturnBlock)returnBlock{
    if (returnBlock) {
        returnBlock(@"38 tool", true);
    }
    return 38;
}
@end
