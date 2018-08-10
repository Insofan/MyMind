//
//  Item24Person+Play.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item24Person+Play.h"
@implementation Item24PersonModel(Play)
- (void)goToTheCinema {
    NSLog(@"%@ %@ %@ go to the Cinema", self.firstName, self.lastName, self.friends);
}

- (void)goToSportsGame {
    NSLog(@"%@ %@ %@ go to Sports", self.firstName, self.lastName, self.friends);

}
@end
