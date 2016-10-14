//
//  HCDfactory.h
//  5工厂方法模式
//
//  Created by yifan on 15/8/12.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCDCalculate.h"

// 工厂方法模式提供一个抽象工厂接口来声明抽象工厂方法，而由其子类来具体实现工厂方法，创建具体的产品对象
@interface HCDfactory : NSObject
+(id<HCDCalculate>)createFactory;
@end
