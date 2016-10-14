//
//  HCDAccessFactory.m
//  10抽象工厂模式
//
//  Created by yifan on 15/8/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDAccessFactory.h"
#import "HCDAccessDepartment.h"
#import "HCDAccessUser.h"
@implementation HCDAccessFactory

// 实现抽象类（此处为协议）中的方法，并返回“具体的产品”对象
+(id<HCDUser>)createUser{
    return [[HCDAccessUser alloc]init];
}
+(id<HCDDepartment>)createDepartment{
    return [[HCDAccessDepartment alloc]init];
}
@end
