//
//  Item30ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/16.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item30ViewController.h"
#import "Item30Model.h"

@interface Item30ViewController ()

@end

@implementation Item30ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    //不要以alloc new copy mutableCopy 开头命名方法
    [self doSomething];
}

- (void)doSomething {
    //这里 因为使用 new copy alloc mutableCopy 开头, 所以personOne需要比personTwo多release一次
    Item30Model *personOne = [Item30Model newPerson];
    
    Item30Model *personTwo = [Item30Model somePerson];
    
   
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
