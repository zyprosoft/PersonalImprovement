//
//  UITableView+CenterLabel.m
//  taskMangered
//
//  Created by xiongyoudou on 15/7/28.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "UIView+CenterLabel.h"

@implementation UIView (CenterLabel)

-(void)showCenterLabelOnView{
    [self showCenterLabelOnTabelWithStr:@"无记录"];
}

-(void)showCenterLabelOnTabelWithStr:(NSString *)str{
    [self showCenterLabelOnViewWithStr:str andIsOn:NO];
}

-(void)showCenterLabelOnViewWithStr:(NSString *)str andIsOn:(BOOL)isOn{
    UILabel *centerLabel = (UILabel *)[self viewWithTag:999];
    if (!centerLabel){
        centerLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        centerLabel.tag = 999;
        centerLabel.font = [UIFont boldSystemFontOfSize:20];
        centerLabel.textAlignment = NSTextAlignmentCenter;
        centerLabel.textColor = COLOR(193, 193, 193, 1);
        [self addSubview:centerLabel];
    }
    centerLabel.text = str;
    if (isOn){
//        [centerLabel autoCenterInSuperview];
        [centerLabel sizeToFit];
        centerLabel.frame = CGRectMake((self.bounds.size.width - centerLabel.bounds.size.width) / 2, (self.bounds.size.height - centerLabel.bounds.size.height) / 2, centerLabel.bounds.size.width, centerLabel.bounds.size.height);
    }else{
//        [centerLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
//        [centerLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:132+44];
        [centerLabel sizeToFit];
        centerLabel.frame = CGRectMake((self.bounds.size.width - centerLabel.bounds.size.width) / 2, 132+44, centerLabel.bounds.size.width, centerLabel.bounds.size.height);
    }
}

-(void)showCenterLabelOnViewIsOnCenter:(BOOL)isOn{
    if (isOn){
        [self showCenterLabelOnViewWithStr:@"无记录" andIsOn:isOn];
    }
}

-(void)removeCentreLabelOnView{
    UILabel *centerLabel = (UILabel *)[self viewWithTag:999];
    if (centerLabel){
        [centerLabel removeFromSuperview];
        centerLabel = nil;
    }
}

@end
