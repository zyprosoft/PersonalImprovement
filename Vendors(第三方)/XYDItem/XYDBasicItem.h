//
//  AddTaskBasicItem.h
//  taskMangered
//
//  Created by xiongyoudou on 15/5/24.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AfterClickCellBlock)();//处理cell的点击事件 但是如果点击cell的操作是界面push，则不在此处理，因为push的处理操作都是一样的，可以统一处理。此处处理的主要是独特的操作，比如点击cell网络请求检测新版本。

@interface XYDBasicItem : NSObject

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
@property (strong,nonatomic)NSNumber *cellHeight;

/**
 *  点击那个cell需要做什么事情
 */
@property (nonatomic, copy) AfterClickCellBlock afterClickCellBlock;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title clickCellBlock:(AfterClickCellBlock)block;

@end
