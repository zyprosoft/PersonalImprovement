//
//  StateTwo.m
//  StatePattern
//
//  Created by YouXianMing on 15/4/19.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "StateTwo.h"
#import "StateNormalModel.h"

@implementation StateTwo

- (void)handleData:(id)data {
    
    StateNormalModel *model = data;
    model.workType     = Android_developer;
    model.age          = @(27);
    model.name         = @"YouXianMing";
}

@end
