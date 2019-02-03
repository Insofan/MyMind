//
//  KVO+Block.h
//  ObjCQuizz
//
//  Created by Insomnia on 2018/11/5.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^HX_ObserverBlock)(id observedObj, NSString * observedKey, id oldVal, id newVal);
NS_ASSUME_NONNULL_BEGIN

@interface NSObject(KVOBlock)

/**
* @Description: 添加block kvo
* @param obj 观察对象
* @param key 观察键
* @param callBackBlock 回调
* @Author: Insomnia
* @Date: 2018/11/5 下午2:35
*/
- (void)hx_addObserver:(NSObject *)obj key:(NSString *)key callBackBlock:(HX_ObserverBlock)callBackBlock;


/**
* @Description: 移除block kvo
* @param obj 观察对象
* @param key 观察键
* @Author: Insomnia
* @Date: 2018/11/5 下午2:38
*/
- (void)hx_removeObserver:(NSObject *)obj key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
