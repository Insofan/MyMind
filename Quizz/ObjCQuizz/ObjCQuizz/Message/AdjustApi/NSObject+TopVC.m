//
//  NSObject+TopVC.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/25.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "NSObject+TopVC.h"

@implementation NSObject (TopVC)
- (UIViewController *)hx_topViewController {
    UIViewController *resultVc;
    resultVc = [self hx_getTopViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVc.presentedViewController) {
        resultVc = [self hx_getTopViewController:resultVc.presentedViewController];
    }
    return resultVc;
}

- (UIViewController *)hx_getTopViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self hx_getTopViewController:[(UINavigationController *)vc      topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self hx_getTopViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}
@end
