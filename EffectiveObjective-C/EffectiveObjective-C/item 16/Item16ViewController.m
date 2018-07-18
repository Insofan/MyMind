//
//  Item16ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/18.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item16ViewController.h"
#import "EOCRectangle.h"
#import "EOCSquare.h"
@interface Item16ViewController ()

@end

@implementation Item16ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    EOCRectangle *rect1 = [[EOCRectangle alloc] initWithWidth:10 height:20];
    NSLog(@"rect 1 %f",rect1.width);
    EOCRectangle *rect2 = [EOCRectangle new];
    NSLog(@"rect 2 %f",rect2.width);
    
    EOCSquare *square1 = [[EOCSquare alloc] initWithWidth:10 height:20];
    NSLog(@"square 1 %f",square1.width);
    EOCSquare *square2 = [[EOCSquare alloc] initWithDimension:30];
    NSLog(@"square 2 %f",square2.width);


}

@end
