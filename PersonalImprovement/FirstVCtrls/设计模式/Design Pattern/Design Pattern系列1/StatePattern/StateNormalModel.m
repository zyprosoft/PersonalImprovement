//
//  NormalModel.m
//  StatePattern
//
//  Created by YouXianMing on 15/4/19.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "StateNormalModel.h"

@implementation StateNormalModel

- (void)requestState:(StateType *)type {
    
    [type handleData:self];
}

@end
