//
//  Item18Model.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/2.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item18Model.h"

@interface Item18Model()
@property (copy, readwrite, nonatomic) NSString *firstName;
@property (copy, readwrite, nonatomic) NSString *lastName;
@end
@implementation Item18Model {
    NSMutableSet *_internalFriends;
}

- (NSSet *)friends {
    return [_internalFriends copy];
}

- (void)addFriend:(Item18Model *)person {
    [_internalFriends addObject:person];
}

- (void)removeFriends:(Item18Model *)person {
    [_internalFriends removeObject:person];
}

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _internalFriends = [NSMutableSet new];
    }
    return self;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"first %@, last %@, friends %@", _firstName, _lastName, _internalFriends];
}
@end
