//
//  UIButton+Block.h
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/29.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^HXButtonCallBack)(UIButton *button);
@interface UIButton(HXBlock)
- (void)hx_clickCallBack:(HXButtonCallBack)callBack;
@property (copy, nonatomic) NSString *buttonStr;
@end

NS_ASSUME_NONNULL_END
