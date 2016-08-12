//
//  XYDActionSheetView.m
//  taskMangered
//
//  Created by xiongyoudou on 15/5/21.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import "XYDActionSheetView.h"

@interface XYDActionSheetView ()
{
    UIView *backgroundMask;
    UIView *contentView;
}

@end

@implementation XYDActionSheetView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self initWithBackgroundMask];
        [self initWithContentView];
        self.windowLevel = UIWindowLevelAlert;
    }
    return self;
}

-(void)initWithBackgroundMask
{
    backgroundMask = [[UIView alloc] initWithFrame:self.bounds];
    backgroundMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    backgroundMask.backgroundColor = [UIColor blackColor];
    backgroundMask.alpha = 0;
    [self addSubview:backgroundMask];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [backgroundMask addGestureRecognizer:tap];
}

-(void)initWithContentView
{
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), 0, 0)];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:contentView];
}

static XYDActionSheetView *sheet = nil;

- (void)dismiss
{
    self.afterDismissPushedViewBlock();
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        backgroundMask.alpha = 0;
        [self setContentViewFrameY:CGRectGetHeight(self.bounds)];
    } completion:^(BOOL finished) {
        sheet.hidden = YES;
        sheet = nil;
    }];
}

- (void)setContentViewFrameY:(CGFloat)y
{
    CGRect frame = contentView.frame;
    frame.origin.y = y;
    contentView.frame = frame;
}

- (void)show
{
    sheet = self;
    sheet.hidden = NO;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        backgroundMask.alpha = 0.6;
        [self setContentViewFrameY:CGRectGetHeight(self.bounds) - CGRectGetHeight(contentView.frame)];
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark 设置即将弹出来得视图，添加在contentView上
-(void)setPushedView:(UIView *)pushedView
{
    CGFloat height = pushedView.bounds.size.height;

    [contentView setFrame:CGRectMake(contentView.frame.origin.x,contentView.frame.origin.y, self.bounds.size.width, height)];
    
//    CGFloat margin = 8;
//    CGFloat width = self.frame.size.width - margin*2;
//    UIView *scrollBG = [[UIView alloc] initWithFrame:CGRectMake(margin, 0,width, height)];
//    scrollBG.backgroundColor = [UIColor whiteColor];
//    scrollBG.alpha = 0.9;
//    scrollBG.clipsToBounds = YES;
//    scrollBG.layer.cornerRadius = 5;
//    [contentView addSubview:scrollBG];
    
//    [scrollBG addSubview:pushedView];
//    pushedView.frame = CGRectMake(0, 0, width, height);
    
    pushedView.frame = CGRectMake(0, 0, contentView.bounds.size.width, height);
    [contentView addSubview:pushedView];
}

@end
