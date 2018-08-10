//
//  Item24PersonModel.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item24PersonModel.h"
@interface Item24PersonModel()
//@property (copy, readonly, nonatomic) NSString *firstName;
//@property (copy, readonly, nonatomic) NSString *lastName;
//@property (strong, readonly, nonatomic)  NSSet *friends;
@property (copy, readwrite, nonatomic) NSString *firstName;
@property (copy, readwrite, nonatomic) NSString *lastName;
//@property (strong, readwrite, nonatomic) NSMutableSet *internalFriends;
@end
@implementation Item24PersonModel

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _friends = [NSMutableSet new];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"first %@, last %@, friends %@", _firstName, _lastName, _friends];
}

@end
