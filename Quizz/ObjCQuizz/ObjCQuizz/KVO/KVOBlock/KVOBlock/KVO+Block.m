//
//  KVO+Block.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/11/5.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "KVO+Block.h"
#import <objc/message.h>
#import <objc/runtime.h>
static NSString * const kKvoClassPrefixForBlock = @"HXObserver_";
static NSString * const kKvoAssociateObserverForBlock = @"HXAssociateObserver";

/**
 *  根据getter方法名返回setter方法名
 */
static NSString * setterStrForGetter(NSString *getter) {
    // name -> Name -> setName:
    if (getter.length <= 0) {
        return nil;
    }
    // 1. 首字母转换成大写
    NSString *firStr = [[getter substringToIndex:1] uppercaseString];
    NSString *secStr = [getter substringFromIndex:1];

    // 2. 最前增加set, 最后增加:
    return [NSString stringWithFormat:@"set%@%@:", firStr, secStr];
}

/**
 *  根据setter方法名返回getter方法名
 */
static NSString *getterStrForSetter(NSString *setter) {
    // setName: -> Name -> name
    if (setter.length <= 0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    // 1. 去掉set
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString * getter = [setter substringWithRange: range];
    // 2. 首字母转换成大写
    NSString * firstString = [[getter substringToIndex: 1] lowercaseString];
    getter = [getter stringByReplacingCharactersInRange: NSMakeRange(0, 1) withString: firstString];
    return getter;
}
@implementation NSObject(KVOBlock)

- (void)hx_addObserver:(NSObject *)obj key:(NSString *)key callBackBlock:(HX_ObserverBlock)callBackBlock {
    //获取 setter method
    SEL setter = NSSelectorFromString(setterStrForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class], setter);

    if (!setterMethod) {
        @throw [NSException exceptionWithName: NSInvalidArgumentException reason: [NSString stringWithFormat: @"unrecognized selector sent to instance %@", self] userInfo: nil];
        return;
    }
    //自己的类作为被观察者类
    Class observedClass = object_getClass(self);
    NSString *className = NSStringFromClass(observedClass);
    if (![className hasPrefix:kKvoClassPrefixForBlock]) {
        observedClass = [self createKVOClassWithOriginClassName:className];
        //被观察的类如果是被观察对象本来的类，那么，就要专门依据本来的类新建一个新的子类，区分是否这个子类的标记是带有HXObserver_的前缀
        object_setClass(self, observedClass);
    }
}


- (Class)createKVOClassWithOriginClassName:(NSString *)className {
    NSString *kvoClassName = [kKvoClassPrefixForBlock stringByAppendingString:className];
    Class observedClass = NSClassFromString(kvoClassName);
    if (observedClass) {
        return observedClass;
    }

    // 如果kvo class不存在, 则创建这个类
    Class originClass = object_getClass(self);
    observedClass = objc_allocateClassPair(originClass, kvoClassName.UTF8String, 0);

    // 修改kvo class方法的实现
    Method clsMethod = class_getInstanceMethod(originClass, @selector(class));
    //这里是char * _Nullable method_types
    const char * types = method_getTypeEncoding(clsMethod);
    class_addMethod(observedClass, @selector(class), (IMP)kvo_Class, types);
    objc_registerClassPair(observedClass);
    return observedClass;
}

@end
