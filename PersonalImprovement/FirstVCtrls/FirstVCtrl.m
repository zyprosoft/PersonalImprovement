//
//  ViewController.m
//  PersonalDevelopment
//
//  Created by xiong有都 on 16/2/3.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "FirstVCtrl.h"
#import "TestThread.h"
#import "DateTool.h"
#import "FileManagerVCtrl.h"
#import "FormatterRootViewController.h"
#import "JKRootViewController.h"
#import "SystemServicesDemoViewController.h"
#import "CodeSnipptesVCtrl.h"
#import "TapkuRootViewController.h"
#import "StructureAndPatternVCtrl.h"

@interface FirstVCtrl ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FirstVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"FirstVCtrlItem:%@",self.tabBarItem);

    self.title = @"功能";
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"TestThread" class:@"TestThread"];
    [self addCell:@"__block and __weak" class:@"TestBlockVCtrl1"];
    [self addCell:@"TestCoreData" class:@"TestCoreDataVCtrl"];
    [self addCell:@"DateTools" class:@"DateToolsVCtrl"];
    [self addCell:@"BFKit" class:@"BFKitVCtrl"];
    [self addCell:@"FCFileManager" class:@"FileManagerVCtrl"];
    [self addCell:@"FormatterKit" class:@"FormatterRootViewController"];
    [self addCell:@"JKCategories" class:@"JKRootViewController"];
    [self addCell:@"SystemService" class:@"SystemServicesDemoViewController"];
    [self addCell:@"CLLocationManager定位" class:@"INTUViewController"];
    [self addCell:@"CodeSnippets代码片段" class:@"CodeSnipptesVCtrl"];
    [self addCell:@"TapkuLibrary" class:@"TapkuRootViewController"];
    [self addCell:@"设计模式" class:@"StructureAndPatternVCtrl"];
    [self addCell:@"CFNetworking网络层架构" class:@"ddd"];
    [self addCell:@"蓝牙第三方库BabyBluetooth" class:@"ddd"];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = self.titleArray[indexPath.row];
    NSString *classStr = self.classArray[indexPath.row];
    Class class = NSClassFromString(classStr);
    UIViewController *ctrl = [[class alloc]init];
    ctrl.title = cellTitle;
    if ([cellTitle isEqualToString:@"SystemService"]) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"SystemServiceMainStoryboard" bundle:nil];
        UITabBarController *tabBarCtrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"tabBar"];
        [self.navigationController pushViewController:tabBarCtrl animated:YES];
    }else if ([cellTitle isEqualToString:@"CFNetworking网络层架构"]){
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"CFNetworking" bundle:nil];
        UIViewController *ctrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TestViewController"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
