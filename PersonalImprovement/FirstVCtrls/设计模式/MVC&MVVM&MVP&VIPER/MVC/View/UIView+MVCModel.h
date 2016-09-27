//
//  UIView+Model.h
//  MVCDemo-OC
//
//  Created by xyxxllh on 16/7/27.
//  Copyright © 2016年 XunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTModel;

// 定义TTView协议
@protocol TTView <NSObject>

@optional
- (BOOL)update:(id<TTModel>)model;

@end

// 定义UIView的类别MVCModel，该类别遵循协议TTView
@interface UIView (MVCModel) <TTView>

@end
