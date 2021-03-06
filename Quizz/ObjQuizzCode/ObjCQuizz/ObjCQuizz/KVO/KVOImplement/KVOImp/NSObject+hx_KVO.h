//
// Created by Insomnia on 2018/9/25.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HXKVODelegate <NSObject>
@optional
/**
 * KVO delegate
 * @param object Observe object
 * @param keyPath  property name
 * @param oldValue  oldValue
 * @param newValue newValue
 */
- (void)hx_observeValueForObject:(id)object keyPath:(NSString *)keyPath oldValue:(id)oldValue newValue:(id)newValue;
@end


@interface NSObject (HXKVO) <HXKVODelegate>
/**
 * Add observe
 * @param object Observe object
 * @param keyPath Property name
 */
- (void)hx_addObserverForObject:(id)object keyPath:(NSString *)keyPath;

/**
 * Remove observe
 * @param object Observe object
 * @param keyPath Property name
 */
- (void)hx_removeObserverForObject:(id)object keyPath:(NSString *)keyPath;
@end
