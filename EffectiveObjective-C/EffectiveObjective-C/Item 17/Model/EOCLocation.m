//
//  EOCLocation.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "EOCLocation.h"

@implementation EOCLocation

- (id)initWithTitle:(NSString *)title latitude:(float)latitude longitude:(float)longitude {
    self = [super init];
    if (self) {
        _title     = [title copy];
        _latitude  = latitude;
        _longitude = longitude;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>", [self class], self, @{
            @"title": _title,
            @"latitude": @(_latitude),
            @"longitude": @(_longitude)
    }];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p>, %@>", [self class], self, @{
            @"title": _title,
            @"latitude": @(_latitude),
            @"longitude": @(_longitude)
    }];
}
@end
