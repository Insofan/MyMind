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

#import "THRecorderController.h"
#import <AVFoundation/AVFoundation.h>
#import "THMemo.h"
#import "THLevelPair.h"
#import "THMeterTable.h"

@interface THRecorderController () <AVAudioRecorderDelegate>

@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) THRecordingStopCompletionHandler completionHandler;
@property (strong, nonatomic) THMeterTable *meterTable;

@end

@implementation THRecorderController

- (id)init {
    self = [super init];
    if (self) {
        NSString *tmpDir = NSTemporaryDirectory();
        NSString *filePath = [tmpDir stringByAppendingPathComponent:@"memo.caf"];
        NSURL *fileURL  = [NSURL fileURLWithPath:filePath];

        NSDictionary *setting = @{
                //设置格式
                AVFormatIDKey: @(kAudioFormatAppleIMA4),
                //设置采样率
                AVSampleRateKey: @44100.0f,
                //设置声道, 如果没有外接设备, 应该设为1
                AVNumberOfChannelsKey: @1,
                //位深16位
                AVEncoderBitDepthHintKey: @16,
                AVEncoderAudioQualityKey: @(AVAudioQualityMedium),
        };

        NSError *err;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:setting error:&err];

        if (self.recorder) {
            self.recorder.delegate = self;
            [self.recorder prepareToRecord];
        } else {
            NSLog(@"Err: %@", [err localizedDescription]);
        }

        _meterTable = [[THMeterTable alloc] init];
    }
    return self;
}

- (BOOL)record {
    return [self.recorder record];
}

- (void)pause {
    [self.recorder pause];
}

//这种设计方式很有意思, 函数设计一个Block, 在m文件里设置一个property 属性是 block 让 函数block 等于 属性block, 然后在其他的代理里面用block传值
- (void)stopWithCompletionHandler:(THRecordingStopCompletionHandler)handler {
    self.completionHandler = handler;
    [self.recorder stop];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)success {
    if (self.completionHandler) {
        self.completionHandler(success);
    }
}

- (void)saveRecordingWithName:(NSString *)name completionHandler:(THRecordingSaveCompletionHandler)handler {
    NSTimeInterval timestamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *filename = [NSString stringWithFormat:@"%@-%f.m4a", name, timestamp];
    NSString *docksDir = [self documentsDirectory];
    NSString *destPath = [docksDir stringByAppendingPathComponent:filename];
    NSURL *srcURL= self.recorder.url;
    NSURL *destURL = [NSURL fileURLWithPath:destPath];
    NSError *err;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:srcURL toURL:destURL error:&err];

    if (success) {
        handler(true, [THMemo memoWithTitle:name url:destURL]);
        [self.recorder prepareToRecord];
    } else {
        handler(false, err);
    }
}

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    return [paths objectAtIndex:0];
}

- (THLevelPair *)levels {
    [self.recorder updateMeters];
    float avgPower = [self.recorder averagePowerForChannel:0];
    float peakPower = [self.recorder peakPowerForChannel:0];
    float linearLevel = [self.meterTable valueForPower:avgPower];
    float linearPeak = [self.meterTable valueForPower:peakPower];
    return [THLevelPair levelsWithLevel:linearLevel peakLevel:linearPeak];
}

- (NSString *)formattedCurrentTime {
    NSUInteger time = (NSUInteger)self.recorder.currentTime;
    NSInteger hours = (time / 3600);
    NSInteger minutes = (time / 60) % 60;
    NSInteger seconds = time % 60;
    NSString *format = @"%02i:%02i:%02i";
    //AVPlayer 等大概率不可使用KVO
    return [NSString stringWithFormat:format, hours, minutes, seconds];
}

- (BOOL)playbackMemo:(THMemo *)memo {
    [self.player stop];
    NSError *err;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:memo.url error:&err];

    if (err) {
        NSLog(@"err %@", [err localizedDescription]);
    }
    if (self.player) {
        [self.player play];
        return true;
    }
    return NO;
}

@end
