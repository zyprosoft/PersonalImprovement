//
//  StructureVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "StructureVCtrl.h"

@interface StructureVCtrl ()
@property (strong,nonatomic)NSMutableArray *titleArray;
@property (strong,nonatomic)NSMutableArray *classArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StructureVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = [NSMutableArray array];
    _classArray = [NSMutableArray array];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"MVC" class:@"TapkuRootViewController"];
    [self addCell:@"MVP" class:@"TapkuRootViewController"];
    [self addCell:@"MVVM" class:@"TapkuRootViewController"];
    [self addCell:@"VIPER" class:@"TapkuRootViewController"];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titleArray addObject:title];
    [self.classArray addObject:className];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = _titleArray[indexPath.row];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = _titleArray[indexPath.row];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"SystemServiceMainStoryboard" bundle:nil];
    UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ContactListViewController"];
    ctrl.title = cellTitle;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
