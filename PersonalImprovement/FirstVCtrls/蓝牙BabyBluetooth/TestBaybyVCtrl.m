//
//  TestBaybyVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/9/1.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "TestBaybyVCtrl.h"
#import "BluetoothAppVCtrl.h"
#import "BluetoothStubVCtrl.h"

@interface TestBaybyVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TestBaybyVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"功能";
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"BluetoothAppVCtrl" class:@"BluetoothAppVCtrl"];
    [self addCell:@"BluetoothStubVCtrl" class:@"BluetoothStubVCtrl"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = self.titleArray[indexPath.row];
    NSString *classStr = self.classArray[indexPath.row];
    Class class = NSClassFromString(classStr);
    UIViewController *ctrl = [[class alloc]init];
    ctrl.title = cellTitle;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
