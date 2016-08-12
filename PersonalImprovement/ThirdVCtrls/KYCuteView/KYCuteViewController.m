//
//  ViewController.m
//  KYCuteViewDemo
//
//  Created by Kitten Yang on 2/26/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "KYCuteViewController.h"
#import "KYCuteView.h"

@implementation KYCuteViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    KYCuteView *cuteView = [[KYCuteView alloc]initWithPoint:CGPointMake(35, [UIScreen mainScreen].bounds.size.height - 100) superView:self.view];
    cuteView.viscosity  = 20;
    cuteView.bubbleWidth = 30;
    cuteView.bubbleColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
    [cuteView setUp];
    [cuteView addGesture];
    
    //注意：设置 'bubbleLabel.text' 一定要放在 '-setUp' 方法之后
    //Tips:When you set the 'bubbleLabel.text',you must set it after '-setUp'
    cuteView.bubbleLabel.text = @"13";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
