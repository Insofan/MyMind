//
//  MIT License
//
//  Copyright (c) 2014 Bob McCune http://bobmccune.com/
//  Copyright (c) 2014 TapHarmonic, LLC http://tapharmonic.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "THTrackMetadataConverter.h"
#import "THMetadataKeys.h"

@implementation THTrackMetadataConverter

- (id)displayValueFromMetadataItem:(AVMetadataItem *)item {
    
    // Listing 3.13
    NSNumber *number = nil;
    NSNumber *counnt = nil;

    if ([item.value isKindOfClass:[NSString class]]) {
        NSArray *components = [item.stringValue componentsSeparatedByString:@"/"];
        number = @([components[0] integerValue]);
        counnt = @([components[1] integerValue]);
    } else if ([item.value isKindOfClass:[NSDictionary class]]) {
        NSData *data = item.dataValue;
        if (data.length == 8) {
            uint16_t *values = (uint16_t *)[data bytes];
            if (values[1] > 0) {
                number = @(CFSwapInt16BigToHost(values[1]));
            }
            if (values[2] > 0) {
                counnt = @(CFSwapInt16BigToHost(values[2]));
            }
        }
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:number ?: [NSNull null] forKey:THMetadataKeyTrackNumber];
    [dict setObject:counnt ?: [NSNull null] forKey:THMetadataKeyTrackCount];
    return dict;
}

- (AVMetadataItem *)metadataItemFromDisplayValue:(id)value
                                withMetadataItem:(AVMetadataItem *)item {
    
    // Listing 3.13
    AVMutableMetadataItem *metadataItem = [item mutableCopy];
    NSDictionary* discData = (NSDictionary *)value;
    NSNumber *discNumber = discData[THMetadataKeyTrackNumber];
    NSNumber *discCount = discData[THMetadataKeyTrackCount];
    uint16_t values[3] = {0};
    if (discNumber && ![discNumber isKindOfClass:[NSNull class]]) {
        values[1] = CFSwapInt16HostToBig([discNumber unsignedIntegerValue]);
    }
    
    if (discCount && ![discCount isKindOfClass:[NSNull class]]) {
        values[2] = CFSwapInt16HostToBig([discCount unsignedIntegerValue]);
    }
    
    size_t length = sizeof(values);
    metadataItem.value = [NSData dataWithBytes:values length:length];
    return metadataItem;
}

@end
