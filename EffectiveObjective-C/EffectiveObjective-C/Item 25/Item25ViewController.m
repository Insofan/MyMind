//
//  Item25ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/13.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item25ViewController.h"
#import "Item25String+ABCHTTP.h"
@interface Item25ViewController ()

@end

@implementation Item25ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    NSString *str = @"str";
    str =  [str abc_urlEncodedString];
    NSLog(@"encode %@", str);
    str = [str abc_urlDecodedString];
    NSLog(@"decode %@", str);

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
