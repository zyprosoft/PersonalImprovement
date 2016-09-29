//
//  StructureVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/18.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "StructureVCtrl.h"
#import "VTDAppDependencies.h"

#import "CNTCountInteractor.h"
#import "CNTCountPresenter.h"
#import "CNTCountViewController.h"

#import "ASHCoreDataStack.h"
// View Controllers
#import "ASHMasterViewController.h"
// View Models
#import "ASHMasterViewModel.h"

@interface StructureVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StructureVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"MVC" class:@"ItemViewController"];
    [self addCell:@"MVP" class:@"BBB"];
    [self addCell:@"MVP2" class:@"CCC"];
    [self addCell:@"MVVM" class:@"CCC"];
    [self addCell:@"MVVM2(C-14完整项目)" class:@"CCC"];
    [self addCell:@"VIPER" class:@"CCC"];
    [self addCell:@"VIPER2" class:@"CCC"];
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
    if ([cellTitle isEqualToString:@"MVP"]) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MVP" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ctrl"];
        ctrl.title = cellTitle;
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"MVP2"]) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MVP2" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ctrl"];
        ctrl.title = cellTitle;
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"MVVM"]) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MVVMMain" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"PublicTableViewController"];
        ctrl.title = cellTitle;
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"MVVM2(C-14完整项目)"]) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MVVM2" bundle:nil];
        ASHMasterViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ctrl"];
        ctrl.title = cellTitle;
        ASHMasterViewModel *viewModel = [[ASHMasterViewModel alloc] initWithModel:[ASHCoreDataStack defaultStack].managedObjectContext];
        ctrl.viewModel = viewModel;
        // Setup model
        [[ASHCoreDataStack defaultStack] ensureInitialLoad];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"VIPER"]) {
        VTDAppDependencies *dependencies = [[VTDAppDependencies alloc] init];
        [dependencies installRootViewControllerIntoWindow:KCurrentWindow];
    }else if ([cellTitle isEqualToString:@"VIPER2"]) {
        CNTCountViewController* view = [[CNTCountViewController alloc] init];
        CNTCountPresenter* presenter = [[CNTCountPresenter alloc] init];
        CNTCountInteractor* interactor = [[CNTCountInteractor alloc] init];
        
        view.presenter = presenter;
        presenter.view = view;
        
        presenter.interactor = interactor;
        interactor.output = presenter;
        [self.navigationController pushViewController:view animated:YES];
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
