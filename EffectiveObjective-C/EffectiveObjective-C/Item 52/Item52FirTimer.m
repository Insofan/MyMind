//
//  Item52FirTimer.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item52FirTimer.h"
#import "Item52FirTimer+Timer.h"
@implementation Item52FirTimer {
    NSTimer *_pollTimer;
}

- (id)init {
    return [super init];
}

- (void)dealloc {
    [_pollTimer invalidate];
}

- (void)stopPolling {
    [_pollTimer invalidate];
    _pollTimer = nil;
}

- (void)startPolling {
    _pollTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(p_doPoll) userInfo:nil repeats:true];
}

- (void)hx_startPolling {
//    @weakify(self);
//    __weak Item52FirTimer *weakSelf = self;
    _pollTimer = [NSTimer ec_scheduledTimerWithTimerInterval:3.0 block:^{
        /*
         以下写法都会错误释放, 导致不执行
        @strongify(self);
        Item52FirTimer *strongSelf = weakSelf;
        [strongSelf p_doPoll];
        */
        [self p_doPoll];
    } repeats:true];
}

- (void)p_doPoll {
    NSLog(@"Polling.........");
}
@end
