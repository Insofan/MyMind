//
//  ForwardingTargetObject.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ForwardingTargetObject.h"
#import "ForwardingTargetBackupObject.h"
#import <objc/message.h>
@implementation ForwardingTargetObject

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(sendMessage:)) {
        return [[ForwardingTargetBackupObject alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}

/* 如果实现走这个, 如果没实现走backup
- (void)sendMessage:(NSString *)msg{
    NSLog(@"Original Obj send %@", msg);
}
 */
@end
