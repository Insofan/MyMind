//
//  Item38ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//
//  定义block, block 做参数
#import "Item38ViewController.h"
#import "Item38SecViewController.h"
#import "Item38Tool.h"

typedef void (^ArgumentBlock) (NSString *str, BOOL flag);
typedef NSString*(^ArugumentBlock2)(NSString *name, int num);
@interface Item38ViewController ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) ArugumentBlock2 blockStr;
@end

@implementation Item38ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self setupButton];
    
    [self argumentBlock:^(NSString *str, BOOL flag) {
        NSLog(@"str: %@ flag: %d", str, flag);
    }];
    
    [self argumentWithReturnBlock];
    
    self.blockStr = ^NSString *(NSString *name, int num) {
        return [NSString stringWithFormat:@"%@, %d", name, num];
    };
    
    NSString *str2 = self.blockStr(@"block 2", 3);
    NSLog(@"str2: %@", str2);
}

- (void)setupButton {
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:testButton];
    testButton.frame = CGRectMake(100, 400, 100, 40);
    [testButton setTitle:@"Test Button" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    self.button = testButton;
    testButton.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickButton{
    Item38SecViewController *vc = [Item38SecViewController new];
    
    @weakify(self);
    vc.someBlock = ^(NSString *inputValue, BOOL flag) {
        NSLog(@"input %@ flag %d", inputValue, flag);
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.button setTitle:inputValue forState:UIControlStateNormal];
        });
    }; 
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)argumentBlock:(ArgumentBlock)argumentBlock{
    if (argumentBlock) {
        argumentBlock(@"some argument", false);
    }
}
- (void)argumentWithReturnBlock{
    NSInteger res = [NSObject item38_tool:^NSString *(NSString *str, BOOL flag) {
        NSLog(@"str: %@ flag: %d", str, flag);
        return [NSString stringWithFormat:@"str: %@ flag: %d", str, flag];
    }];
    
    NSLog(@"res: %tu", res);
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
