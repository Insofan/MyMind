//
//  Item38Tool.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NSString* (^ArgumentWithReturnBlock) (NSString *str, BOOL flag);
@interface NSObject(Item38Tool)
+ (NSInteger)item38_tool:(ArgumentWithReturnBlock)returnBlock;
@end
