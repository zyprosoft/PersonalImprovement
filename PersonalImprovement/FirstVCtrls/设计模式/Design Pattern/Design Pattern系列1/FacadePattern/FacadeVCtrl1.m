//
//  ViewController.m
//  FacadePattern
//
//  Created by YouXianMing on 15/7/28.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "FacadeVCtrl1.h"
#import "ShapeMaker.h"

@interface FacadeVCtrl1 ()

@end

@implementation FacadeVCtrl1

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [ShapeMaker drawCircleAndRectangle];
    [ShapeMaker drawCircleAndSquare];
    [ShapeMaker drawAll];
}

@end
