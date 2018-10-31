//
//  UIViewController+Logging.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/30.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "UIViewController+Logging.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIViewController (Logging)

+ (void)load {
    swizzleMethod([self class], @selector(viewDidAppear:), @selector(hx_viewDidAppear:));
}

- (void)hx_viewDidAppear:(BOOL)animated {
    //call original method, 相当于调用原来的viewDidAppear
//    [self hx_viewDidAppear:animated];
    [self viewDidAppear:animated];
    NSLog(@"Swizz Method class : %@", NSStringFromClass([self class]));
}

void swizzleMethod(Class aClass, SEL oriSel, SEL swizzleSel) {
    Method oriMethod     = class_getClassMethod(aClass, oriSel);
    Method swizzleMethod = class_getClassMethod(aClass, swizzleSel);

    //测试能否添加Method, 避免多次调用
    BOOL   addFlag = class_addMethod(aClass, oriSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (addFlag) {
        class_replaceMethod(aClass, swizzleMethod, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swizzleMethod);
    }
}
@end
