//
//  Item24Person+Friendship.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item24Person+Friendship.h"

@implementation Item24PersonModel(Friendship)
- (void)addFriend:(Item24PersonModel *)person {
    [self.friends addObject:person];
}

- (void)removeFriends:(Item24PersonModel *)person {
    [self.friends removeObject:person];
}
@end
