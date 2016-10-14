//
//  ViewController.m
//  10抽象工厂模式
//
//  Created by yifan on 15/8/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "AbstractFactoryVCtrl2.h"
#import "HCDFactory.h"
#import "HCDSqlserverFactory.h"
#import "HCDAccessFactory.h"
#import "HCDDepartment.h"
#import "HCDUser.h"

#import "SQLDepartment.h"
#import "SQLUser.h"
typedef id<HCDFactory> HCDFactory;
typedef id<HCDDepartment> HCDDepartment;
typedef id<HCDUser> HCDUser;
@interface AbstractFactoryVCtrl2 ()

@end

@implementation AbstractFactoryVCtrl2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 简单工厂模式
    // 通过“具体产品的类型”生产具体产品类，生成代码在“工厂类”中
    // cal =[HCDCalcuteFactory createCalcute:self.countTextField.text];
    
    // 工厂模式
    // 通过具体的工厂类生产具体的产品类，生成代码在具体工厂类中
    // id<HCDCalculate> calculate = [HCDfactoryAdd createFactory];
    
    //根据具体的工厂类生产具体的产品类，生成代码在具体工厂类中
    // 与工厂方法模式相比，抽象工厂模式中的具体工厂不只是创建一种产品，它负责创建一族产品
    HCDDepartment department = [HCDSqlserverFactory createDepartment];
    [department insertDepartment:[[SQLDepartment alloc]init]];
    [department getDepartment];
    HCDUser user = [HCDSqlserverFactory createUser];
    [user insertUser:[[SQLUser alloc]init]];
    
    
    HCDDepartment department1 = [HCDAccessFactory createDepartment];
    [department1 insertDepartment:[[SQLDepartment alloc]init]];
    [department1 getDepartment];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
