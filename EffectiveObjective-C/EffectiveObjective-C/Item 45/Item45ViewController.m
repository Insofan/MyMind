//
//  Item45ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/3.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item45ViewController.h"
#import "Item45SingletonModel.h"
@interface Item45ViewController ()

@end

@implementation Item45ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Item45SingletonModel *model = [Item45SingletonModel sharedInstance];
    Item45SingletonModel *model2 = [Item45SingletonModel sharedInstance];

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
