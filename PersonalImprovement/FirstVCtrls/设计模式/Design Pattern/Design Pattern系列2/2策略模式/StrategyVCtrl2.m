//
//  ViewController.m
//  2策略模式
//
//  Created by 黄成都 on 15/8/11.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "StrategyVCtrl2.h"
#import "HCDCashContext.h"
#import "HCDCashNormal.h"
#import "HCDCashRobate.h"
#import "HCDCaseReturn.h"

@interface StrategyVCtrl2 ()

@end

@implementation StrategyVCtrl2

- (void)viewDidLoad {
    [super viewDidLoad];

    
    HCDCashContext *context = [[HCDCashContext alloc]initWithCashType:CashTypeNormal];
    NSLog(@"结果是%f",[context getResult:100]);

    
    HCDCashContext *contextReturn = [[HCDCashContext alloc]initWithCashType:CashTypeReturn];
    NSLog(@"结果是%f",[contextReturn getResult:100]);
    
    HCDCashContext *contextRobate = [[HCDCashContext alloc]initWithCashType:CashTypeRobate];
    NSLog(@"结果是%f",[contextRobate getResult:100]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
