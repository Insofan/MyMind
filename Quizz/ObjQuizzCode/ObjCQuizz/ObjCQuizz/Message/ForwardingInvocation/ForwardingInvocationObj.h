//
//  ForwardingInvocationObj.h
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForwardingInvocationObj : NSObject
- (void)sendMessage:(NSString *)msg;
- (void)sendOtherMessage:(NSString *)msg;

@end
