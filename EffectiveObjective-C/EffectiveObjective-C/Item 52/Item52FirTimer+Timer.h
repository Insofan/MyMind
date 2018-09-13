//
//  Item52SecTimer.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/9/11.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer(Item52)
+ (NSTimer *)ec_scheduledTimerWithTimerInterval:(NSTimeInterval)interval block:(void(^)(void))block repeats:(BOOL)repeats;
@end
