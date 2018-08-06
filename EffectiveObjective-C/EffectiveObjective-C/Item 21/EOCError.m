//
//  EOCError.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/6.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "EOCError.h"

@implementation EOCError
+ (void)doWithError:(NSError *__autoreleasing *)error {
    if (error) {
        *error = [NSError errorWithDomain:@"Make An Error" code:0 userInfo:nil];
    }
}

+ (NSString *)provideStringWithError:(NSError *__autoreleasing *)error {
    if (error) {
        *error = [NSError errorWithDomain:@"Make An Error" code:0 userInfo:nil];
    }
    return @"";
}

+ (NSString *)provideNilStringWithError:(NSError *__autoreleasing *)error {
    if (error) {
        *error = [NSError errorWithDomain:@"Make An error" code:0 userInfo:nil];
    }
    return nil;
}
@end
