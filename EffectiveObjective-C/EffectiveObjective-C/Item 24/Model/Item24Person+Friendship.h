//
//  Item24Person+Friendship.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item24PersonModel.h"
@interface Item24PersonModel(Friendship)
- (void)addFriend:(Item24PersonModel *)person;
- (void)removeFriends:(Item24PersonModel *)person;
@end
