//
//  NSObject+Model.m
//  MVCDemo-OC
//
//  Created by xyxxllh on 16/7/27.
//  Copyright © 2016年 XunLei. All rights reserved.
//

#import "NSObject+MVCModel.h"

@implementation NSObject (MVCModel)

- (BOOL)give:(id<TTView>)view {
    // view遵循TTView协议，协议中定义了可选方法update
    return [view update:self];
}

@end
