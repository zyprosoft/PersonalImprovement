//
//  AlgorithmVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/23.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "AlgorithmVCtrl.h"

@interface AlgorithmVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AlgorithmVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // OC
    [self addCell:@"插入排序" class:@"22"];
    [self addCell:@"归并排序" class:@"22"];
    [self addCell:@"快速排序" class:@"22"];
    [self addCell:@"冒泡排序" class:@"22"];
    [self addCell:@"希尔排序" class:@"22"];
    [self addCell:@"堆排序" class:@"22"];
    
    [self addCell:@"线性查找" class:@"22"];
    [self addCell:@"二分查找" class:@"22"];
    
    [self addCell:@"Dijkstra" class:@"22"];
    [self addCell:@"动态规划" class:@"22"];
    [self addCell:@"二叉树" class:@"22"];
    [self addCell:@"汉诺塔" class:@"22"];
    [self addCell:@"链表" class:@"22"];
    [self addCell:@"深度优先算法" class:@"22"];
    
    //SWIFT
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.titleArray[indexPath.row];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = self.titleArray[indexPath.row];
    NSString *classStr = self.classArray[indexPath.row];
    Class class = NSClassFromString(classStr);
    UIViewController *ctrl = [[class alloc]init];
    ctrl.title = cellTitle;
    [self.navigationController pushViewController:ctrl animated:YES];
}


@end
