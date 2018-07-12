//
//  Item11ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/12.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item11ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Person.h"
@interface Item11ViewController ()

@end

@implementation Item11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self msgSendTest];
}

- (void)msgSendTest {
    objc_msgSend(self, @selector(testMsgSend));
    
    // 1、创建对象
    // 给'MessageSendTest'类发送消息，创建对象，这句话等同于 MessageSendTest *test = [MessageSendTest alloc];
    Person *per = ((Person * (*)(id,SEL)) objc_msgSend)((id)[Person class], @selector(alloc));
    
    //初始化
    per = ((Person *(*)(id, SEL)) objc_msgSend)(per, @selector(init));
    
    // 带一个参数 无返回值

    NSString * str = ((NSString * (*) (id, SEL, NSString *, NSInteger)) objc_msgSend)(per, @selector(sayHello:age:), @"Insomnia", 18);
    NSLog(@"return str %@", str);

}


- (void)testMsgSend {
    NSLog(@"hello");
}

@end
