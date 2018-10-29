//
// Created by Insomnia on 2018/10/29.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import "TestYYModelDescription.h"


@implementation TestYYModelDescription
- (NSString *)description {
    return [self yy_modelDescription];
}

- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
@end