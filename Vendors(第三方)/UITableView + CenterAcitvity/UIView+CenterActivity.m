//
//  UITableView+CenterActivity.m
//  taskMangered
//
//  Created by xiongyoudou on 15/8/14.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "UIView+CenterActivity.h"

@implementation UIView (CenterActivity)

- (void)showCenterActivity {
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[self viewWithTag:9999];
    if (!activity){
        activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.tag = 9999;
         [self addSubview:activity];
        //属性为NO则应用了autolayout
        if (self.translatesAutoresizingMaskIntoConstraints) {
            activity.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
        } else {
            [activity mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self);
            }];
        }
    }
    [activity startAnimating];
}

-(void)removeCentreActivityOnView{
    UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[self viewWithTag:9999];
    if (activity){
        [activity stopAnimating];
        [activity removeFromSuperview];
        activity = nil;
    }
}

@end
