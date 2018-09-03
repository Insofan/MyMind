//
//  Item44ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/3.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item44ViewController.h"

@interface Item44ViewController ()

@end

@implementation Item44ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
//    [self gcdGroup1];
    [self gcdGroup2];
}

- (void)gcdGroup1{
    dispatch_queue_t queue = dispatch_queue_create("Inso", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"mission 1");
    });
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@"mission 2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"mission 3");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch noti");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_wait(group, 5 * NSEC_PER_SEC);
        NSLog(@"wait");
    });
}

- (void)gcdGroup2 {
    //用enter level 这个特点使得它非常适合处理异步任务的同步当异步任务开始前调用dispatch_group_enter异步任务结束后调用dispatch_group_leve, 类似效果NSOperation 的dependecy 
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"mission 1");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"mission 2");
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"dispatch noti complete");
    });
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
