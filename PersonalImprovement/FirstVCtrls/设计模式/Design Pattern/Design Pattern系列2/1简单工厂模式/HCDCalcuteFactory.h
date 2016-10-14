//
//  HCDCalcuteFactory.h
//  1简单工厂模式
//
//  Created by 黄成都 on 15/8/10.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCDCalculate.h"


@class CommonTool;
@interface HCDCalcuteFactory : NSObject

// 简单工厂模式的要点在于：当你需要什么，只需要传入一个正确的参数，就可以获取你所需要的对象，而无须知道其创建细节
+(id<HCDCalculate>)createCalcute:(NSString *)calculatetype;
@end
