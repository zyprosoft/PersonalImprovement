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

@interface FirstVCtrl ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *titleArray;
@property (strong,nonatomic)NSMutableArray *classArray;

@end

@implementation FirstVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"FirstVCtrlItem:%@",self.tabBarItem);

    self.title = @"功能";
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _titleArray= [NSMutableArray array];
    _classArray = [NSMutableArray array];
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
    [self addCell:@"设计模式" class:@"TapkuRootViewController"];
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
    if ([cellTitle isEqualToString:@"SystemService"]) {
        //将我们的storyBoard实例化，“SystemServiceMainStoryboard”为StoryBoard的名称
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"SystemServiceMainStoryboard" bundle:nil];
        
        //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
        UITabBarController *tabBarCtrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"tabBar"];
        
        //跳转事件
        [self.navigationController pushViewController:tabBarCtrl animated:YES];
    }else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
