//
// Created by Insomnia on 2018/7/18.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import "EOCRectangle.h"


@implementation EOCRectangle


- (id)init {
    return [self initWithWidth:5.0f height:5.0f];
}

- (id)initWithWidth:(float)width height:(float)height {
    if (self = [super init]) {
        _width  = width;
        _height = height;
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        _width  = [decoder decodeFloatForKey:@"width"];
        _height = [decoder decodeFloatForKey:@"height"];
    }
    return self;
}

@end