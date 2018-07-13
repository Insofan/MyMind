//
//  EOCAutoDictionary.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

@interface EOCAutoDictionary()
@property (nonatomic, strong) NSMutableDictionary *backingStore;
@end

void autoDictionarySetter(id self, SEL _cmd, id value) {
    /**
     Get the backing store from the class
     */
    EOCAutoDictionary *typeSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typeSelf.backingStore;
    
    /**
     The selector will be for example, "setSomeThing",we need remove the "set", ":' and lowercase the first letter of remainder
     需要移除set和:, 小写属性第一个字符
     */
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    /**
     remove set
     */
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    /*
     remove :
     */
    
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    
    /**
     小写属性第一个字母
     */
//    NSString *lowercaseFirstChar = [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    if (value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
    
}

id autoDictionaryGetter(id self, SEL _cmd) {
    EOCAutoDictionary *typeSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typeSelf.backingStore;
    //The key is simply the selector name
    NSString *key = NSStringFromSelector(_cmd);
    return [backingStore objectForKey:key];
}

@implementation EOCAutoDictionary
@dynamic string, number;
- (instancetype)init {
    if ((self = [super init])) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)selector {
    NSString *selectorStr = NSStringFromSelector(selector);
    if ([selectorStr hasPrefix:@"set"]) {
        class_addMethod(self, selector, (IMP)autoDictionarySetter, "v@:@");
    } else {
        class_addMethod(self, selector, (IMP)autoDictionaryGetter, "@@:");
    }
    return true;
}



@end

