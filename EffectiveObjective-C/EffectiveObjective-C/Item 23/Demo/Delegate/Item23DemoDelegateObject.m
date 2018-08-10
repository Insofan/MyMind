//
//  Item23DemoDelegateObject.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item23DemoDelegateObject.h"
@interface Item23DemoDelegateObject()
@property (nonatomic, copy) NSArray<NSString *> *dataList;
@property (nonatomic, copy) selectCell block;
@end
@implementation Item23DemoDelegateObject
#pragma mark - ----- Life Cycle ------
+ (id)tableViewDelegateWithDataList:(NSArray<NSString *> *)dataList selectBlock:(selectCell)selectBlock {
//    return [[self class] alloc] init
    return [[[self class] alloc]initTableViewDelegateWithDataList:dataList selectBlock:selectBlock];
}


- (id)initTableViewDelegateWithDataList:(NSArray <NSString *> *)dataList selectBlock:(selectCell)selectBlock {
    self = [super init];
    if (self) {
        self.dataList = [dataList copy];
        self.block = selectBlock;
    }
    return self;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCell];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCell];
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    self.block(indexPath);
}

@end
