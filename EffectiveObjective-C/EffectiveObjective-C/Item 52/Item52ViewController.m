//
//  Item52ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item52ViewController.h"
#import "Item52FirTimer.h"
@interface Item52ViewController ()

@end

@implementation Item52ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    Item52FirTimer *firTimer = [Item52FirTimer new];

    /* 循环引用 在 viewWillDisappear 取消
     */
//    [firTimer startPolling];

    [firTimer hx_startPolling];
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
