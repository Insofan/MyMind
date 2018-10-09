//
// Created by Insomnia on 2018/9/25.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import "KVOImplementViewController.h"
#import "KVOObject.h"
#import "NSObject+hx_KVO.h"
@interface KVOImplementViewController ()
@property(nonatomic, strong) UIButton  *button;
@property(strong, nonatomic) UILabel   *label;
@property(strong, nonatomic) KVOObject *kvoObject;
@end
@implementation KVOImplementViewController

- (void)buttonLogic {
    @weakify(self);
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
        @strongify(self);
        self.kvoObject.name = [self.kvoObject.name isEqualToString:@"second name"] ?  @"first name" : @"second name";
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kvoObject = [KVOObject new];
    self.kvoObject.name = @"first name";
//    [self.kvoObject setName:@"first name"];
    [self.kvoObject hx_addObserverForObject:self keyPath:@"name"];

}

- (void)hx_observeValueForObject:(id)object keyPath:(NSString *)keyPath oldValue:(id)oldValue newValue:(id)newValue {
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"Old value: %@, New value: %@", oldValue, newValue);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.label.text = [NSString stringWithFormat:@"%@", self.kvoObject.name];
        }];
    }

  
}


@end
