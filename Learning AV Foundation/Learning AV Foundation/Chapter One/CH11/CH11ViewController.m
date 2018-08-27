//
//  CH11ViewController.m
//  Learning AV Foundation
//
//  Created by Insomnia on 2018/8/24.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "CH11ViewController.h"
@interface CH11ViewController ()

@end

@implementation CH11ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 只能使用一次
    AVSpeechSynthesizer *synthesizer = [AVSpeechSynthesizer new];
    //    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:@"Hello World!"];
    //    [synthesizer speakUtterance:utterance];
    //     AVSpeechUtterance *utterance2 = [[AVSpeechUtterance alloc] initWithString:@"你好世界!"];
    //    utterance2.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    //    [synthesizer speakUtterance:utterance2];
    self.view.backgroundColor = [UIColor hx_randomColor];
    AVSpeechUtterance *utterance3 = [[AVSpeechUtterance alloc] initWithString:@"食屎啦你!"];
    utterance3.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-HK"];
    [synthesizer speakUtterance:utterance3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
