//
//  UIScrollView+Forwarding.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/25.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "UIScrollView+Forwarding.h"
#import "NSObject+TopVC.h"
@implementation UIScrollView(Forwarding)
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //1. 为即将转发的消息返回一个对应的方法签名(该签名后面用于对转发消息对象(NSInvocation *)anInvocation进行编码用)
    NSMethodSignature *signature = nil;
    if (aSelector == @selector(setContentInsetAdjustmentBehavior:)) {
        signature = [UIViewController instanceMethodSignatureForSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)];
    } else {
        signature = [super methodSignatureForSelector:aSelector];
    }
    return signature;
}
//2. 开始消息转发((NSInvocation *)anInvocation封装了原有消息的调用，包括了方法名，方法参数等)
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    BOOL automaticallyAdjustsScrollViewInsets  = NO;
    UIViewController *topmostViewController = [self hx_topViewController];
    //3. 于转发调用的API与原始调用的API不同，这里我们新建一个用于消息调用的NSInvocation对象viewControllerInvocation并配置好对应的target与selector
    NSInvocation *viewControllerInvocation = [NSInvocation invocationWithMethodSignature:anInvocation.methodSignature];
    [viewControllerInvocation setTarget:topmostViewController];
    [viewControllerInvocation setSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)];
    //4. 配置所需参数:由于每个方法实际是默认自带两个参数的:self和_cmd，所以我们要配置其他参数时是从第三个参数开始配置
    [viewControllerInvocation setArgument:&automaticallyAdjustsScrollViewInsets atIndex:2];
    //5. 消息转发
    [viewControllerInvocation invokeWithTarget:topmostViewController];
}
@end
