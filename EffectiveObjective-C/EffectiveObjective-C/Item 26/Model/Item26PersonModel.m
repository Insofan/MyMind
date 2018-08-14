//
//  Item26PersonModel.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item26PersonModel.h"
@interface Item26PersonModel()
@property (copy, readwrite, nonatomic) NSString *firstName;
@property (copy, readwrite, nonatomic) NSString *lastName;

@end
@implementation Item26PersonModel

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"first %@, last %@", _firstName, _lastName];
}

@end
