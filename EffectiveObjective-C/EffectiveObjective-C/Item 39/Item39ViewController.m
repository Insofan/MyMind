//
//  Item39ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item39ViewController.h"
#import "Item39NetTool.h"

@interface Item39ViewController ()

@end

@implementation Item39ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    UIImageView *imageView = [UIImageView new];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor hx_randomColor];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);

    }];
    
    NSURL *url = [NSURL URLWithString:@"baidu.com"];
    //随机加载数据或者错误
    Item39NetTool *netTool = [[Item39NetTool alloc] initWithUrl:url];
    [netTool startWithCompletionHandler:^(NSData *data) {
        NSLog(@"sucess data: %@", data);
        if (!data) {
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        [imageView setImage:image];

    } failureHandler:^(NSError *error) {
        NSLog(@"Err: %@", error);
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
