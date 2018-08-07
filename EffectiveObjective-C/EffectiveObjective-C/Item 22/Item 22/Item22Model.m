//
//  Item22Model.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/7.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item22Model.h"
@interface Item22Model()
@property (copy, readwrite, nonatomic) NSString *firstName;
@property (copy, readwrite, nonatomic) NSString *lastName;
@end
@implementation Item22Model {
    NSMutableSet *_internalFriends;
}

- (NSSet *)friends {
    return [_internalFriends copy];
}

- (void)addFriend:(Item22Model *)person {
    [_internalFriends addObject:person];
}

- (void)removeFriends:(Item22Model *)person {
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

- (id)copyWithZone:(NSZone *)zone {
    Item22Model *copy = [[[self class] allocWithZone:zone] initWithFirstName:_firstName lastName:_lastName];
    copy->_internalFriends = [_internalFriends mutableCopy];
    return copy;
}

- (id)deepCopy {
    Item22Model *copy = [[[self class] alloc] initWithFirstName:_firstName lastName:_lastName];
    copy->_internalFriends = [[NSMutableSet alloc] initWithSet:_internalFriends copyItems:true];
    return copy;
}


@end
