//
//  ViewController.m
//  Learning AV Foundation
//
//  Created by Insomnia on 2018/8/9.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (copy, nonatomic) NSArray *vcArray;

@end

@implementation ViewController

- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                     @{@"key": @"Chapter One", @"value": NSClassFromString(@"CH1TableViewController")},
                     
                     ];
    }
        return _vcArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor hx_randomColor];

    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen hx_screenHeight] / 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCell];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ReuseCell];
    cell.textLabel.text = _vcArray[indexPath.row][@"key"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView dequeueReusableCellWithIdentifier:ReuseCell];
    UIViewController *vc = [[_vcArray[indexPath.row][@"value"] class] new];
    vc.title = self.vcArray[indexPath.row][@"key"];
    [self.navigationController pushViewController:vc animated:true];

}
@end
