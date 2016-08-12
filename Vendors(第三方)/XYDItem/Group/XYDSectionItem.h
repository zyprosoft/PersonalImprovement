//
//  AddTaskGroupItem.h
//  taskMangered
//
//  Created by xiongyoudou on 15/5/24.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYDSectionItem : NSObject

/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *headerStr;
/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footerStr;
/**
 *  存放着这组所有行的模型数据(这个数组中都是MJSettingItem对象)
 */
@property (nonatomic, copy) NSArray *itemsArr;

- (id)initWithItemArr:(NSArray *)items;
+ (id)objectWithItemArr:(NSArray *)items;

@end
