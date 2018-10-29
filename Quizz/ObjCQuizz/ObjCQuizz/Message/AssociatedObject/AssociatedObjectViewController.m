//
//  AssociatedObjectViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/29.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "AssociatedObjectViewController.h"
#import <objc/runtime.h>
#import "UITapGestureRecognizer+Associate.h"
@interface AssociatedObjectViewController ()<UIAlertViewDelegate>
@end

@implementation AssociatedObjectViewController{
     UIAlertView *_myAlert;
}
static void *MyAlertViewKey = "MyAlertViewKey";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.dataStr = @"测试Associate Obj";
    [self.view addGestureRecognizer:singleTap];
    
    @weakify(self);
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(50, 150, 250, 100);
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"Item 10" forState:UIControlStateNormal];
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self popAlertView];
    }];
}

- (void)singleTap:(UITapGestureRecognizer *)tap {
    NSLog(@"Associate str =  %@", tap.dataStr);
}

- (void)popAlertView {
    //这部分代码因为 SafeMethod 中的签名有问题 正常代码见Effective Item 10, 先取消掉 SafeMethod 文件
    @weakify(self);

    _myAlert = [[UIAlertView alloc] initWithTitle:@"测试Associate" message:@"测试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

//    _myAlert.alertViewStyle = UIAlertViewStyleDefault;

    void (^alertBlock)(NSInteger) = ^(NSInteger buttonIndex){

        if (buttonIndex == 0) {
            @strongify(self);
            [self doCancel];
        } else {
            @strongify(self);
            [self doContinue];
        }
    };
    
    objc_setAssociatedObject(_myAlert, MyAlertViewKey, alertBlock, OBJC_ASSOCIATION_COPY);
    [_myAlert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^alertBlock)(NSInteger) = objc_getAssociatedObject(alertView, MyAlertViewKey);
    alertBlock(buttonIndex);
}


- (void)doCancel {
    NSLog(@"取消");
}

- (void)doContinue {
    NSLog(@"确定");
}
@end
