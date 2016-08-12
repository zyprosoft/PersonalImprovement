//
//  UITableView+CenterLabel.h
//  taskMangered
//
//  Created by xiongyoudou on 15/7/28.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CenterLabel)

-(void)showCenterLabelOnViewIsOnCenter:(BOOL)isOn;
-(void)showCenterLabelOnViewWithStr:(NSString *)str andIsOn:(BOOL)isOn;
-(void)showCenterLabelOnTabelWithStr:(NSString *)str;
-(void)showCenterLabelOnScrollV;
-(void)showCenterLabelOnView;

@end
