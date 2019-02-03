//
//  UIButton+SingleClick.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/11/1.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "UIButton+SingleClick.h"

static const char *kAcceptInterval = "interval";
static const char *kIgnoreEvent = "ignore";
@interface UIButton()
@property (nonatomic, assign) BOOL ignoreEvent;
@end
@implementation UIButton(SingleClick)
- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, kAcceptInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self, kAcceptInterval) doubleValue];
}

- (void)setIgnoreEvent:(BOOL)ignoreEvent {
    objc_setAssociatedObject(self, kIgnoreEvent, @(ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ignoreEvent {
    return [objc_getAssociatedObject(self, kIgnoreEvent) boolValue];
}

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(hx_swizzSendAction:to:forEvent:);
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        //添加成功了 说明 本类中不存在methodB 所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}



- (void)hx_swizzSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.ignoreEvent) {
        NSLog(@"Button click ignore");
        return;
    }
    
    if (self.acceptEventInterval > 0) {
        self.ignoreEvent = true;
        [self performSelector:@selector(setIgnoreEventWithFalse) withObject:nil afterDelay:self.acceptEventInterval];
    }
   //这里并不是递归, 已经完成替换, 实际上是调用 sendAction:to:forEvent:
    [self hx_swizzSendAction:action to:target forEvent:event];
}

- (void)setIgnoreEventWithFalse {
    self.ignoreEvent = false;
}

@end
