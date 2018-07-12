//
//  NSObject+Associate.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/12.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "NSObject+Associate.h"
#import <objc/runtime.h>
@implementation NSObject(Associate)
- (void)setAssociate:(id)associate{
    objc_setAssociatedObject(self, @selector(associate), associate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associate {
    return objc_getAssociatedObject(self, _cmd);
}
@end
