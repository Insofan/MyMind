//
//  ForwardingInvocationViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ForwardingInvocationViewController.h"
#import "ForwardingInvocationObj.h"
@interface ForwardingInvocationViewController ()

@end

@implementation ForwardingInvocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    ForwardingInvocationObj *obj = [ForwardingInvocationObj new];
    [obj sendMessage:@"invocation msg"];
    [obj sendOtherMessage:@"other invocation msg"];
}

@end
