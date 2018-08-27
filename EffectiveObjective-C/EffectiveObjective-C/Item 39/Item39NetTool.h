//
//  Item39NetTool.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Item39NetToolHeader.h"
typedef void (^Item39NetToolCompletion)(NSData *data);
typedef void (^Item39NetToolError)(NSError *error);
@interface Item39NetTool : NSObject
- (id)initWithUrl:(NSURL *)url;
- (void)startWithCompletionHandler:(Item39NetToolCompletion)completionHandler failureHandler:(Item39NetToolError)failure;
@end
