//
//  HCDFactory.h
//  10抽象工厂模式
//
//  Created by yifan on 15/8/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCDUser.h"
#import "HCDDepartment.h"


// 抽象工厂模式为创建一组对象提供了一种解决方案。与工厂方法模式相比，抽象工厂模式中的具体工厂不只是创建一种产品，它负责创建一族产品
@protocol HCDFactory <NSObject>

// 下面两个方法分别创建两种产品

// 返回的对象是抽象的产品类
// 创建用户
+(id<HCDUser>)createUser;
// 创建公寓
+(id<HCDDepartment>)createDepartment;
@end
