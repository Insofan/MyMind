//
//  KVOBlockViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/11/5.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "KVOBlockViewController.h"
#import "KVOObject.h"
@interface KVOBlockViewController ()
@property(nonatomic, strong) UIButton  *button;
@property(strong, nonatomic) UILabel   *label;
@property(strong, nonatomic) KVOObject *kvoObject;
@end

@implementation KVOBlockViewController

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
//    [self.kvoObject hx_addObserverForObject:self keyPath:@"name"];

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
