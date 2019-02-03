//
// Created by Insomnia on 2018/11/5.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import "ArrayViewController.h"
#import "NSArray+Safe.h"


@implementation ArrayViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
    // 测试代码
    NSArray *array = @[@0, @1, @2, @3];
    [array objectAtIndex:3];
    //本来要奔溃的
    [array objectAtIndex:4];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"Original Method");
}
@end