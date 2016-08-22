//
//  ReactiveCocoaMVVMVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/8/22.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "ReactiveCocoaMVVMVCtrl.h"
#import "RWTFlickrSearchViewModel.h"
#import "RWTFlickrSearchViewController.h"
#import "RWTViewModelServicesImpl.h"

@interface ReactiveCocoaMVVMVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ReactiveCocoaMVVMVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"RWTFlickrSearch" class:@"ddd"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    if ([cellTitle isEqualToString:@"RWTFlickrSearch"]) {
        UIViewController *viewController = [self createInitialViewController];
        [self.navigationController pushViewController:viewController animated:YES];
    }else {
        UIViewController *ctrl = [[class alloc]init];
        ctrl.title = cellTitle;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (UIViewController *)createInitialViewController {
    RWTViewModelServicesImpl *viewModelServices = [[RWTViewModelServicesImpl alloc] initWithNavigationController:self.navigationController];
    RWTFlickrSearchViewModel *viewModel = [[RWTFlickrSearchViewModel alloc]
                      initWithServices:viewModelServices];
    return [[RWTFlickrSearchViewController alloc]
            initWithViewModel:viewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
