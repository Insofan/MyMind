//
//  MsgResolveViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "MsgResolveViewController.h"
#import "MsgResolveObject.h"
@interface MsgResolveViewController ()

@end

@implementation MsgResolveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     * 三次拯救的机会
     */
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    MsgResolveObject *msgObj = [MsgResolveObject new];
    [msgObj sendMessage:@"msg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
