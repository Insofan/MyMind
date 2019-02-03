//
//  ForwardingInvocationObj.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ForwardingInvocationObj.h"
#import "ForwardingTargetBackupObject.h"
#import "ForwardingInvocationBackupObj.h"
#import <objc/message.h>
@implementation ForwardingInvocationObj
/*
 * normal forwarding: forwardInvocation是分发中心, 在发送前runtime会向对象发送methodSignatureForSelector, 所以要重写, normal forwarding 可以连续发送多个对象
 *
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    ForwardingTargetBackupObject *backObj = [ForwardingTargetBackupObject new];
    ForwardingInvocationBackupObj *otherBackObj = [ForwardingInvocationBackupObj new];
//    if ([backObj respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:backObj];
//    } else {
//        [self doesNotRecognizeSelector:sel];
//    }
    if (sel == @selector(sendMessage:)) {
        [anInvocation invokeWithTarget:backObj];
    } 
    
    if (sel == @selector(sendOtherMessage:)) {
        [anInvocation invokeWithTarget:otherBackObj];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}

@end
