//
//  Item50Fetcher.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Item50CompletionHandler) (NSData *data);
typedef void (^Item50Failure) (NSError *err);
@interface Item50Fetcher : NSObject
- (id)initWithURL:(NSURL *)url;
- (void)startWithCompletionHandler:(Item50CompletionHandler)handler failure:(Item50Failure)failure;

@end
