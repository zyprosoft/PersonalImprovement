//
//  Presenter.m
//  cells
//
//  Created by James Tang on 1/6/14.
//  Copyright (c) 2014 James Tang. All rights reserved.
//

#import "Presenter.h"

@implementation Presenter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hidden = YES;
}

- (void)setModel:(id)model{
    _model = model;
    
    // 该方法由子类重载，子类利用model进行各自界面控制的赋值
    [self reloadData];
}

- (void)reloadData{
    NSAssert(NO, @"This is an abstract method and should be overridden");
}

@end
