//
//  RuntimeApiTableViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/15.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "RuntimeApiTableViewController.h"

@interface RuntimeApiTableViewController ()
@property(copy, nonatomic) NSArray *vcArray;
@end

@implementation RuntimeApiTableViewController

- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                     @{@"key": @"Runtime NSObject Use", @"value": NSClassFromString(@"RuntimeNSObjectViewController")},
                     ];
    }
    return _vcArray;
}

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
