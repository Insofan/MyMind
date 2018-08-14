//
//  Item26ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item26ViewController.h"
#import "Item26PersonModel.h"
#import "Item26Person+Friendship.h"
@interface Item26ViewController ()

@end

@implementation Item26ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    
     Item26PersonModel *person = [[Item26PersonModel alloc] initWithFirstName:@"First name" lastName:@"Last name"];
    Item26PersonModel *friend = [[Item26PersonModel alloc] initWithFirstName:@"Friend name" lastName:@"Friend name"];
    person.friends = @"wtf";
    NSLog(@"friend %@", person.friends);
    
    
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
