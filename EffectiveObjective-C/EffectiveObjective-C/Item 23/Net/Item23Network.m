//
//  Item23Network.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/9.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item23Network.h"

typedef NS_ENUM(NSUInteger, networkErrorType) {
    networkErrorkLoss       = 400,
    networkErrorInterrupt   = 403,
    networkErrorRequestFail = 404,
};

NSString *const Item23ErrorDomain = @"ErrorDomain";

@interface Item23Network () {
    //缓存delegate 缓存状态
    struct {
        unsigned int didReceiveData :1;
        unsigned int didFailWithError :1;
        unsigned int didUpdateProgressTo :1;
    } _delegateFlags;
    
    struct {
        unsigned int fieldA :8;
        unsigned int fieldB :4;
        unsigned int fieldC :2;
        unsigned int fieldD :1;
    }_data;
//#warning 在_data`结构体中，fieldA位段将占用8个二进制位，fieldB占用4个，fieldC占用2个，fieldD占用1个。于是，fieldA可以表示0至255之间的值，而fieldD可以表示0或1这两个值
//    2^8 = 256 ~> 0-255
//    2^4 = 16  ~> 0-15
//    2^2 = 4   ~> 0-3
//    2^1 = 2   ~> 0-1
}

@end

@implementation Item23Network


- (void)sendSuccess {
    if (_delegateFlags.didReceiveData) {
        NSString *string = [NSString stringWithFormat:@"%@", [self class]];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        [_delegate networkFetcher:self didReceiveData:data];
    }
}

- (void)sendFail {
    if (_delegateFlags.didFailWithError) {
        NSError *error = [NSError errorWithDomain:Item23ErrorDomain code:networkErrorRequestFail userInfo:nil];
        [_delegate networkFetcher:self didFailWithError:error];
    }
}

-(void)sendProgress {
    if (_delegateFlags.didUpdateProgressTo) {
        [_delegate networkFetcher:self didUpdateProgressTo:0.9];
    }
}

- (void)setDelegate:(id <Item23NetworkDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.didReceiveData      = [delegate respondsToSelector:@selector(networkFetcher:didReceiveData:)];
    _delegateFlags.didFailWithError    = [delegate respondsToSelector:@selector(networkFetcher:didFailWithError:)];
    _delegateFlags.didUpdateProgressTo = [delegate respondsToSelector:@selector(networkFetcher:didUpdateProgressTo:)];
}

@end
