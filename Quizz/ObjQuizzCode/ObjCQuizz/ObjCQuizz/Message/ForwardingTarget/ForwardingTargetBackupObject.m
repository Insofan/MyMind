//
//  ForwardingTargetBackupObject.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/23.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ForwardingTargetBackupObject.h"

@implementation ForwardingTargetBackupObject
- (void)sendMessage:(NSString *)msg {
    NSLog(@"Backup Obj send %@", msg);
}
@end
