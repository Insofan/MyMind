//
//  ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/7/9.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ViewController.h"
#import <HXTool.h>

@interface ViewController ()
@property (copy, nonatomic) NSArray *vcArray;
@end

@implementation ViewController

- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                     @{@"key": @"Item 10", @"value":NSClassFromString(@"Item10ViewController")},
                     @{@"key": @"Item 11", @"value":NSClassFromString(@"Item11ViewController")},
                     @{@"key": @"Item 12", @"value":NSClassFromString(@"Item12ViewController")},
                     @{@"key": @"Item 13", @"value":NSClassFromString(@"Item13ViewController")},
                     @{@"key": @"Item 16", @"value":NSClassFromString(@"Item16ViewController")},
                     @{@"key": @"Item 17", @"value":NSClassFromString(@"Item17ViewController")},
                     @{@"key": @"Item 18", @"value":NSClassFromString(@"Item18ViewController")},
                     @{@"key": @"Item 21", @"value":NSClassFromString(@"Item21ViewController")},
                     @{@"key": @"Item 22", @"value":NSClassFromString(@"Item22ViewController")},
                     @{@"key": @"Item 23", @"value":NSClassFromString(@"Item23ViewController")},
                     @{@"key": @"Item 23 Demo", @"value":NSClassFromString(@"Item23DemoViewController")},
                     @{@"key": @"Item 24", @"value":NSClassFromString(@"Item24ViewController")},
                     @{@"key": @"Item 25", @"value":NSClassFromString(@"Item25ViewController")},
                     @{@"key": @"Item 26", @"value":NSClassFromString(@"Item26ViewController")},
                     @{@"key": @"Item 28", @"value":NSClassFromString(@"Item28ViewController")},
                     @{@"key": @"Item 30", @"value":NSClassFromString(@"Item30ViewController")},
                     @{@"key": @"Item 31", @"value":NSClassFromString(@"Item31ViewController")},

                     ];
    }
    return _vcArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor hx_randomColor];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"baseReuse"];

}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen hx_screenHeight] / 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseReuse"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"baseReuse"];
    cell.textLabel.text = _vcArray[indexPath.row][@"key"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    UIViewController *vc = [[_vcArray[indexPath.row][@"value"] class] new];
    vc.title = self.vcArray[indexPath.row][@"key"];
    
    [self.navigationController pushViewController:vc animated:true];
    
}

@end
