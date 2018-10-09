//
// Created by Insomnia on 2018/9/25.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import "NSObject+hx_KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSString * const kHXKvoAssiociateObserver = @"HXAssiociateObserver";
static NSString * const kHXKvoPrefix = @"HXKVO_";
@interface HXObserverInfo : NSObject
@property(weak, nonatomic) NSObject           *observer;
@property(copy, nonatomic) NSString           *keyPath;
@property(weak, nonatomic) id <HXKVODelegate> observerDelegate;
@end


@implementation HXObserverInfo
- (id)initWithObserver:(NSObject *)observer keyPath:(NSString *)keyPath{
    if (self = [super init]) {
        _observer = observer;
        _keyPath = keyPath;
        self.observerDelegate = (id<HXKVODelegate>)observer;
    }
    return self;
}
@end
#pragma mark -- C语言部分, 重写setter, getter Methods
//全局静态变量
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
    NSMutableArray * observers = objc_getAssociatedObject(self, (__bridge const void *)kHXKvoAssiociateObserver);
    for (HXObserverInfo *info in observers) {
        if ([info.keyPath isEqualToString:getterName]) {
            dispatch_async(dispatch_queue_create(DISPATCH_TARGET_QUEUE_DEFAULT, NULL), ^{
                if ([info.observerDelegate respondsToSelector:@selector(hx_observeValueForObject:keyPath:oldValue:newValue:)]) {
                    [info.observerDelegate hx_observeValueForObject:self keyPath:getterName oldValue:oldValue newValue:newValue];
                }
            });
        }
    }
}

static Class kvo_Class(id self) {
    return class_getSuperclass(object_getClass(self));
}


#pragma mark
@implementation NSObject (HXKVO)

- (void)hx_addObserverForObject:(id)object keyPath:(NSString *)keyPath {
    // 1. 检查对象的类有没有相应的 setter 方法。如果没有抛出异常
    SEL setterSelector = NSSelectorFromString(setterStrForGetter(keyPath));
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if (!setterMethod) {
        NSLog(@"Unrecognized selector sent to instance %@", self);
        return;
    }
    
    // 2. 检查对象 isa 指向的类是不是一个 KVO 类。如果不是，新建一个继承原来类的子类，并把 isa 指向这个新建的子类
    Class observerCls = object_getClass(self);
    NSString *clsName = NSStringFromClass(observerCls);
    
    if (![clsName hasPrefix:kHXKvoPrefix]) {
        observerCls = [self createKVOClassWithOriginClassName:clsName];
        object_setClass(self, observerCls);
    }
    
    // 3. 为kvo class添加setter方法的实现, 可以写成判断后是否添加
    const char *types = method_getTypeEncoding(setterMethod);
    class_addMethod(observerCls, setterSelector, (IMP)kvo_setter, types);
    
    // 4. 添加该观察者到观察者列表中
    // 4.1 创建观察者的信息
    HXObserverInfo *info = [[HXObserverInfo alloc] initWithObserver:object keyPath:keyPath];
    
    // 4.2 获取关联对象(装着所有监听者的数组)
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge void *)kHXKvoAssiociateObserver);
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge void *)kHXKvoAssiociateObserver, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}

- (void)hx_removeObserverForObject:(id)object keyPath:(NSString *)keyPath {
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge void *)kHXKvoAssiociateObserver);
    
    HXObserverInfo *removeInfo = nil;
    for (HXObserverInfo *info in observers) {
        if (info.observer == observers && [info.keyPath isEqualToString:keyPath]){
            removeInfo = info;
            break;
        }
    }
    [observers removeObject:removeInfo];
}


- (Class)createKVOClassWithOriginClassName:(NSString *)className {
    NSString *kvoClassName = [kHXKvoPrefix stringByAppendingString:className];
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
