//
//  Item37ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/24.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item37ViewController.h"

@interface Item37ViewController ()
@property (nonatomic, copy) NSString *anInstanceVariable;
@end

@implementation Item37ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self someblock];
}


- (void)someblock {
    int (^addBlock) (int a, int b) = ^(int a, int b){
        return a + b;
    };
    int sum = addBlock(1, 2);
    int additional = 5;
    int (^addBlockTwo) (int a, int b) = ^(int a, int b) {
        return  a + b + additional;
    };
    int sum2 = addBlockTwo(2, 5);
    
    //block 默认无法修改外部变量, 可以加block来修改
    __block NSInteger count = 0;
    NSArray * array = @[@0, @1, @2, @3, @4, @5];
    [array enumerateObjectsUsingBlock:^(NSNumber * number, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([number compare:@2] == NSOrderedAscending) {
            count++;
        }
    }];
    //block 内无需声明__block可以直接修改自身property, 应使用self 访问自身property, 可以通过rac宏来避免循环引用
    @weakify(self);
    void (^someblock)(void) = ^{
        _anInstanceVariable = @"Something";
        @strongify(self);
        NSLog(@"_anInstanceVariable %@", self.anInstanceVariable);
    };
    someblock();
    void (^aBlock)(void);
    
//    self.anInstanceVariable = @"Something";
    if ([self.anInstanceVariable isEqualToString:@"Something"]) {
        aBlock = [^{
            NSLog(@"Block A");
        } copy];
    }else {
        aBlock = [^{
            NSLog(@"Block B");
        } copy];
    }
    aBlock();
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
