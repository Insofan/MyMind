//
//  Item50Fetcher.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item50Fetcher.h"
@interface Item50Fetcher()
@property (nonatomic, strong) NSURL *url;
@end
@implementation Item50Fetcher

- (id)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
//        _cache = [NSCache new];
//        // 5m
//        _cache.totalCostLimit = 5 * 1024 *1024;
        _url = url;
    }
    return self;
}

- (void)startWithCompletionHandler:(Item50CompletionHandler)handler failure:(Item50Failure)failure {
    NSError *err = nil;
    if (err)  {
        failure(err);
    }else if (handler) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:_url];
        handler(data);
    }
    
}
@end
