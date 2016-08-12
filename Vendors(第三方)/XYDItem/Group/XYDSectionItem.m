//
//  AddTaskGroupItem.m
//  taskMangered
//
//  Created by xiongyoudou on 15/5/24.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "XYDSectionItem.h"

@implementation XYDSectionItem

- (id)initWithItemArr:(NSArray *)items {
    self = [super init];
    if (self) {
        if (items) {
            _itemsArr = [NSArray arrayWithArray:items];
        }
    }
    return self;
}

+ (id)objectWithItemArr:(NSArray *)items {
    return [[self alloc]initWithItemArr:items];
}

@end
