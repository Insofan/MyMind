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

#import "THDocument.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "THChapter.h"

#define STATUS_KEY @"status"

@interface THDocument ()
// step 1
@property (strong) AVAsset *asset;
@property (strong) AVPlayerItem *playerItem;
@property (strong) NSArray *chapters;

@property (weak) IBOutlet AVPlayerView *playerView;
@end

@implementation THDocument

- (NSString *)windowNibName {
    return @"THDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)controller {
    [super windowControllerDidLoadNib:controller];
    // step 2
    [self setupPlaybackStackWithUrl:[self fileURL]];
}


- (void)setupPlaybackStackWithUrl:(NSURL *)url {
    self.asset = [AVAsset assetWithURL:url];
    
    // step 3
    NSArray *keys = @[@"commonMetadata", @"availableChapterLocales"];
    // step 4
    
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset
                           automaticallyLoadedAssetKeys:keys];
    // step 5
    [self.playerItem addObserver:self forKeyPath:STATUS_KEY
                         options:0
                         context:NULL];
    self.playerView.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.showsSharingServiceButton = true;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:STATUS_KEY]) {
        // step 6
        if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
            // step 7
            NSString *title = [self titleForAsset:self.asset];
            if (title) {
                self.windowForSheet.title = title;
            }
            // step 8
            self.chapters = [self chaptersForAsset:self.asset];
        }
    }
}

- (NSString *)titleInMetadata:(NSArray *)metadata {
    NSArray *items =
    [AVMetadataItem metadataItemsFromArray:metadata
                                   withKey:AVMetadataCommonKeyTitle
                                  keySpace:AVMetadataKeySpaceCommon];
    
    return [[items firstObject] stringValue];
}

- (NSString *)titleForAsset:(AVAsset *)asset {
    NSString *title = [self titleInMetadata:asset.commonMetadata];
    if (title && ![title isEqualToString:@""]) {
        return title;
    }
    return nil;
}

- (NSArray *)chaptersForAsset:(AVAsset *)asset {
    return nil;
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    return YES;
}

@end
