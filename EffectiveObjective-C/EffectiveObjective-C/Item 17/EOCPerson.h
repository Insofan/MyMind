//
//  EOCPerson.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/18.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCPerson : NSObject
@property (copy, nonatomic, readonly) NSString *firstName;
@property (copy, nonatomic, readonly) NSString *lastName;

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;
@end
