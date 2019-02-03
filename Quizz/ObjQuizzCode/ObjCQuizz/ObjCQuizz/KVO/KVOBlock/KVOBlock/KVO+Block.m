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
static NSString * const kKvoClassPrefixForBlock = @"HXBlockPrefix_";
static NSString * const kKvoAssociateObserverForBlock = @"HXBlockAssociateObserver";

@interface HXObserverBlockInfo : NSObject
@property(weak, nonatomic) NSObject           *observer;
@property(copy, nonatomic) NSString           *keyPath;
@property(copy, nonatomic) HX_ObserverBlock handler;
@end

@implementation HXObserverBlockInfo
- (id)initWithObserver:(NSObject *)observer keyPath:(NSString *)keyPath handler:(HX_ObserverBlock)handler{
    if (self = [super init]) {
        _observer = observer;
        _keyPath = keyPath;
        self.handler = handler;
    }
    return self;
}
@end

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

/**
 *  重写setter方法, 新方法在调用原方法后, 通知每个观察者(调用传入的block)
 */
static void kvo_setter(id self, SEL _cmd, id newValue) {
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterStrForSetter(setterName);
    if (!getterName) {
        NSLog(@"Cann't find getter name");
        return;
    }

    id oldValue = [self valueForKey:getterName];
    //获取父类
    struct objc_super superClass = {
            .receiver = self,
            .super_class = class_getSuperclass(object_getClass(self))
    };

    [self willChangeValueForKey:getterName];
    ((void (*)(void *, SEL, id))objc_msgSendSuper)(&superClass, _cmd, newValue);
    [self didChangeValueForKey:getterName];

    //获取所有监听回调对象进行回调
    NSMutableArray * observers = objc_getAssociatedObject(self, (__bridge const void *)kKvoAssociateObserverForBlock);
    for (HXObserverBlockInfo *info in observers) {
        if ([info.keyPath isEqualToString:getterName]) {
            dispatch_async(dispatch_queue_create(DISPATCH_TARGET_QUEUE_DEFAULT, 0), ^{
                info.handler(self, getterName, oldValue, newValue);
            });
        }
    }
}

//获取super class
static Class kvo_Class(id self) {
    return class_getSuperclass(object_getClass(self));
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

    // 3. 为kvo class添加setter方法的实现, 可以写成判断后是否添加
    const char *types = method_getTypeEncoding(setterMethod);
    class_addMethod(observedClass, setter, (IMP)kvo_setter, types);

    // 4. 添加该观察者到观察者列表中
    // 4.1 创建观察者的信息
    HXObserverBlockInfo *info = [[HXObserverBlockInfo alloc] initWithObserver:obj keyPath:key handler:callBackBlock];

    // 4.2 获取关联对象(装着所有监听者的数组)
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge void *)kKvoAssociateObserverForBlock);
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge void *)kKvoAssociateObserverForBlock, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}

- (void)hx_removeObserverForObject:(id)object keyPath:(NSString *)keyPath {
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge void *)kKvoAssociateObserverForBlock);

    HXObserverBlockInfo *removeInfo = nil;
    for (HXObserverBlockInfo *info in observers) {
        if (info.observer == observers && [info.keyPath isEqualToString:keyPath]){
            removeInfo = info;
            break;
        }
    }
    [observers removeObject:removeInfo];
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
