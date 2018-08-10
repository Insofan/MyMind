//
//  Item23DemoDelegateObject.h
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^selectCell) (NSIndexPath *indexPath);

@interface Item23DemoDelegateObject : NSObject <UITableViewDelegate, UITableViewDataSource>

+ (id)tableViewDelegateWithDataList:(NSArray <NSString *> *)dataList selectBlock:(selectCell)selectBlock;
@end
