//
//  AppTool.m
//  ShopApp
//
//  Created by xiong有都 on 15/11/4.
//  Copyright © 2015年 xiong有都. All rights reserved.
//

#import "AppTool.h"

@implementation AppTool

// 根据图片生成按钮
+ (UIButton *)getBtnImageN:(NSString *)imageN target:(id)target action:(SEL)selector {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:imageN] forState:UIControlStateNormal];
    [leftBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    return leftBtn;
}

/**
 *  生成导航栏右侧的操作按钮(按钮一般为两个字正好符合下面指定的尺寸)
 *
 *  @param title    按钮内容
 *  @param target   按钮的代理对象
 *  @param selector 按钮执行的方法
 *
 *  @return 返回生成的对象
 */
+ (UIButton *)getNaviBarBtn:(NSString *)title target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft {
    return [self getNaviBarBtn:title target:target action:selector frame:CGRectMake(0, 0, 48, 34) isLeft:isLeft];
}

/**
 *  生成标题式导航栏按钮
 *
 *  @param title    标题
 *  @param target   点击事件的处理者
 *  @param selector 点击后调用方法
 *  @param frame    尺寸
 *
 *  @return 返回按钮
 */
+ (UIButton *)getNaviBarBtn:(NSString *)title target:(id)target action:(SEL)selector frame:(CGRect)frame isLeft:(BOOL)isLeft {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, isLeft ? -5: 0, 0, isLeft ? 0: -5)];
    btn.frame = frame;
    return btn;
}

// 生成图片式样的导航栏按钮
+ (UIButton *)getNavigationBtnImage:(UIImage *)btnImage target:(id)target action:(SEL)selector frame:(CGRect)frame {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    btn.frame = frame;
    return btn;
}


+ (UIButton *)getBackBtnImageN:(NSString *)imageN target:(id)target action:(SEL)selector {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:imageN] forState:UIControlStateNormal];
    [leftBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    return leftBtn;
}


@end
