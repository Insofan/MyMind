//
//  Item52SecTimer.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item52FirTimer+Timer.h"

@implementation NSTimer(Item52)
+ (NSTimer *)ec_scheduledTimerWithTimerInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(hx_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)hx_blockInvoke:(NSTimer *)timer {
    void (^block) (void) = timer.userInfo;
    if (block) {
        block();
    }
}
@end
