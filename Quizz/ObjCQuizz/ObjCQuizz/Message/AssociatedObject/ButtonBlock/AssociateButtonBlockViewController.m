//
//  AssociateButtonBlockViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/29.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "AssociateButtonBlockViewController.h"
#import "UIButton+Block.h"
@interface AssociateButtonBlockViewController ()

@end

@implementation AssociateButtonBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    @weakify(self);
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    button1.frame = CGRectMake(50, 150, 250, 100);
    button1.backgroundColor = [UIColor blueColor];
    button1.buttonStr = @"Button动态添加属性";
    [button1 setTitle:@"Button的Block回调" forState:UIControlStateNormal];
    [button1 hx_clickCallBack:^(UIButton * _Nonnull button) {
        NSLog(@"Button 回掉点击成功, %@", button.buttonStr);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
