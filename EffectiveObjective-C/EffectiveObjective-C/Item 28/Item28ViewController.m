//
//  Item28ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/14.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item28ViewController.h"

@interface Item28ViewController ()

@end

@implementation Item28ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //用代理隐藏
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
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
