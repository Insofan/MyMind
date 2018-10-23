//
//  MessageSendUseViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/22.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "MessageSendUseViewController.h"
#import <objc/message.h>

@interface MessageSendUseViewController ()

@end

@implementation MessageSendUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:@[@(0), @(1)]];
    NSLog(@"Before insert %@", arr);
//    [arr insertObject:@(2) atIndex:2];
    ((void(*)(id, SEL, NSNumber *, NSUInteger))objc_msgSend)(arr, @selector(insertObject:atIndex:), @(2), 2);
    NSLog(@"After insert %@", arr);

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
