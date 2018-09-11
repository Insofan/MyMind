//
//  Item50Object.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item50Object.h"
#import "Item50Fetcher.h"
static NSInteger const kMaxConst =  5 * 1024 *1024;
@interface Item50Object()
@property (nonatomic, strong) NSCache *cache;
@end
@implementation Item50Object
- (id)init {
    self = [super init];
    if (self) {
        [self cache];
    }
    return self;
}

- (NSCache *)cache {
    if (!_cache) {
        _cache = [NSCache new];
        //最大有一百个key
        _cache.countLimit = 100;
        //最大 5m 注意下面的 [self.cache setObject:data forKey:url cost:kMaxConst]; 方法
        _cache.totalCostLimit = kMaxConst;
    }
    return _cache;
}
- (void)downloadDataForURL:(NSURL *)url{
    NSData *cachedData = [self.cache objectForKey:url];
    if (cachedData) {
        NSLog(@"Data has been downloaded in cache");
    } else {
        Item50Fetcher *fetcher = [[Item50Fetcher alloc] initWithURL:url];
        [fetcher startWithCompletionHandler:^(NSData *data) {
            //必须这样设置  limit 才有效
            
            [self.cache setObject:data forKey:url cost:kMaxConst];
            NSLog(@"Not in cache download bingo");
            NSData *tempData = [self.cache objectForKey:url];
            if (tempData) {
                NSLog(@"Data downloaded into cache");
            }
        } failure:^(NSError *err) {
            NSLog(@"Not in cache download failure");
        }];
    }
}

@end
