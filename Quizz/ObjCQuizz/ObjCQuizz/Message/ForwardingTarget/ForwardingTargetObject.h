//
//  ForwardingTargetObject.h
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForwardingTargetObject : NSObject
- (void)sendMessage:(NSString *)msg;
@end
