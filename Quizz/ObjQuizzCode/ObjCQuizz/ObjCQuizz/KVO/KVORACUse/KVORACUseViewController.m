//
// Created by Insomnia on 2018/9/25.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import "KVORACUseViewController.h"
#import "KVOObject.h"
@interface KVORACUseViewController()
@property(nonatomic, strong) UIButton  *button;
@property(strong, nonatomic) UILabel   *label;
@property(strong, nonatomic) KVOObject *kvoObject;
@end

@implementation KVORACUseViewController


- (void)buttonLogic {
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
        self.kvoObject.someValue++;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kvoObject = [KVOObject new];
    [self.kvoObject setValue:@(11) forKey:@"someValue"];

    [RACObserve(self,self.kvoObject.someValue) subscribeNext:^(id x) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.label.text = [NSString stringWithFormat:@"%tu", self.kvoObject.someValue];
        }];
    }];
}

@end