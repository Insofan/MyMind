//
//  MsgResolveObject.h
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgResolveObject : NSObject
//没写实现, 程序会crash : unrecognized selector sent to instance
- (void)sendMessage:(NSString *)msg;
@end
