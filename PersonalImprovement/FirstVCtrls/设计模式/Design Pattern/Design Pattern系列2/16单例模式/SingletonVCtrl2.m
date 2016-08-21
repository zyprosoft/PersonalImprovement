//
//  ViewController.m
//  5工厂方法模式
//
//  Created by yifan on 15/8/12.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "SingletonVCtrl2.h"
#import "HCDCalculate.h"
#import "HCDfactory.h"
#import "HCDCalculateAdd.h"
#import "HCDfactoryAdd.h"
@interface SingletonVCtrl2 ()

@end

@implementation SingletonVCtrl2

- (void)viewDidLoad {
    [super viewDidLoad];
    HCDfactory *factory = [[HCDfactoryAdd alloc]init];
    HCDfactory  *calculate = [factory createFactory];
    calculate.numberA = 10;
    calculate.numberB = 15;
    NSLog(@"结果是%f",[calculate calculate]);
    
    
    
}


@end
