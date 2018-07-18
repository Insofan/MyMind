//
// Created by Insomnia on 2018/7/18.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EOCRectangle : NSObject <NSCoding>
@property(assign, nonatomic, readonly) float width;
@property(assign, nonatomic, readonly) float height;

- (id)init;
- (id)initWithWidth:(float)width height:(float)height;
@end