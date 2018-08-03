//
//  Item18ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/2.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item18ViewController.h"
#import "Item18Model.h"

@interface Item18ViewController ()

@end

@implementation Item18ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
    // Do any additional setup after loading the view.
    
    Item18Model *person = [[Item18Model alloc] initWithFirstName:@"WTF" lastName:@"Stupid"];
    Item18Model *friend1 = [[Item18Model alloc] initWithFirstName:@"Friend" lastName:@"First"];
    Item18Model *friend2 = [[Item18Model alloc] initWithFirstName:@"Friend" lastName:@"Second"];

    [person addFriend:friend1];
    [person addFriend:friend2];
    NSSet *friends = person.friends;
    NSLog(@"Nslog print person first %@, last %@, friends %@", person.firstName, person.lastName, friends);
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
