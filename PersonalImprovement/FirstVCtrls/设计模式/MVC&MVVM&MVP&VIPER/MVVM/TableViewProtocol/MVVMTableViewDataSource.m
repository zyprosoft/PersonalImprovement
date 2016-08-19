//
//  TableViewDataSource.m
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MVVMTableViewDataSource.h"
#import "MVVMCustomTableViewCell.h"
#import "MVVMCustomModel.h"

@implementation MVVMTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MVVMCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[MVVMCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.titleLabel.text=((MVVMCustomModel *)[_array objectAtIndex:indexPath.row]).title;
    return cell;
}

@end
