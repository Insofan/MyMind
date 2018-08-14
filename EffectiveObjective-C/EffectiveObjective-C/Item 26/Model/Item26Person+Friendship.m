//
//  Item26Person+Friendship.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item26Person+Friendship.h"
#import <objc/runtime.h>
//直接添加property 会出: Property 'friends' requires method 'friends' to be defined - use @dynamic or provide a method implementation in this category, 需要自己用runtime合成 get set

static const char *kFriendsPropertyKey = "kFriendsPropertyKey";
@implementation Item26PersonModel(Item26PersonFriedship)

- (NSString *)friends {
    return objc_getAssociatedObject(self, kFriendsPropertyKey);
}

- (void)setFriends:(NSString *)friends {
    objc_setAssociatedObject(self, kFriendsPropertyKey, friends, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//- (void)addFriend:(Item26PersonModel *)person {
//    [self.friends addObject:person];
//}
//
//- (void)removeFriends:(Item26PersonModel *)person {
//    [self.friends removeObject:person];
//}


- (BOOL)isFriendsWith:(Item26PersonModel *)person {
    return true;
}
@end
