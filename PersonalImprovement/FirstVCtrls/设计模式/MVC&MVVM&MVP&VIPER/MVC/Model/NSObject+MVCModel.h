//
//  NSObject+Model.h
//  MVCDemo-OC
//
//  Created by xyxxllh on 16/7/27.
//  Copyright © 2016年 XunLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+MVCModel.h"

// 定义协议TTModel
@protocol TTModel <NSObject>

- (BOOL)give:(id<TTView>)view;

@end

// 定义NSObject的类别MVCModel，该类别遵循TTModel协议，实现了协议定义的方法
@interface NSObject (MVCModel) <TTModel>

@end
