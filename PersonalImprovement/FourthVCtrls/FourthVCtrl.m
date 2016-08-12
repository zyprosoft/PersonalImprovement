//
//  FourthVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/3.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "FourthVCtrl.h"
#import "MusicListViewController.h"
#import "DemoMessagesViewController.h"
#import "SOLMainViewController.h"

@interface FourthVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *titleArray;
@property (strong,nonatomic)NSMutableArray *classArray;

@end

@implementation FourthVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"FouthVCtrlItem:%@",self.tabBarItem);
    self.navigationController.tabBarItem.badgeValue = @"";
    self.title = @"完整工程";
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _titleArray= [NSMutableArray array];
    _classArray = [NSMutableArray array];
    [self addCell:@"音乐播放器" class:@"MusicListViewController"];
    [self addCell:@"JSQ聊天" class:@"JSQMessage"];
    [self addCell:@"MWPhotoBrowser图片浏览器" class:@"MWPhotoBrowser图片浏览器"];
    [self addCell:@"Sol天气" class:@"SOLMainViewController"];
    [MyTool hideExtraTableviewSeparatedLine:_tableView];
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
    if ([cellTitle isEqualToString:@"JSQ聊天"]) {
        //将我们的storyBoard实例化，“SystemServiceMainStoryboard”为StoryBoard的名称
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"ChatMessage" bundle:nil];
        //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
        UITabBarController *tabBarCtrl = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TableViewController"];
        //跳转事件
        [self.navigationController pushViewController:tabBarCtrl animated:YES];
    }else if ([cellTitle isEqualToString:@"Sol天气"]) {
        self.navigationController.navigationBarHidden = YES;
        ctrl.title = cellTitle;
        ctrl.view.backgroundColor = [UIColor blackColor];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else {
        ctrl.title = cellTitle;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
