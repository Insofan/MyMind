//
//  Item41ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item41ViewController.h"

@interface Item41ViewController ()
@property (nonatomic, copy) NSString *someStr;
@property (nonatomic, strong) dispatch_queue_t syncQueue;
@end

@implementation Item41ViewController

- (dispatch_queue_t)syncQueue {
    if (!_syncQueue) {
        _syncQueue = dispatch_queue_create("com.effectiveobjective.syncQueue",NULL);
    }
    return _syncQueue;
}

- (NSString *)someStr {
    __block NSString *localStr;
    @weakify(self);
//    _syncQueue = dispatch_queue_create("com.effectiveobjective.syncQueue",NULL);

    dispatch_sync(self.syncQueue, ^{
        @strongify(self);
        localStr = self.someStr;
    });
    return localStr;
}

- (void)setSomeStr:(NSString *)someStr{
    dispatch_sync(self.syncQueue, ^{
        self.someStr = [NSString stringWithFormat:@"%@", someStr];
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    //避免使用@synchronized和 nslock, 使用gcd队列, 这段有问题 一直不对
    //0是并行, NULL是串行
    [self syncQueue];
//    NSLog(@"str: %@", self.someStr);
    self.someStr = @"set value 1";
    NSLog(@"str: %@", self.someStr);
    self.someStr = @"set value 2";
    NSLog(@"str: %@", self.someStr);
    NSLog(@"str: %@", self.someStr);


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
