//
//  AddTaskArrowItem.h
//  taskMangered
//
//  Created by xiongyoudou on 15/5/24.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "XYDBasicItem.h"

@interface XYDArrowItem : XYDBasicItem

/**
 *  点击这行cell需要跳转的控制器
 */
@property (nonatomic, assign) Class pushingClass;
@property (assign,nonatomic)BOOL isShowArrow;//是否显示箭头

@property (copy,nonatomic)NSString *rightInfoText;//箭头左边的文本
@property (strong,nonatomic)UIColor *rightInfoColor;//箭头左边的文本颜色

@property (strong,nonatomic)UIImage *rightImage;//右侧图片

+ (instancetype)itemWithTitle:(NSString *)title rightInfo:(NSString *)infoText pushingClass:(Class)pushingClass;
+ (instancetype)itemWithTitle:(NSString *)title rightInfo:(NSString *)infoText  showArrow:(BOOL)isShow pushingClass:(Class)pushingClass;
+ (instancetype)itemWithTitle:(NSString *)title rightInfo:(NSString *)infoText clickCellBlock:(AfterClickCellBlock)block;
+ (instancetype)itemWithTitle:(NSString *)title rightInfo:(NSString *)infoText showArrow:(BOOL)isShow  clickCellBlock:(AfterClickCellBlock)block;
+ (instancetype)itemWithTitle:(NSString *)title rightImage:(UIImage *)rightImage clickCellBlock:(AfterClickCellBlock)block;
+ (instancetype)itemWithTitle:(NSString *)title rightImage:(UIImage *)rightImage showArrow:(BOOL)isShow clickCellBlock:(AfterClickCellBlock)block;

@end
