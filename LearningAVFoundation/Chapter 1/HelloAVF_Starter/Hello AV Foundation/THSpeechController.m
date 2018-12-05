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

#import "THSpeechController.h"
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface THSpeechController ()
//老代码都会用这种里外一致的写法
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) NSArray  *voices;
@property (strong, nonatomic) NSArray *speechStrings;
@end
NS_ASSUME_NONNULL_END

@implementation THSpeechController

+ (instancetype)speechController {
    return [[self alloc] init];
}

- (id)init {
   self = [super init];
   if (self) {
       _synthesizer = [AVSpeechSynthesizer new];
       //设置语言, 粤语
       //[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-HK"];
       _voices = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"], [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"]];
       _speechStrings = [self buildSpeechStrings];
   }
    return self;
}

- (void)beginConversation {
    [_speechStrings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.speechStrings[idx]];
        utterance.voice = self.voices[idx % 2];
        utterance.rate = 0.4f;
        utterance.pitchMultiplier = 0.8f;
        utterance.postUtteranceDelay = 0.1f;
        [self.synthesizer speakUtterance:utterance];
    }];
}

- (NSArray *)buildSpeechStrings {
    return @[
            @"Hello AV Foundation. How are you?",
            @"I'm well! Thanks for asking.",
            @"Are you excited about the book",
            @"Very! I have always felt so misunderstood",
            @"What's your favourite feature?",
            @"Oh, they're all my babies. I couldn't possibly choose"
            ];
}

@end
