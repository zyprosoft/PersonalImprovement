//
//  AddTaskBasicItem.m
//  taskMangered
//
//  Created by xiongyoudou on 15/5/24.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "XYDBasicItem.h"

@implementation XYDBasicItem

+ (instancetype)itemWithTitle:(NSString *)title
{
    XYDBasicItem *item = [[self alloc] init];
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title clickCellBlock:(AfterClickCellBlock)block
{
    XYDBasicItem *item = [[self alloc] init];
    item.title = title;
    item.afterClickCellBlock = block;
    return item;
}

@end
