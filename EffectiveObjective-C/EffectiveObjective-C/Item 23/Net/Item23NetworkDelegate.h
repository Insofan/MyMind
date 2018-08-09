//
//  Item23NetworkDelegate.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/9.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item23Network;
//#warning 在@protocol里面，默认是@require，就是必须实现的协议，而@optional是可选实现的，如果不写@require和@optional，那就是@require

@protocol Item23NetworkDelegate <NSObject>
@required

@optional

- (void)networkFetcher:(Item23Network *)fetcher didReceiveData:(NSData *)data;

- (void)networkFetcher:(Item23Network *)fetcher didFailWithError:(NSError *)error;

- (void)networkFetcher:(Item23Network *)fetcher didUpdateProgressTo:(float)progress;


@end
