//
//  SafeMethod.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/25.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "SafeMethod.h"
#import <objc/message.h>
@implementation NSObject(SafeMethod)
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"SafeMethod>>>>在类:%@中, 未实现该方法:%@", NSStringFromClass([anInvocation.target class]), NSStringFromSelector(anInvocation.selector));
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (![self respondsToSelector:aSelector]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }else {
        return nil;
    }
}
@end
