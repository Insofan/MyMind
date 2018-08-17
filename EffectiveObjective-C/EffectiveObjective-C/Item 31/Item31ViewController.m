//
//  Item31ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/17.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item31ViewController.h"

@interface Item31ViewController ()
@property (assign, nonatomic) BOOL closed;
@end

@implementation Item31ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)dealloc {
    //要移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //如果 一个类 必须要执行某些关闭方法比如 close
    //则可以添加
    if (!_closed) {
        [self close];
    }
}

- (void)close {
    ///some t hing
    _closed = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
