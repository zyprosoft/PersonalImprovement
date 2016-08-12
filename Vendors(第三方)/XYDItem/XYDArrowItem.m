//
//  AddTaskArrowItem.m
//  taskMangered
//
//  Created by xiongyoudou on 15/5/24.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "XYDArrowItem.h"

@implementation XYDArrowItem

+ (instancetype)itemWithTitle:(NSString *)title rightInfo:(NSString *)infoText pushingClass:(Class)pushingClass{
    XYDArrowItem *item = [self itemWithTitle:title];
    item.pushingClass = pushingClass;
    item.rightInfoText = infoText;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title rightInfo:(NSString *)infoText  showArrow:(BOOL)isShow pushingClass:(Class)pushingClass {
    XYDArrowItem *item = [self itemWithTitle:title rightInfo:infoText pushingClass:pushingClass];
    item.isShowArrow = isShow;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title rightInfo:(NSString *)infoText clickCellBlock:(AfterClickCellBlock)block{
    XYDArrowItem *item = [self itemWithTitle:title];
    item.pushingClass = nil;
    item.rightInfoText = infoText;
    item.afterClickCellBlock = block;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title rightInfo:(NSString *)infoText showArrow:(BOOL)isShow  clickCellBlock:(AfterClickCellBlock)block{
    XYDArrowItem *item = [self itemWithTitle:title rightInfo:infoText clickCellBlock:block];
    item.isShowArrow = isShow;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title rightImage:(UIImage *)rightImage clickCellBlock:(AfterClickCellBlock)block{
    XYDArrowItem *item = [self itemWithTitle:title];
    item.pushingClass = nil;
    item.rightImage = rightImage;
    item.afterClickCellBlock = block;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title rightImage:(UIImage *)rightImage showArrow:(BOOL)isShow clickCellBlock:(AfterClickCellBlock)block {
    XYDArrowItem *item = [self itemWithTitle:title rightImage:rightImage clickCellBlock:block];
    item.isShowArrow = isShow;
    return item;
}

@end
