//
//  ViewController.m
//  StatePattern
//
//  Created by YouXianMing on 15/4/19.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "StateVCtrl1.h"
#import "StateNormalModel.h"

@interface StateVCtrl1 ()

@end

@implementation StateVCtrl1

- (void)viewDidLoad {
    [super viewDidLoad];

    /* 状态模式中的状态都是可以重复赋值让对象恢复某种状态的，并不是一种算法来让对象进入到一种算法之后的结果，与策略模式有差异 */
    
    StateNormalModel *model = [StateNormalModel new];
    
    // 切换到状态1
    [model requestState:[StateOne new]];
    
    // 切换到状态2
    [model requestState:[StateTwo new]];
}

@end
