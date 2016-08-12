//
//  SwitchButtonBar.m
//  自我提高大杂烩
//
//  Created by iMac on 14-10-31.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#define TagDefine 1000

#import "SwitchButtonBar.h"
#import "CancelInContentScrollV.h"
@interface SwitchButtonBar()<UIScrollViewDelegate>
{
    NSInteger CellNum;
    
    BOOL NotShowRootScroll;//是否显示下面整个的控制器滚动视图
    BOOL isShowTopTotalLine;//是否显示顶部整个的一条线
    BOOL isShowBottonTotalLine;//是否显示底部整个的一条线
    BOOL isShowingBottonLine;//是否显示底部移动的线条
    BOOL isShowingSeparatedLine;//是否显示两个按钮之间的分割线
    
    float separatedLineWidth;//如果有分割线，设置宽度，默认是1
    float separatedLineHeight;
    float bottonLineHeight;//如果底部有移动线条，设置高度，默认是2
    float bottomTotalLineHeight;//默认是1
    float bottomLineWidth;
    
    float buttonCellWidth;
    float buttonCellHeight;
    
    UIColor *separatedLineColor;
    UIColor *bottomLineColor;
    
    NSInteger pressTag;//记录上一次点击的按钮的标识符
    
    UIScrollView *topScrollView;//顶部的标题滚动视图
    UIView *bottomLine;
    CancelInContentScrollV *rootScrollView;//存放显示的所有视图控制器的视图
    
    CGFloat topScrollViewHeight;
}
@end

@implementation SwitchButtonBar

-(id)initWithFrame:(CGRect)frame andTopScrollHeight:(CGFloat)height
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //默认显示
        isShowBottonTotalLine = YES;
        isShowingBottonLine = YES;
        
        bottomTotalLineHeight = 1.0f;
        separatedLineWidth = 1.0f;
        separatedLineWidth = 1.0f;
        
        bottomLineWidth = -1.0;
        separatedLineHeight = 20;
        pressTag = -1;
        topScrollViewHeight = height;
        
        //设置默认属性
        self.backgroundColor = [UIColor clearColor];
        topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, topScrollViewHeight)];
        topScrollView.pagingEnabled = NO;
        topScrollView.showsHorizontalScrollIndicator = NO;
        topScrollView.showsVerticalScrollIndicator = NO;
        topScrollView.scrollsToTop = NO;
        topScrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topScrollView];
        
        if (!NotShowRootScroll)
        {
            //创建主滚动视图
            rootScrollView = [[CancelInContentScrollV alloc] initWithFrame:CGRectMake(0, topScrollViewHeight, self.bounds.size.width, self.bounds.size.height - topScrollViewHeight)];
            rootScrollView.backgroundColor = [UIColor clearColor];
            rootScrollView.delegate = self;
            rootScrollView.pagingEnabled = YES;//控制是否整页翻动
            rootScrollView.scrollEnabled = YES;
            rootScrollView.userInteractionEnabled = YES;
            rootScrollView.bounces = NO;
            rootScrollView.showsHorizontalScrollIndicator = NO;
            rootScrollView.showsVerticalScrollIndicator = NO;
            [self addSubview:rootScrollView];
        }
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andTopScrollHeight:(CGFloat)height notShowRootScroll:(BOOL)notShow
{
    NotShowRootScroll = notShow;
    self = [self initWithFrame:frame andTopScrollHeight:height];
    return self;
}

-(UIScrollView *)topScrollView
{
    return topScrollView;
}

-(void)setRootScrollCanScroll:(BOOL)canScroll
{
    rootScrollView.scrollEnabled = canScroll;
}

-(void)setIsShowTopTotalLine:(BOOL)isShow
{
    isShowTopTotalLine = isShow;
    if(isShow)
    {
        bottomTotalLineHeight = 1.0f;
    }
    else
    {
        bottomTotalLineHeight = 0.0f;
    }
}

-(void)setIsShowBottonTotalLine:(BOOL)isShow
{
    isShowBottonTotalLine = isShow;
    if(isShow)
    {
        bottomTotalLineHeight = 1.0f;
    }
    else
    {
        bottomTotalLineHeight = 0.0f;
    }
}

-(void)setIsShowingBottonLine:(BOOL)isShow
{
    isShowingBottonLine = isShow;
    if(isShow)
    {
        bottonLineHeight = 2.0f;
    }
    else
    {
        bottonLineHeight = 0.0f;
    }
}

-(void)setIsShowingSeparatedLine:(BOOL)isShow
{
    isShowingSeparatedLine = isShow;
    if (isShow)
    {
        separatedLineWidth = 1.0f;
    }
    else
    {
        separatedLineWidth = 0.0f;
    }
}

-(void)setSeparatedLineWidth:(float)width
{
    separatedLineWidth = width;
}

-(void)setBottomLineHeight:(float)height
{
    bottonLineHeight = height;
}

-(void)setBottomLineWidth:(CGFloat)width
{
    bottomLineWidth = width;
}

-(void)setSeparatedLineColor:(UIColor *)color
{
    separatedLineColor = color;
}

-(void)setBottomLineColor:(UIColor *)color
{
    bottomLineColor = color;
}


-(void)initButtons
{
    if (isShowBottonTotalLine)
    {
        UIView *bottomTotalLine = [[UIView alloc]initWithFrame:CGRectMake(0, topScrollView.bounds.size.height - bottomTotalLineHeight, topScrollView.bounds.size.width, bottomTotalLineHeight)];
        bottomTotalLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        [topScrollView addSubview:bottomTotalLine];
    }
    
    if (isShowTopTotalLine)
    {
        UIView *topTotalLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, topScrollView.bounds.size.width, bottomTotalLineHeight)];
        topTotalLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        [topScrollView addSubview:topTotalLine];
    }
    
    CellNum = self.buttonBarDataNumBlock();
    buttonCellWidth = (topScrollView.bounds.size.width - (CellNum - 1)*separatedLineWidth) / CellNum;
    if (bottomLineWidth == -1.0)
    {
         bottomLineWidth = buttonCellWidth;
    }
   
    buttonCellHeight = topScrollView.bounds.size.height - bottonLineHeight;    
    for (int i = 0;i < CellNum;i++)
    {
        //添加标题按钮
        UIView *cellView = self.buttonBarCustomCellBlock(i);
        cellView.userInteractionEnabled = YES;
        cellView.tag = TagDefine + i;//避免tag值是0
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapButtonCell:)];
        [cellView addGestureRecognizer:tapGesture];
        cellView.frame = CGRectMake(buttonCellWidth * i + separatedLineWidth * i, 0, buttonCellWidth, buttonCellHeight);
        [topScrollView addSubview:cellView];
        
        if (isShowingSeparatedLine && (i != (CellNum - 1)))
        {
            float originY = (topScrollView.bounds.size.height - separatedLineHeight) / 2;
            UIView *separatedLine = [[UIView alloc]initWithFrame:CGRectMake(cellView.frame.origin.x + cellView.bounds.size.width, originY, separatedLineWidth, separatedLineHeight)];
            [separatedLine setBackgroundColor:separatedLineColor];
            [topScrollView addSubview:separatedLine];
        }
        else
        {
            
        }
        
        if (self.buttonBarViewCtrlBlock || rootScrollView) {
            //添加控制器
            UIViewController *viewCtrl = self.buttonBarViewCtrlBlock(i);
            viewCtrl.view.frame = CGRectOffset(rootScrollView.bounds, i * rootScrollView.bounds.size.width, 0);
            [rootScrollView addSubview:viewCtrl.view];
        }
    }
    if (rootScrollView)
    {
        rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * CellNum, self.bounds.size.height - topScrollViewHeight);
    }
}


-(void)tapButtonCell:(UIGestureRecognizer *)ges
{
    NSInteger tag = ges.view.tag;
    [self tagButtonAtIndex:tag];
}

-(void)tagButtonAtIndex:(NSInteger)tag
{
    if(pressTag == -1)//第一次
    {
        if (isShowingBottonLine)
        {
            float originX = (tag - TagDefine)*buttonCellWidth + (buttonCellWidth - bottomLineWidth) / 2 + (tag - TagDefine - 1)*separatedLineWidth;
            if(self.buttonBarBottomLineBlock)
            {
                bottomLine = self.buttonBarBottomLineBlock();
                bottomLine.frame = CGRectMake(originX, topScrollView.bounds.size.height - bottonLineHeight, bottomLineWidth, bottonLineHeight);
                [topScrollView addSubview:bottomLine];
            }
        }
        else
        {
            
        }
    }
    else
    {
        if(pressTag == tag)
        {
            
        }
        else
        {
            if (isShowingBottonLine)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    float originX = (tag - TagDefine)*buttonCellWidth + (buttonCellWidth - bottomLineWidth) / 2 + (tag - TagDefine - 1)*separatedLineWidth;
                    CGRect rect = bottomLine.frame;
                    rect.origin.x = originX;
                    bottomLine.frame = rect;
                    
                } completion:^(BOOL finished) {
                    
                    if (rootScrollView)
                    {
                        [rootScrollView setContentOffset: CGPointMake(((tag - TagDefine) * self.bounds.size.width), 0) animated:NO];
                    }
                }];
            }
            
        }
    }
    
    pressTag = tag;
    self.buttonBarCellClickBlock(pressTag);
}

//获取第几个按钮视图控件。index从1开始，表明第一个，第二个...
-(UIView *)getCellViewOnIndex:(int)index
{
    UIView *cellView = [topScrollView viewWithTag:TagDefine + (index - 1)];
    return cellView;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isShowingBottonLine)
    {
        CGFloat topScrollOffsetX = (buttonCellWidth * scrollView.contentOffset.x) / self.bounds.size.width;
        CGFloat value = topScrollOffsetX / buttonCellWidth;
        NSInteger cellNum = ceilf(value);//向上取整
        CGFloat margin = cellNum - value;
        if (margin <= 0.5)
        {
            if (self.changeTitleColorBlock)
            {
                self.changeTitleColorBlock(cellNum);
            }
            
        }
        else
        {
            if (self.changeTitleColorBlock)
            {
                self.changeTitleColorBlock(cellNum - 1);
            }
        }
        [UIView animateWithDuration:0.05 animations:^{
            CGRect rect = bottomLine.frame;
            float originX = topScrollOffsetX + (buttonCellWidth - bottomLineWidth) / 2;
            rect.origin.x = originX;
            bottomLine.frame = rect;
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (isShowingBottonLine)
    {
        CGFloat topScrollOffsetX = (buttonCellWidth * scrollView.contentOffset.x) / self.bounds.size.width;
        CGFloat value = topScrollOffsetX / buttonCellWidth;
        NSInteger cellNum = ceilf(value);//向上取整。其实此处得到的值应用已经是整数了
        pressTag = cellNum + TagDefine;
        self.buttonBarCellClickBlock(pressTag);
    }
}


/*
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    return ye
}
 */

@end
