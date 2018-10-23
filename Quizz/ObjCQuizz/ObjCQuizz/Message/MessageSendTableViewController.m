//
//  MessageSendTableViewController.m
//  ObjCQuizz
//
//  Created by Insomnia on 2018/10/22.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "MessageSendTableViewController.h"

@interface MessageSendTableViewController ()
@property(copy, nonatomic) NSArray *vcArray;
@end

@implementation MessageSendTableViewController


- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                     @{@"key": @"Message Send Use", @"value": NSClassFromString(@"MessageSendUseViewController")},
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
