//
//  MsgResolveObject.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "MsgResolveObject.h"
#import <objc/message.h>
@implementation MsgResolveObject

void saveSendMsg(id obj, SEL _cmd) {
    NSLog(@"Save unrecognized selector");
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(sendMessage:)) {
        //下面block相当于
        //class_addMethod([self class], sel, (IMP)saveSendMsg, "v@:");
        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self, NSString *msg) {
            NSLog(@"Save unrecognized selector sendMessage");

        }), "v@:");
        return true;
    }
    return [super resolveInstanceMethod:sel];
}
@end
