//
//  Item48ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/4.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item48ViewController.h"

@interface Item48ViewController ()

@end

@implementation Item48ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    NSArray *arr = @[@1, @3, @5, @7, @9];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Arr: index %tu obj %@", idx, obj);
    }];
    
     NSDictionary *dic = @{@"name":@"Inso",@"age":@23,@"gender":@"woman"};
    [dic enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"Dic: key %@ obj %@", key, obj);

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
