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
#import <AVFoundation/AVFoundation.h>

@interface THPlayerController()
//这个写法好独特
@property (nonatomic, readwrite) BOOL playing;
@property (strong, nonatomic) NSArray *players;
@end

@implementation THPlayerController

- (instancetype)init {
    self = [super init];
    if (self) {
        AVAudioPlayer *guitarPlayer = [self playForFile:@"guitar"];
        AVAudioPlayer *bassPlayer = [self playForFile:@"bass"];
        AVAudioPlayer *drumsPlayer = [self playForFile:@"drums"];
        _players = @[guitarPlayer, bassPlayer, drumsPlayer];

        NSNotificationCenter *nsnc = [NSNotificationCenter defaultCenter];

        /*
        [nsnc addObserver:self selector:@selector(handleInterruption:)
                name:AVAudioSessionInterruptionNotification
                   object:[AVAudioSession sharedInstance]];
         */
        [nsnc addObserver:self selector:@selector(handleRouteChange:) name:AVAudioSessionRouteChangeNotification object:[AVAudioSession sharedInstance]];
    }
     return self;
}

- (AVAudioPlayer *)playForFile:(NSString *)name {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:name withExtension:@"caf"];
    NSError *err;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&err];

    if (player) {
        //无限循环
        player.numberOfLoops = -1;
        player.enableRate = true;
        [player prepareToPlay];
    } else {
        NSLog(@"Error creating player: %@", [err localizedDescription]);
    }
    return player;
}

- (void)play {
    if (!self.playing) {
        //这种写法是为了三个乐器保持同步
        NSTimeInterval delayTime = [self.players[0] deviceCurrentTime] + 0.01;
        for (AVAudioPlayer * player in self.players) {
            [player playAtTime:delayTime];
        }
        self.playing = true;
    }
}

- (void)stop {
    if (self.playing) {
        for (AVAudioPlayer *player in self.players) {
            [player stop];
            player.currentTime = 0.0;
        }
        self.playing = false;
    }
}

- (void)adjustRate:(float)rate {
    for (AVAudioPlayer *player in self.players) {
        player.rate = rate;
    }

}

- (void)adjustPan:(float)pan forPlayerAtIndex:(NSUInteger)index {
    if ([self isValidIndex:index]) {
        AVAudioPlayer *player = self.players[index];
        player.pan = pan;
    }

}

- (void)adjustVolume:(float)volume forPlayerAtIndex:(NSUInteger)index {
    if ([self isValidIndex:index]) {
        AVAudioPlayer *player = self.players[index];
        player.volume = volume;
    }
}

- (bool)isValidIndex:(NSUInteger)index {
    return index == 0 || index < self.players.count;
}

- (void)handleInterruption:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    AVAudioSessionInterruptionType type = [info[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    /**
     * 判断打断开始, 结束
     */
    if (type == AVAudioSessionInterruptionTypeBegan) {
        [self stop];
        if (self.delegate) {
            [self.delegate playbackStopped];
        }
    }else {
        /**
         * AVAudioSessionInterruptionTypeEnded, userInfo字典里会包含一个 AVAudioSessionInterruptionOptions值来表名音频会话是否已经重新激活, 以及是否可以再次播放
         */
         AVAudioSessionInterruptionOptions options = [info[AVAudioSessionInterruptionOptionKey] unsignedIntegerValue];
         if (options == AVAudioSessionInterruptionOptionShouldResume) {
             [self play];
             if (self.delegate) {
                 [self.delegate playbackBegan];
             }
         }

    }
}

/**
 * 耳机断开时停止播放
 * @param notification
 */
- (void)handleRouteChange:(NSNotification *)notification{
    /**
     * 线路变换例如用户断开耳机时, 应该停止播放
     */

    NSDictionary *info = notification.userInfo;
    AVAudioSessionRouteChangeReason reason = [info[AVAudioSessionRouteChangeReasonKey] unsignedIntegerValue];

    //耳机断开
    if (reason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *previousRoute = info[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *previousOutput = previousRoute.outputs[0];
        NSString *portType = previousOutput.portType;

        if ([portType isEqualToString:AVAudioSessionPortHeadphones]) {
            [self stop];
            [self.delegate playbackStopped];
        }
    }
}

@end
