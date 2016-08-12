//
//  AddTaskSwitchItem.m
//  taskMangered
//
//  Created by xiongyoudou on 15/5/24.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "XYDSwitchItem.h"

@implementation XYDSwitchItem

+ (instancetype)itemWithTitle:(NSString *)title state:(BOOL)state
{
    XYDSwitchItem *item = [self itemWithTitle:title];
    item.isOn = state;
    return item;
}


@end
