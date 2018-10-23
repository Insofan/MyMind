//
//  ForwardingInvocationBackupObj.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ForwardingInvocationBackupObj.h"

@implementation ForwardingInvocationBackupObj
- (void)sendOtherMessage:(NSString *)msg {
    NSLog(@"Other Backup Obj send %@", msg);

}
@end
