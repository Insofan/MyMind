//
//  Item43ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/28.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item43ViewController.h"

@interface Item43ViewController ()

@end

@implementation Item43ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];

    /**
     * 当前线程使用子类, NSInvocationOperation
     */
//    [self inovocationOperation];

    /**
     * 在其他线程使用 NSInvocationOperation
     */
//    [self inovocationOperationOther];

    /**
     * 当前线程使用NSBlockOperation
     */
//    [self blockOperation];
    /**
     * 使用NSBlockOperation的executionblock 方法
     */
    [self blockOperationAddExecutionBlock];

}


#pragma mark 当前线程使用子类, NSInvocationOperation

- (void)inovocationOperation {
    NSLog(@"%s", __func__);
    //1. 创建 NSInvocationOperation
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    //2. 调用 start方法开始执行操作
    [operation start];
}

#pragma mark 在其他线程使用 NSInvocationOperation

- (void)inovocationOperationOther {
    NSLog(@"%s", __func__);
    //这个方法可以直接生成一个线程并启动它，而且无需为线程的清理负责
    [NSThread detachNewThreadSelector:@selector(inovocationOperation) toTarget:self withObject:nil];
}

#pragma mark 当前线程使用NSBlockOperation

- (void)blockOperation {
    NSLog(@"%s", __func__);
// 1.创建 NSBlockOperation 对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }];
    // 2.调用 start 方法开始执行操作
    [operation start];
}

#pragma mark 使用NSBlockOperation的executionblock 方法

- (void)blockOperationAddExecutionBlock {
    NSLog(@"%s", __func__);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2 ; ++i) {
           [NSThread sleepForTimeInterval:2];
            NSLog(@"1----%@", [NSThread currentThread]);
        }
    }];

    [operation addExecutionBlock:^{
        for (int i = 0; i < 2 ; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2----%@", [NSThread currentThread]);
        }
    }];

    [operation addExecutionBlock:^{
        for (int i = 0; i < 2 ; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3----%@", [NSThread currentThread]);
        }
    }];

    [operation addExecutionBlock:^{
        for (int i = 0; i < 2 ; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4----%@", [NSThread currentThread]);
        }
    }];

    [operation start];

}
#pragma mark Task

- (void)task1 {
    for (int i = 0; i < 2; ++i) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@", [NSThread currentThread]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
