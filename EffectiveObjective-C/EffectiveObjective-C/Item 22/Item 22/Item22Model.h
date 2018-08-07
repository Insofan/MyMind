//
//  Item22Model.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/7.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item22Model : NSObject
@property (copy, readonly, nonatomic) NSString *firstName;
@property (copy, readonly, nonatomic) NSString *lastName;
@property (strong, readonly, nonatomic)  NSSet *friends;

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

- (void)addFriend:(Item22Model *)person;
- (void)removeFriends:(Item22Model *)person;
- (id)copyWithZone:(NSZone *)zone;

- (id)deepCopy;
@end
