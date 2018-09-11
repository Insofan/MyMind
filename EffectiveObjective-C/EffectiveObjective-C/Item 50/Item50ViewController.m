//
//  Item50ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item50ViewController.h"
#import "Item50Object.h"
@interface Item50ViewController ()

@end

@implementation Item50ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
    // Do any additional setup after loading the view.
    [self testCache];
}

- (void)testCache {
    NSURL *dataUrl = [[NSURL alloc] initWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535350273861&di=ddbd99faae33cafe0539f7b09c178368&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D56ffb4aeefcd7b89e96c3a8b3f254291%2F663490ef76c6a7ef4ce31c42f4faaf51f2de66b6.jpg"];
    Item50Object *cacheObject = [[Item50Object alloc] init];
    NSLog(@"First download -------------------------");
    [cacheObject downloadDataForURL:dataUrl];
    [NSThread sleepForTimeInterval:3];
    NSLog(@"Second download ------------------------");
    [cacheObject downloadDataForURL:dataUrl];
    NSLog(@"Third download ------------------------");
    [cacheObject downloadDataForURL:dataUrl];
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
