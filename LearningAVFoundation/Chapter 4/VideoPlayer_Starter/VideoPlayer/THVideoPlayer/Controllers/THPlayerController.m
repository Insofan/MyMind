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

#import "THPlayerController.h"
#import "THThumbnail.h"
#import <AVFoundation/AVFoundation.h>
#import "THTransport.h"
#import "THPlayerView.h"
#import "AVAsset+THAdditions.h"
#import "UIAlertView+THAdditions.h"
#import "THNotifications.h"

// AVPlayerItem's status property
#define STATUS_KEYPATH @"status"

// Refresh interval for timed observations of AVPlayer
#define REFRESH_INTERVAL 0.5f

// Define this constant for the key-value observation context.
static const NSString *PlayerItemStatusContext;


@interface THPlayerController () <THTransportDelegate>

@property (strong, nonatomic) THPlayerView *playerView;

// Listing 4.4
@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;

@property (weak, nonatomic) id <THTransport> transport;

@property (nonatomic, strong) id timeObserver;
@property (nonatomic, strong) id itemEndObserver;
@property (nonatomic, assign) float lastPlaybackRate;

@end

@implementation THPlayerController

#pragma mark - Setup

- (id)initWithURL:(NSURL *)assetURL {
    self = [super init];
    if (self) {
        
        // Listing 4.6
        _asset = [AVAsset assetWithURL:assetURL];
        [self prepareToPlay];
        
    }
    return self;
}

- (void)prepareToPlay {

    // Listing 4.6
    NSArray *keys = @[@"tracks",
                      @"duration",
                      @"commonMetadata",
                      @"availableMediaCharacteristicsWithMediaSelectionOptions"
                      ];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset
                           automaticallyLoadedAssetKeys:keys];
    
    [self.playerItem addObserver:self forKeyPath:STATUS_KEYPATH
                         options:0
                         context:&PlayerItemStatusContext];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView = [[THPlayerView alloc] initWithPlayer:self.player];
    self.transport  = self.playerView.transport;
    self.transport.delegate = self;
}



- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    // Listing 4.7
    // 将Status 设置为监听属性, 监听之前要先实现observeValueForKeyPath方法
    if (context == &PlayerItemStatusContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.playerItem removeObserver:self forKeyPath:STATUS_KEYPATH];
            
            if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
                // set up time observers
                [self addPlayerItemTimeObserver];
                [self addItemEndObserverForPlayerItem];
                
                
                CMTime duration = self.playerItem.duration;
                
                //Synchronize the time display, 同步时间
                [self.transport setCurrentTime:CMTimeGetSeconds(kCMTimeZero) duration:CMTimeGetSeconds(duration)];
                
                //Set the video title
                [self.transport setTitle:self.asset.title];
                
                [self.player play];
            } else {
                [UIAlertView showAlertWithTitle:@"Error" message:@"Failed to load video"];
            }
        });
    }
}

#pragma mark - Time Observers

- (void)addPlayerItemTimeObserver {

    // Listing 4.8
    // step 1
    // Create 0.5 second refresh interval - REFRESH_INTERVAL == 0.5
    CMTime interval = CMTimeMakeWithSeconds(REFRESH_INTERVAL, NSEC_PER_SEC);
    
    // step 2
    // Main dispatch queue
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // step 3
    // Create callback block for time observer
    __weak THPlayerController *weakSelf = self;
    void (^callBack) (CMTime time) = ^(CMTime time) {
        // step 4: 取time, 算出来currentTime, duration 用代理传回去
        NSTimeInterval currentTime = CMTimeGetSeconds(time);
        NSTimeInterval duration = CMTimeGetSeconds(weakSelf.playerItem.duration);
        [weakSelf.transport setCurrentTime:currentTime duration:duration];
    };
    
    // step 5
    // Add observer add store pointer for future use
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:interval
                                                                  queue:queue
                                                             usingBlock:callBack];
}

- (void)addItemEndObserverForPlayerItem {

    // Listing 4.9
    NSString *name = AVPlayerItemDidPlayToEndTimeNotification;
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    // step 1
    __weak THPlayerController *weakSelf = self;
    void (^callback) (NSNotification *note) = ^(NSNotification *notification) {
        // step 2 播放完毕后将player的光标回到0位置
        [weakSelf.player seekToTime:kCMTimeZero
                  completionHandler:^(BOOL finished) {
                      // step 3: 当 step 2完成后通知播放栏播放已经完成
                      [weakSelf.transport playbackComplete];
                  }];
    };
    // step 4 通过注册NSNotificationCenter 来添加itemEndObserver作为通知的监听器, 将之前的参数传给他
    self.itemEndObserver = [[NSNotificationCenter defaultCenter] addObserverForName:name
                                                                             object:self.playerItem
                                                                              queue:queue
                                                                         usingBlock:callback];
}

- (void)dealloc {
    // step 5 重写delloc 移除itemEndObserver通知
    if (self.itemEndObserver) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc removeObserver:self.itemEndObserver
                      name:AVPlayerItemDidPlayToEndTimeNotification
                    object:self.player.currentItem];
        self.itemEndObserver = nil;
    }
}

#pragma mark - THTransportDelegate Methods

- (void)play {

    // Listing 4.10
    // step 1
    [self.player play];
    
}

- (void)pause {

    // Listing 4.10
    // step 2
    self.lastPlaybackRate = self.player.rate;
    [self.player pause];
    
}

- (void)stop {

    // Listing 4.10
    // step 3
    [self.player setRate:0.0f];
    [self.transport playbackComplete];
    
}

- (void)jumpedToTime:(NSTimeInterval)time {

    // Listing 4.10
    // step 4
    [self.player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC)];
    
}

- (void)scrubbingDidStart {
    
    // Listing 4.11
    // step 5
    self.lastPlaybackRate = self.player.rate;
    [self.player pause];
    [self.player removeTimeObserver:self.timeObserver];
    self.timeObserver = nil;
}

- (void)scrubbedToTime:(NSTimeInterval)time {
    
    // Listing 4.11
    // step 6
    [self.playerItem cancelPendingSeeks];
    [self.player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC)];
}

- (void)scrubbingDidEnd {
    
    // Listing 4.11
    // step 7
    [self addPlayerItemTimeObserver];
    if (self.lastPlaybackRate > 0.0f) {
        [self.player play];
    }
}


#pragma mark - Thumbnail Generation

- (void)generateThumbnails {

    // Listing 4.14

}


- (void)loadMediaOptions {

    // Listing 4.16
    
}

- (void)subtitleSelected:(NSString *)subtitle {

    // Listing 4.17
    
}


#pragma mark - Housekeeping

- (UIView *)view {
    return self.playerView;
}

@end
