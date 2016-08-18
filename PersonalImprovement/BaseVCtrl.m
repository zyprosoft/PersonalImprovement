//
//  BaseVCtrl.m
//  ShopApp
//
//  Created by xiong有都 on 15/11/1.
//  Copyright © 2015年 xiong有都. All rights reserved.
//

#import "BaseVCtrl.h"

@interface BaseVCtrl ()

@end

@implementation BaseVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = [NSMutableArray array];
    _classArray = [NSMutableArray array];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titleArray addObject:title];
    [self.classArray addObject:className];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count != 1){
        [self setBackBtn:NO navBarHidden:NO];
    }
}

- (void)setBackBtn:(BOOL)isHidden navBarHidden:(BOOL)isNavBarHidden {
    self.navigationController.navigationBarHidden = isNavBarHidden;
    if  (!isHidden) {
        UIButton *backBtn = [AppTool getBtnImageN:@"nav_back" target:self action:@selector(clickBackBtn:)];
        backBtn.frame = CGRectMake(0,0,10,44);
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:backBtn]];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)clickBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
