//
//  RuntimeNSObject.h
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/15.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+hx_KVO.h"
@protocol RuntimeNSObjectDelegate<NSObject>
@optional
- (void)firProtocolWith:(NSObject *)obj;
@end
@interface RuntimeNSObject : NSObject <RuntimeNSObjectDelegate, UITableViewDelegate>
@property (nonatomic, strong) NSObject *firObj;
@property (nonatomic, copy) NSString *secStr;
@property (nonatomic, assign) NSInteger thirInt;
@property (nonatomic, strong) NSMutableArray *fouMArr;

- (void)firMethod;
- (NSString *)secMethodWith:(NSObject *)obj;
- (NSInteger)thirMethodWith:(NSString *)str;

@end
