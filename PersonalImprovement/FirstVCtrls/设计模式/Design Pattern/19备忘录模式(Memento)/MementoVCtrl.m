//
//  ViewController.m
//  MementoPattern
//
//  Created by YouXianMing on 15/9/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "MementoVCtrl1.h"
#import "MementoModel.h"
#import "MementoCenter.h"

@interface MementoVCtrl1 ()

@end

@implementation MementoVCtrl1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 初始化model
    MementoModel *model = [[MementoModel alloc] init];
    
    // 获取状态
    id state = [MementoCenter mementoObjectWithKey:@"Model"];
    
    // 恢复状态
    [model recoverFromState:state];
    
    // 打印
    NSLog(@"name:%@  age:%@", model.name, model.age);
    
    // 赋值
    model.name   = @"YouXianMing";
    model.age    = @27;
    
    // 存储状态
    [MementoCenter saveMementoObject:model withKey:@"Model"];
}

@end
