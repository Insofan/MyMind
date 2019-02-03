//
//  OCQBaseViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/9/25.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "OCQBaseViewController.h"

@interface OCQBaseViewController ()
@property(nonatomic, strong) UIButton  *button;
@property(strong, nonatomic) UILabel   *label;
@end

@implementation OCQBaseViewController

- (void)setupUI {

    self.button = ({
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_button];
        _button.backgroundColor = [UIColor hx_randomColor];
        [_button setTitle:@"Change Value" forState:UIControlStateNormal];
        _button;
    });

    self.label = ({
        _label = [UILabel new];
        [self.view addSubview:_label];
//        _label.text = [stockKVO valueForKey:@"price"];
        _label.textColor       = [UIColor blackColor];
        _label.backgroundColor = [UIColor hx_randomColor];
        _label;
    });

    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 80));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];

    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 80));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(100);
    }];

    [self buttonLogic];
}


- (void)buttonLogic {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self setupUI];

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
