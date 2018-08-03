//
//  Item18Model.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/2.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item18Model : NSObject
@property (copy, readonly, nonatomic) NSString *firstName;
@property (copy, readonly, nonatomic) NSString *lastName;
@property (strong, readonly, nonatomic)  NSSet *friends;

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

- (void)addFriend:(Item18Model *)person;
- (void)removeFriends:(Item18Model *)person;

@end
