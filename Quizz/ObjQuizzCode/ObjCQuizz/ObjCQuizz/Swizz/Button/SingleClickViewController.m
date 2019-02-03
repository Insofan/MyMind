//
//  SingleClickViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/11/1.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "SingleClickViewController.h"
#import "UIButton+SingleClick.h"
@interface SingleClickViewController ()
@property(nonatomic, strong) UIButton  *button;
@property(strong, nonatomic) UILabel   *label;
@end

@implementation SingleClickViewController

- (void)buttonLogic {
//    @weakify(self);
//    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
//        @strongify(self);
//        NSLog(@"Click");
//    }];
    self.label.text = @"第一次点击";
    self.button.acceptEventInterval = 2;
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if ([self.label.text isEqualToString:@"第一次点击"]) {
            self.label.text = @"第二次点击";
        } else {
            self.label.text = @"第一次点击";
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

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
