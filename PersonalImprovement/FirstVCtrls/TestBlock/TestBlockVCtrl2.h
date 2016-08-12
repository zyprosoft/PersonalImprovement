//
//  TestBlockVCtrl2.h
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/3/15.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <UIKit/UIKit.h>

// block的typedef 用法
typedef void (^Block)();
typedef void (^Block2)(id para);

@interface TestBlockVCtrl2 : UIViewController

@property (copy,nonatomic)Block block1;
@property (copy,nonatomic)Block2 block2;

// block的属性直接定义 用法
@property (copy,nonatomic)int (^block3)(int para);

// block在方法参数中定义的形式
- (void)methodWithBlock:(int (^)(int para))block;
// 此种形式调用
/*
 
 [self methodWithBlock:^int(int para) {
    return para;
 }];
 
 */

// block局部变量定义
/*
 
 int (^block)(int para) = ^int (int para) {
    return para;
 };
 
 */

// 总结，block其实就4中形式
// 1、typedef中定义block类型的形式：typedef void (^Block2)(id para)   Block2为类型
// 2、定义block具体变量形式:        int (^block3)(int para)  block3为变量名
// 3、定义方法中block形参形式：      methodWithBlock:(int (^)(int para))block
// 4、定义方法调用时匿名变量形式：    [self methodWithBlock:^int(int para) {}];


@end
