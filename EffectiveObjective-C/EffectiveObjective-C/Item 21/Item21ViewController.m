//
//  Item21ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/6.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item21ViewController.h"
#import "EOCError.h"
@interface Item21ViewController ()

@end

@implementation Item21ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    NSError * __autoreleasing error;
    [EOCError doWithError:&error];
    
    NSString *errStr1 = [EOCError provideStringWithError:&error];
    NSLog(@"first err 1 %@", errStr1);
    NSString *errStr2 = [EOCError provideNilStringWithError:&error];
    NSLog(@"first err 2 %@", errStr2);

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
