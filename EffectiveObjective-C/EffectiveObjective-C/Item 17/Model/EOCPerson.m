//
//  EOCPerson.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/18.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "EOCPerson.h"

@implementation EOCPerson
- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    if ((self = [super init])) {
        _firstName = [firstName copy];
        _lastName = [lastName copy];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, \"%@ %@\">", [self class], self, _firstName, _lastName];
}
@end
