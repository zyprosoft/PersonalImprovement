//
//  SecondVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/3.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "SecondVCtrl.h"
#import "MainPageViewController.h"
#import "LeftSortsViewController.h"
#import "LeftSlideViewController.h"
#import "DKNightRootViewController.h"
#import "EAIntroViewController.h"
#import "FXFormsVCtrl.h"
#import "HMSegmentedViewController.h"
#import "SBExampleViewController.h"
#import "MMDrawerDemoVCtrl.h"
#import "MTViewController.h"
#import "OnboardVCtrl.h"
#import "ZSSDemoList.h"

@interface SecondVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *titleArray;
@property (strong,nonatomic)NSMutableArray *classArray;

@end

@implementation SecondVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SecondVCtrlItem:%@",self.tabBarItem);
    self.navigationController.tabBarItem.badgeValue = @"12";
    self.title = @"功能效果";
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _titleArray= [NSMutableArray array];
    _classArray = [NSMutableArray array];
    [self addCell:@"仿QQ侧滑" class:@"仿QQ侧滑"];
    [self addCell:@"夜间模式" class:@"DKNightRootViewController"];
    [self addCell:@"启动图片EAIntro" class:@"EAIntroViewController"];
    [self addCell:@"启动图片Onboard" class:@"OnboardVCtrl"];
    [self addCell:@"表格视图" class:@"FXFormsVCtrl"];
    [self addCell:@"HMSegmentedControl" class:@"HMSegmentedViewController"];
    [self addCell:@"JHStatusBar" class:@"SBExampleViewController"];
    [self addCell:@"MJRefresh" class:@"edeeee"];
    [self addCell:@"MMDrawer抽屉" class:@"MMDrawerDemoVCtrl"];
    [self addCell:@"MTAnimation" class:@"dddd"];
    [self addCell:@"TGCamera自定义相机" class:@"dddd"];
    [self addCell:@"TSMessage" class:@"dddd"];
    [self addCell:@"WYPopoverDemo" class:@"dddd"];
    [self addCell:@"WYPopoverDemoSegue" class:@"dddd"];
    [self addCell:@"XLForm" class:@"dddd"];
    [self addCell:@"ZSSRichTextEditor" class:@"ZSSDemoList"];
}


- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titleArray addObject:title];
    [self.classArray addObject:className];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = _titleArray[indexPath.row];
    NSString *classStr = _classArray[indexPath.row];
    Class class = NSClassFromString(classStr);
    UIViewController *ctrl = [[class alloc]init];
    ctrl.title = cellTitle;
    if([cellTitle isEqualToString:@"仿QQ侧滑"]) {
        MainPageViewController *mainVC = [[MainPageViewController alloc] init];
        UINavigationController *navMainVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
        LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
        LeftSlideViewController *leftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:navMainVC];
        KCurrentWindow.rootViewController = leftSlideVC;
    }else if ([cellTitle isEqualToString:@"表格视图"]){
        FXFormsVCtrl *vctrl = [[FXFormsVCtrl alloc]initWithNibName:@"FXFormsVCtrl" bundle:nil];
        [self.navigationController pushViewController:vctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"MJRefresh"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MJRefresh" bundle:nil];
        UITabBarController *tabBarCtrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MJExampleViewController"];
        [self.navigationController pushViewController:tabBarCtrl animated:YES];
    }else if ([cellTitle isEqualToString:@"MTAnimation"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MTViewController" bundle:nil];
        UITabBarController *tabBarCtrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"tabBarCtrl"];
        [self.navigationController pushViewController:tabBarCtrl animated:YES];
    }else if ([cellTitle isEqualToString:@"TGCamera自定义相机"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"TGMain" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TGInitialViewController"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"TSMessage"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"TSMessageMain_iPhone" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TSDemoViewController"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"WYPopoverDemo"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"WYDemoStoryboard" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"WYAllDirectionsViewController"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"WYPopoverDemoSegue"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"WYDemoSegueMainStoryboard" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"tabCtrl"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"XLForm"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"XLFromiPhoneStoryboard" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ExamplesFormViewController"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"ZSSRichTextEditor"]){
        ctrl = [[ZSSDemoList alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
        self.navigationController.navigationBar.translucent = NO;
        ctrl.view.backgroundColor = [UIColor whiteColor];
    }else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
