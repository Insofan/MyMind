//
//  Item39NetTool.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item39NetTool.h"

@interface Item39NetTool()
@property (nonatomic, copy) NSURL *url;
@end
@implementation Item39NetTool
- (id)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)startWithCompletionHandler:(Item39NetToolCompletion)completionHandler failureHandler:(Item39NetToolError)failure {
    NSError *err = nil;
    int randInt = arc4random() % 2;
    if (randInt == 1) {
        err = [NSError errorWithDomain:@"item 39" code:39 userInfo:nil];
    }
    if (err)  {
        failure(err);
    }else if (completionHandler) {
        NSURL *dataUrl = [[NSURL alloc] initWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535350273861&di=ddbd99faae33cafe0539f7b09c178368&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D56ffb4aeefcd7b89e96c3a8b3f254291%2F663490ef76c6a7ef4ce31c42f4faaf51f2de66b6.jpg"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:dataUrl];
        completionHandler(data);
    }
    
  
}
@end
