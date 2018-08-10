//
//  Item24ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item24ViewController.h"
#import "Item24PersonModel.h"
#import "Item24Person+Friendship.h"
#import "Item24Person+Play.h"
@interface Item24ViewController ()

@end

@implementation Item24ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    //主要用来添加方法, 添加属性要用runtime 添加
    Item24PersonModel *person = [[Item24PersonModel alloc] initWithFirstName:@"First name" lastName:@"Last name"];
    Item24PersonModel *friend = [[Item24PersonModel alloc] initWithFirstName:@"Friend name" lastName:@"Friend name"];
    [person goToTheCinema];
    [person addFriend:friend];
    [person goToTheCinema];
    [person removeFriends:friend];
    [person goToSportsGame];
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
