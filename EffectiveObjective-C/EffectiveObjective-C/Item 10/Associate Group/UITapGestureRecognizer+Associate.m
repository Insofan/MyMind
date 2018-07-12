//
//  UITapGestureRecognizer+Associate.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/12.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "UITapGestureRecognizer+Associate.h"
#import <objc/runtime.h>
static char *bindKey = "bindKey";
@implementation UITapGestureRecognizer(AssoTest)

- (void)setDataStr:(NSString *)dataStr {
    objc_setAssociatedObject(self, bindKey, dataStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)dataStr {
    return objc_getAssociatedObject(self, bindKey);
}
@end
