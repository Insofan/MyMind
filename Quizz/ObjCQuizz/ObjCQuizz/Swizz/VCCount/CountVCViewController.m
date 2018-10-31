//
// Created by Insomnia on 2018/10/30.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import "CountVCViewController.h"
#import "UIViewController+Logging.h"

@implementation CountVCViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"Original Method");
}

@end