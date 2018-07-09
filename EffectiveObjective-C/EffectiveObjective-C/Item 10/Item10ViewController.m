//
//  Item10ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/9.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item10ViewController.h"

@interface Item10ViewController ()

@end

@implementation Item10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(50, 150, 250, 100);
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"Item 10" forState:UIControlStateNormal];
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self popAlertView];
    }];
}

- (void)popAlertView {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
