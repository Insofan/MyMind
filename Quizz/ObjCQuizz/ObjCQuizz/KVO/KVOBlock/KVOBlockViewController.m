//
//  KVOBlockViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/11/5.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "KVOBlockViewController.h"
#import "KVOObject2.h"
#import "KVO+Block.h"
@interface KVOBlockViewController ()
@property(nonatomic, strong) UIButton  *button;
@property(strong, nonatomic) UILabel   *label;
@property(strong, nonatomic) KVOObject2 *kvoObject;
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
    self.kvoObject = [KVOObject2 new];
    self.kvoObject.name = @"first name";

    [self.kvoObject hx_addObserver:self key:@"name" callBackBlock:^(id observedObj, NSString *observedKey, id oldVal, id newVal) {
        NSLog(@"Old value: %@, New value: %@", oldVal, newVal);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.label.text = [NSString stringWithFormat:@"%@", self.kvoObject.name];
        }];
    }];

}

- (void)viewWillDisappear:(BOOL)animated {
//    [self.kvoObject hx_removeObserver:self key:@"name"];
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
