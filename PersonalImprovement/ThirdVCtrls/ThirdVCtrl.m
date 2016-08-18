//
//  ThirdVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/3.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "ThirdVCtrl.h"
#import "AMWaveViewController.h"
#import "AwesomeMenuVCtrl.h"
#import "BLKFlexibleHeightBarVCtrl.h"
#import "MyTool.h"
#import "DAkeyboardViewController.h"
#import "IFTTTJazzHandsViewController.h"
#import "KYCuteViewController.h"
#import "KYGoeyViewController.h"
#import "SampleViewController.h"
#import "MarqueeLabelDemoViewController.h"
#import "NJKWebViewCtrl.h"
#import "AnimationsListViewController.h"
#import "PQFRootViewController.h"
#import "RBBAnimationListViewController.h"
#import "REMenuHomeViewController.h"
#import "REMenuNavigationViewController.h"
#import "SevenSwitchViewController.h"
#import "FBShimmeringViewController.h"
#import "YLViewController.h"

@interface ThirdVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThirdVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.view setBackgroundColor:[UIColor colorWithRed:0.912 green:0.425 blue:0.029 alpha:1.000]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.912 green:0.425 blue:0.029 alpha:1.000]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    
    self.title = @"动画效果";
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"波形动画切换" class:@"AMWaveViewController"];
    [self addCell:@"放射弹出" class:@"AwesomeMenuVCtrl"];
    [self addCell:@"伸缩式headerBar" class:@"BLKFlexibleHeightBarVCtrl"];
    [self addCell:@"滑动控制回复框" class:@"DAkeyboardViewController"];
    [self addCell:@"JazzHands启动图片动画" class:@"IFTTTJazzHandsViewController"];
    [self addCell:@"类似QQ拖拽小球" class:@"KYCuteViewController"];
    [self addCell:@"冻冻球效果" class:@"KYGoeyViewController"];
    [self addCell:@"M13progressSuit进度套件" class:@"水水水水"];
    [self addCell:@"MarqueeLabel滚动视图" class:@"水水水水"];
    [self addCell:@"MRProgress进度条" class:@"水水水水"];
    [self addCell:@"MZFormSheetForm" class:@"水水水水"];
    [self addCell:@"NJKWebProgress进度条" class:@"NJKWebViewCtrl"];
    [self addCell:@"Pop动画效果" class:@"AnimationsListViewController"];
    [self addCell:@"PQFRootLoader" class:@"PQFRootViewController"];
    [self addCell:@"PQFInspectable" class:@"ss"];
    [self addCell:@"RBBAnimation" class:@"RBBAnimationListViewController"];
    [self addCell:@"REMenu" class:@"REMenuHomeViewController"];
    [self addCell:@"SevenSwithc" class:@"SevenSwitchViewController"];
    [self addCell:@"ShapeKit" class:@"aaa"];
    [self addCell:@"FBShimmering" class:@"FBShimmeringViewController"];
    [self addCell:@"SWTableViewCell" class:@"222"];
    [self addCell:@"THSpringFlowLayout" class:@"THSpringViewController"];
    [self addCell:@"YLProgressBar" class:@"YLViewController"];
    [MyTool hideExtraTableviewSeparatedLine:_tableView];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titleArray addObject:title];
    [self.classArray addObject:className];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = self.titleArray[indexPath.row];
    NSString *classStr = self.classArray[indexPath.row];
    Class class = NSClassFromString(classStr);
    UIViewController *ctrl = [[class alloc]init];
    ctrl.title = cellTitle;
    if ([cellTitle isEqualToString:@"M13progressSuit进度套件"]) {
        //将我们的storyBoard实例化，“SystemServiceMainStoryboard”为StoryBoard的名称
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"M13ProgressSuite" bundle:nil];
        //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
        UITabBarController *tabBarCtrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SampleViewController"];
        //跳转事件
        [self.navigationController pushViewController:tabBarCtrl animated:YES];
    }else if ([cellTitle isEqualToString:@"MarqueeLabel滚动视图"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MarqueeLabel" bundle:nil];
        UITabBarController *tabBarCtrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"tabBarCtrl"];
        [self.navigationController pushViewController:tabBarCtrl animated:YES];
    }else if ([cellTitle isEqualToString:@"MRProgress进度条"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MRProgress" bundle:nil];
        UITabBarController *tabBarCtrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"tabBarCtrl"];
        [self.navigationController pushViewController:tabBarCtrl animated:YES];
    }else if ([cellTitle isEqualToString:@"MZFormSheetForm"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MZFormSheetController" bundle:nil];
        UIViewController *vctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MZViewController"];
        [self.navigationController pushViewController:vctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"PQFRootLoader"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"PQFMain" bundle:nil];
        UIViewController *vctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"PQFRootViewController"];
        [self.navigationController pushViewController:vctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"PQFInspectable"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"PQFMain1" bundle:nil];
        UIViewController *vctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"PQFViewController1"];
        [self.navigationController pushViewController:vctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"REMenu"]){
        REMenuNavigationViewController *navCtrl = [[REMenuNavigationViewController alloc]initWithRootViewController:ctrl];
        KCurrentWindow.rootViewController = navCtrl;
//        [self.navigationController pushViewController:navCtrl animated:YES];
    }else if ([cellTitle isEqualToString:@"ShapeKit"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"ShapesExample" bundle:nil];
        UIViewController *vctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"rootVCtrl"];
        [self.navigationController pushViewController:vctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"SWTableViewCell"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"SWMainStoryboard" bundle:nil];
        UIViewController *vctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"rootVCtrl"];
        [self.navigationController pushViewController:vctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"THSpringFlowLayout"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"THSpringViewController" bundle:nil];
        UIViewController *vctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"THSpringViewController"];
        [self.navigationController pushViewController:vctrl animated:YES];
    }else if ([cellTitle isEqualToString:@"YLProgressBar"]){
        ctrl = [[YLViewController alloc] initWithNibName:@"YLViewController_iPhone" bundle:nil];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
