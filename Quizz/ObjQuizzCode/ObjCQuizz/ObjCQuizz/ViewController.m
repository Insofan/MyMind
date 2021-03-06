//
//  ViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/9/25.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(copy, nonatomic) NSArray *vcArray;

@end

@implementation ViewController
- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                @{@"key": @"KVO", @"value": NSClassFromString(@"KVOTableViewController")},
                @{@"key": @"Runtime Api", @"value": NSClassFromString(@"RuntimeApiTableViewController")},
                @{@"key": @"Message Send", @"value": NSClassFromString(@"MessageSendTableViewController")},
                @{@"key": @"Swizzling Method", @"value": NSClassFromString(@"SwizzlingMethodTableViewController")},
        ];
    }
    return _vcArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor hx_randomColor];
    self.title                = @"ObjC Quizz";
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
