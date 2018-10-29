//
//  UIButton+Block.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/29.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>
static const char *kCallBack = "callBack";
static const char *kButtonStr = "buttonStr";
@implementation UIButton(HXBlock)
- (void)hx_clickCallBack:(HXButtonCallBack)callBack {
    objc_setAssociatedObject(self, kCallBack, callBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //设置关联的click
    [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked {
    HXButtonCallBack callBack = objc_getAssociatedObject(self, kCallBack);
    if (callBack) {
        callBack(self);
    }
}

- (void)setButtonStr:(NSString *)buttonStr {
    objc_setAssociatedObject(self, kButtonStr, buttonStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)buttonStr {
    return objc_getAssociatedObject(self, kButtonStr);
}
@end
