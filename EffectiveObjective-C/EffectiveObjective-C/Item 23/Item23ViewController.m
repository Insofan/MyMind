//
//  Item23ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/9.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item23ViewController.h"
#import "Item23Network.h"

@interface Item23ViewController() <Item23NetworkDelegate>
@property(strong, nonatomic) Item23Network *network1;
@property(strong, nonatomic) Item23Network *network2;

@end

@implementation Item23ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor hx_randomColor];
    Item23Network *network1 = [[Item23Network alloc] init];
    _network1 = network1;
    _network1.delegate = self;
    
    
    Item23Network *network2 = [Item23Network new];
    _network2 = network2;
    _network2.delegate = self;
    [self setUI];

   

}

- (void)setUI {
    UIButton *buttonOne = [UIButton hx_buttonWithTitle:@"One" fontSize:16 normalColor:[UIColor redColor] selectedColor:[UIColor redColor]];
    buttonOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonOne];

    UIButton *buttonTwo = [UIButton hx_buttonWithTitle:@"Two" fontSize:16 normalColor:[UIColor redColor] selectedColor:[UIColor redColor]];
    [self.view addSubview:buttonTwo];
    buttonTwo.backgroundColor = [UIColor whiteColor];

    [buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];


    [buttonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(100);
    }];

    @weakify(self);
    [[buttonOne rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
        @strongify(self);
        [self.network1 sendSuccess];
        [self.network1 sendProgress];
    }];

    [[buttonTwo rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
        @strongify(self);

        [self.network2 sendSuccess];
        [self.network2 sendFail];
    }];

}

#pragma mark Delegate

- (void)networkFetcher:(Item23Network *)fetcher didReceiveData:(NSData *)data {
    if ([fetcher isEqual:_network1]) {
        NSLog(@"Network 1");
    } else {
        NSLog(@"Network 2");
    }
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"fetch = %@, data = %@", fetcher, str);
}

- (void)networkFetcher:(Item23Network *)fetcher didFailWithError:(NSError *)error {
    NSLog(@"fetcher = %@, error.code = %lu", fetcher, error.code);
}

- (void)networkFetcher:(Item23Network *)fetcher didUpdateProgressTo:(float)progress {
    NSLog(@"fetcher = %@, progress = %f", fetcher, progress);
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
