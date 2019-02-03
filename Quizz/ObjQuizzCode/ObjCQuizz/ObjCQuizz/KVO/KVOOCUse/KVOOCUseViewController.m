//
//  KVOOCUseViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/9/25.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "KVOOCUseViewController.h"
#import "KVOObject.h"

@interface KVOOCUseViewController ()
@property(nonatomic, strong) UIButton  *button;
@property(strong, nonatomic) UILabel   *label;
@property(strong, nonatomic) KVOObject *kvoObject;
@end

@implementation KVOOCUseViewController

- (void)buttonLogic {
    @weakify(self);
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
        @strongify(self);
        self.kvoObject.someValue++;
        self.kvoObject.name = [self.kvoObject.name isEqualToString:@"second name"] ?  @"first name" : @"second name";
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kvoObject = [KVOObject new];

    [self.kvoObject setValue:@(1) forKey:@"someValue"];
    //对象则不用
    self.kvoObject.name = @"first name";
    [self.kvoObject addObserver:self forKeyPath:@"someValue" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [self.kvoObject addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    self.label.text = [NSString stringWithFormat:@"%tu", self.kvoObject.someValue];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    //或者写成object == self.kvoObjcet 看需求
    if ([keyPath isEqualToString:@"someValue"] && [object isKindOfClass:[KVOObject class]]) {
        NSLog(@"Old value: %@, New value: %@", change[@"old"], change[@"new"]);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.label.text = [NSString stringWithFormat:@"%tu", self.kvoObject.someValue];
        }];
    }

    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"Old name value: %@, New name value: %@", change[@"old"], change[@"new"]);
    }
}

@end
