//
//  EOCLocation.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCLocation : NSObject
@property(copy, nonatomic, readonly) NSString *title;
@property(assign, nonatomic, readonly) float latitude;
@property(assign, nonatomic, readonly) float longitude ;

- (id)initWithTitle:(NSString *)title latitude:(float)latitude longitude:(float)longitude;
@end
