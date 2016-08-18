//
//  StructureVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/18.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "StructureVCtrl.h"


@interface StructureVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StructureVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"MVC" class:@"aaa"];
    [self addCell:@"MVVM&ReactiveCocoa" class:@"StructureVCtrl"];
    [self addCell:@"Pattern" class:@"PatternVCtrl"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = self.titleArray[indexPath.row];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = self.titleArray[indexPath.row];
    if ([cellTitle isEqualToString:@"MVC"]) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MVC" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ctrl"];
        ctrl.title = cellTitle;
        [self.navigationController pushViewController:ctrl animated:YES];
    }else {
        NSString *classStr = self.classArray[indexPath.row];
        Class class = NSClassFromString(classStr);
        UIViewController *ctrl = [[class alloc]init];
        ctrl.title = cellTitle;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
