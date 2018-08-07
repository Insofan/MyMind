//
//  Item22ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/7.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item22ViewController.h"
#import "Item22Model.h"

@interface Item22ViewController ()

@end

@implementation Item22ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    Item22Model *model = [[Item22Model alloc] initWithFirstName:@"First name 1" lastName:@"Last name 1"];
    Item22Model *model2 = [model copyWithZone:nil];
    
    Item22Model *model3 = [model2 copyWithZone:nil];
    Item22Model *model4 = [model deepCopy];
    Item22Model *model5 = [model4 deepCopy];
    NSLog(@"model2 %@", model2.firstName);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Item 22: Understand the NSCopying Protocol"];
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
