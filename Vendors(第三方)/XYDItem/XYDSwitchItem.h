//
//  AddTaskSwitchItem.h
//  taskMangered
//
//  Created by xiongyoudou on 15/5/24.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "XYDBasicItem.h"

typedef void (^ChangeSwithcStateBlcok) (BOOL state);

@interface XYDSwitchItem : XYDBasicItem

@property (nonatomic, assign) BOOL isOn;

@property (nonatomic, copy) ChangeSwithcStateBlcok changeSwithcStateBlcok;

+ (instancetype)itemWithTitle:(NSString *)title state:(BOOL)state;

@end
