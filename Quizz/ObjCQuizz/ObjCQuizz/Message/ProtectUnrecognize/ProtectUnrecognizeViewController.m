//
//  ProtectUnrecognizeViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/25.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ProtectUnrecognizeViewController.h"
#import "UnsafeObject.h"
@interface ProtectUnrecognizeViewController ()
@property(nonatomic, strong) UIButton  *button;
@property(strong, nonatomic) UILabel   *label;
@end

@implementation ProtectUnrecognizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    UnsafeObject *unsafeObj = [UnsafeObject new];
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [unsafeObj unImplementMethod:@"unsafe"];
        [unsafeObj unImplementMethodTwo];
    }];

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
