//
//  Item26PersonModel.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item26PersonModel : NSObject
@property (copy, readonly, nonatomic) NSString *firstName;
@property (copy, readonly, nonatomic) NSString *lastName;

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end
