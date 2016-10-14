//
//  ViewController.m
//  7外观模式
//
//  Created by yifan on 15/8/13.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "FacadeVCtrl2.h"
#import "HCDFound.h"
@interface FacadeVCtrl2 ()

@end

@implementation FacadeVCtrl2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    HCDFound *found = [[HCDFound alloc]init];
    [found buyFund];
    [found sellFund];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
