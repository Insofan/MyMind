//
//  Item10ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/9.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item10ViewController.h"
#import <objc/runtime.h>
#import "NSObject+Associate.h"
#import "UITapGestureRecognizer+Associate.h"
@interface Item10ViewController ()<UIAlertViewDelegate>

@end

@implementation Item10ViewController
static void *MyAlertViewKey = "MyAlertViewKey";
- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(50, 150, 250, 100);
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"Item 10" forState:UIControlStateNormal];
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
     
        [self popAlertView];
    }];
    [self asscoiteTap];
    //可以为uibutton , uigesture 添加参数
    [self associateObject];
}

#pragma mark UITap
- (void)asscoiteTap {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLogic:)];
    singleTap.dataStr = @"test associate";
    [self.view addGestureRecognizer:singleTap];
}
- (void)tapLogic:(UITapGestureRecognizer *)singleTap {
    NSLog(@"tap str %@", singleTap.dataStr);
}
#pragma mark NSObject

- (void)associateObject {
    NSObject *object = [NSObject new];
    object.associate = @"testAsso";
    NSLog(@"nsobject asso %@", object.associate);

}
#pragma mark Run time & alert delegate
- (void)popAlertView {
    @weakify(self);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Question" message:@"What do you want to do?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    alert.delegate = self;
    
    void (^alertBlock)(NSInteger) = ^(NSInteger buttonIndex){
        @strongify(self);
        if (buttonIndex == 0) {
            [self doCancel];
        } else {
            [self doContinue];
        }
    };

    objc_setAssociatedObject(alert, MyAlertViewKey, alertBlock, OBJC_ASSOCIATION_COPY);
    [alert show];
 }

 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^alertBlock)(NSInteger) = objc_getAssociatedObject(alertView, MyAlertViewKey);
    alertBlock(buttonIndex);
 }



#pragma mark Logic

- (void)doCancel {
    NSLog(@"cancel");
}

- (void)doContinue {
    NSLog(@"continue");
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
