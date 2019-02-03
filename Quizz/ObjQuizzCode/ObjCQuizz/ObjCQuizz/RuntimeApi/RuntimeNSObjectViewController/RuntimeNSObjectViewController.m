//
//  RuntimeNSObjectViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/15.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "RuntimeNSObjectViewController.h"
#import "RuntimeNSObject.h"
#import <objc/runtime.h>
@interface RuntimeNSObjectViewController ()

@end

@implementation RuntimeNSObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    RuntimeNSObject *obj = [RuntimeNSObject new];
    [self getClassProperty:obj];
    [self getClassMethod:obj];
    [self getClassIval:obj];
    [self getClassProtocol:obj];
}

- (void)getClassProperty:(RuntimeNSObject *)obj{
    NSLog(@"Objcet 获取属性");
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([obj class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        const char *propertyAttr = property_getAttributes(propertyList[i]);
        NSLog(@"%@ : %@", [NSString stringWithUTF8String:propertyName], [NSString stringWithUTF8String:propertyAttr]);
    }
    NSLog(@"");
}

- (void)getClassMethod:(RuntimeNSObject *)obj {
    NSLog(@"Objcet 获取方法");
    unsigned int count;
    Method *methodList = class_copyMethodList([obj class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method: %@", NSStringFromSelector(method_getName(method)));
    }
}

- (void)getClassIval:(RuntimeNSObject *)obj {

    NSLog(@"Objcet 获取成员变量列表");
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([obj class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar : %@", [NSString stringWithUTF8String:ivarName]);
    }
}

- (void)getClassProtocol:(RuntimeNSObject *)obj {
    NSLog(@"Objcet 获取Protocol列表");
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([obj class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol : %@", [NSString stringWithUTF8String:protocolName]);
    }
}

@end
