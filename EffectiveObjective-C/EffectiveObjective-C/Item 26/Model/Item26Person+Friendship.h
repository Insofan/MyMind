//
//  Item26Person+Friendship.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item26PersonModel.h"
@interface Item26PersonModel(Item26PersonFriedship)
@property (nonatomic, strong) NSString *friends;
//- (void)addFriend:(Item26PersonModel *)person;
//- (void)removeFriends:(Item26PersonModel *)person;

- (BOOL)isFriendsWith:(Item26PersonModel *)person;
@end
