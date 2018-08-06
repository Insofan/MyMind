//
//  EOCError.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/6.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCError : NSObject
+ (void)doWithError:(NSError **)error;
+ (NSString *)provideStringWithError:(NSError **)error;
+ (NSString *)provideNilStringWithError:(NSError **)error;

+ (NSString *)provideNilStringNoErrorWithError:(NSError**)error;
+ ( NSString * _Nullable )provideNullableNilStringNoErrorWithError:(NSError**)error;
+ (BOOL)couldFail:(NSError**)error;

@end
