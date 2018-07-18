//
// Created by Insomnia on 2018/7/18.
// Copyright (c) 2018 Insomnia. All rights reserved.
//

#import "EOCSquare.h"


@implementation EOCSquare


- (id)initWithDimension:(float)dimension {
    return [super initWithWidth:dimension height:dimension];
}

- (id)initWithWidth:(float)width height:(float)height {
    float dimension = MAX(width, height);
    return [self initWithDimension:dimension];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super initWithCoder:decoder])) {
        
    }
    return self;
}



@end