//
//  Item24PersonModel.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item24PersonModel : NSObject
@property (copy, readonly, nonatomic) NSString *firstName;
@property (copy, readonly, nonatomic) NSString *lastName;
@property (strong, nonatomic)  NSMutableSet *friends;

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;
@end
