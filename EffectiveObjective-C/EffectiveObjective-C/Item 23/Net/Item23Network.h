//
//  Item23Network.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/9.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item23NetworkDelegate.h"


@interface Item23Network : NSObject
#warning 注意循环引用
@property(weak, nonatomic) id <Item23NetworkDelegate> delegate;

- (void)sendSuccess;

- (void)sendFail;

- (void)sendProgress;
@end
