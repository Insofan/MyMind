//
//  Item23DemoViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/10.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item23DemoViewController.h"
#import "Item23DemoDelegateObject.h"
@interface Item23DemoViewController ()
//@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) Item23DemoDelegateObject *delegateObject;
@end

@implementation Item23DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseCell];
    
    
    NSMutableArray <NSString *> *dataList = [NSMutableArray new];
    for (int i = 0; i < 20; i++) {
        [dataList addObject:[NSString stringWithFormat:@"Number %d", i]];
    }
    
    self.delegateObject = [Item23DemoDelegateObject tableViewDelegateWithDataList:dataList selectBlock:^(NSIndexPath *indexPath) {
        NSLog(@"点击了 %tu", indexPath.row);
    }];
    
    self.tableView.delegate = self.delegateObject;
    self.tableView.dataSource = self.delegateObject;
    [self.tableView reloadData];
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
