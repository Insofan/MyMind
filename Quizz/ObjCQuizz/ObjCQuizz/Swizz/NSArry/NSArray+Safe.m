//
//  NSArray+Safe.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/11/5.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL    selA    = @selector(objectAtIndex:);
        SEL    selB    = @selector(hx_objectAtIndex:);
        //当NSArray只有一个元素时其class为__NSSingleObjectArrayI，当一个元素都没有的时候其class为__NSArray0，其他情况的class才是__NSArrayI。
        //也就是说当NSArray只有一个元素或者一个元素都没有的时候 这个方法无效, 但这只是一个demo 需要后续完善
        Method methodA = class_getInstanceMethod(objc_getClass("__NSArrayI"), selA);
        Method methodB = class_getInstanceMethod(objc_getClass("__NSArrayI"), selB);
        //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        //添加成功了 说明 本类中不存在methodB 所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        } else {
            //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

/**
* @Description:
* @param index
* @return id
* @Author: Insomnia
* @Date: 2018/11/5 上午10:58
*/
- (id)hx_objectAtIndex:(NSUInteger)index {
    if (self.count - 1 < index) {
        @try {
            return [self hx_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"<<<<<<-------%s : 方法%s 数组越界崩溃  ------->>>>>>", class_getName(self.class),  __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self hx_objectAtIndex:index];
    }
}

@end
