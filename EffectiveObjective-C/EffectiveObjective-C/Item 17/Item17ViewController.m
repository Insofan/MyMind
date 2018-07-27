//
//  Item17ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/18.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item17ViewController.h"
#import "EOCPerson.h"
#import "EOCLocation.h"

@interface Item17ViewController ()

@end

@implementation Item17ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
    // Do any additional setup after loading the view.
    EOCPerson *person = [[EOCPerson alloc] initWithFirstName:@"Bob" lastName:@"Smith"];
    NSLog(@"object %@ ", person);

    EOCLocation *location = [[EOCLocation alloc] initWithTitle:@"Peking" latitude:50.1 longitude:66.6];
    NSLog(@"object %@ ", location);

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
