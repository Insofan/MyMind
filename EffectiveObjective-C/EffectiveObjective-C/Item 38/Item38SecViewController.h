//
//  Item38SecViewController.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SomeBlock)(NSString *inputValue, BOOL flag);

@interface Item38SecViewController : UIViewController
@property (nonatomic, strong) SomeBlock someBlock;
@end
