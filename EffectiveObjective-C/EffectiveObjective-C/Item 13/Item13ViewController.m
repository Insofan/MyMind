//
//  Item13ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item13ViewController.h"
#import <objc/runtime.h>
//https://github.com/RuiAAPeres/UIViewController-Swizzled
@interface Item13ViewController ()

@end

@implementation Item13ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    NSString *originStr = @"a b c d e";
    NSLog(@"%@", [originStr uppercaseString]);
    [self swapMethod];
    
    

}

- (void)swapMethod {
    Method firstMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method secondMethod = class_getInstanceMethod([NSString class], @selector(uppercaseString));
    method_exchangeImplementations(firstMethod, secondMethod);
    
    NSString *originStr = @"f g h i j";
    NSLog(@"%@", [originStr lowercaseString]);
    NSLog(@"%@", [originStr uppercaseString]);
}

/**
 封装代码
 */
+ (void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

@end
