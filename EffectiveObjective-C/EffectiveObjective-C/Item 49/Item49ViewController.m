//
//  Item49ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item49ViewController.h"

@interface Item49ViewController ()

@end

@implementation Item49ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self bridgeArr];
}

- (void)bridgeArr {
    NSArray *anNSArr = @[@1, @2, @3, @4, @5];
    CFArrayRef aCfArr = (__bridge CFArrayRef)anNSArr;
    NSLog(@"Size of arr = %li", CFArrayGetCount(aCfArr));
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
