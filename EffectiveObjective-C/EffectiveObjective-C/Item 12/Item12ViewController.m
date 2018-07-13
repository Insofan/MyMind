//
//  Item12ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item12ViewController.h"
#import "EOCAutoDictionary.h"

@interface Item12ViewController ()

@end

@implementation Item12ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EOCAutoDictionary *eocDic = [EOCAutoDictionary new];
    eocDic.string = @"test item 12";
    eocDic.date = [NSDate dateWithTimeIntervalSince1970:475372800];
    
    NSLog(@"string %@", eocDic.string);
    NSLog(@"date %@", eocDic.date);

    self.view.backgroundColor = [UIColor hx_randomColor];
}

@end
