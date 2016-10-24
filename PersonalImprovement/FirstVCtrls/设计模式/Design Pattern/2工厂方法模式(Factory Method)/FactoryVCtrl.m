//
//  ViewController.m
//  5工厂方法模式
//
//  Created by yifan on 15/8/12.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "FactoryVCtrl.h"
#import "HCDCalculate.h"
#import "HCDfactory.h"
#import "HCDCalculateAdd.h"
#import "HCDfactoryAdd.h"
@interface FactoryVCtrl ()

@end

@implementation FactoryVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 可见，简单工厂模式与工厂模式区别在于，生成“操作对象”的方式
    // 简单工厂模式：通过在调用方法中传入类型，然后由“工厂对象”调用，“工厂对象”根据类型初始化不同的具体对象，实现代码集中在父类中
    // 工厂模式：首先代码中必须有通过继承“抽象工厂”，实现具体的工厂；具体的工厂中实现“抽象工厂”定义的方法，实现代码在子类中
    
    id<HCDCalculate> calculate = [HCDfactoryAdd createFactory];
    calculate.numberA = 10;
    calculate.numberB = 15;
    NSLog(@"结果是%f",[calculate calculate]);
    
    
    
}


@end
