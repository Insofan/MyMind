//
//  Item41ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/27.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item41ViewController.h"

@interface Item41ViewController ()
@end

@implementation Item41ViewController
static NSString *_name;
static dispatch_queue_t _syncQueue;


- (instancetype)init {
    self = [super init];
    if (self) {
        //0是并行, NULL是串行
        _syncQueue = dispatch_queue_create("com.effectiveobjectivec.syncQueue", DISPATCH_QUEUE_SERIAL);
//        _syncQueue = dispatch_queue_create("com.effectiveobjectivec.syncQueue", NULL);
    }
    return self;
}

- (NSString *)name {
    __block NSString *localStr;
    dispatch_sync(_syncQueue, ^{
        localStr = _name;
    });
    return localStr;
}

- (void)setName:(NSString *)name{
    dispatch_barrier_async(_syncQueue, ^{
        _name = [NSString stringWithFormat:@"%@", name];
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    

    //保证读写线程安全
    
    self.name = [NSString stringWithFormat:@"name"];
    NSLog(@"name: %@ thread: %@", self.name , [NSThread currentThread]);
    
    self.otherName = [NSString stringWithFormat:@"Other name"];
    NSLog(@"other name: %@ thread: %@", self.otherName , [NSThread currentThread]);
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if (_name) {
        _name = nil;
    }
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
