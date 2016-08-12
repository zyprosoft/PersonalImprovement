//
//  XYDTagContainerV.m
//  TestTagV
//
//  Created by xiong有都 on 16/3/9.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "XYDTagContainerV.h"

@interface XYDTagContainerV () {
    NSMutableArray *_strArr;
    NSInteger rowNums;
}

@end

@implementation XYDTagContainerV

+ (XYDTagContainerV *)tagContainerVWithStrArr:(NSArray *)strArr {
    return [[XYDTagContainerV alloc]initWithStrArr:strArr];
}

- (XYDTagContainerV *)initWithStrArr:(NSArray *)strArr {
    self.userInteractionEnabled = NO;
    rowNums = 0;
    _strArr = [NSMutableArray arrayWithArray:strArr];
    
    CGFloat maxWidth = self.bounds.size.width;  // 视图的宽度
    CGFloat totalWidth = 0;                     // 一行上所有视图的宽度和
    BOOL isFirstRow = YES;      // 是否是第一行
    BOOL isFirstColumn = YES;   // 是否是第一列
    UIView *lastRowView = self;
    UIView *lastColumnView = self;
    
    for (int i = 0;i < strArr.count;i ++) {
        NSString *tagStr = strArr[i];
        XYDTagV *tagV = [[XYDTagV alloc]initWithFrame:CGRectZero];
        __weak __typeof(self)weakSelf = self;
        tagV.clickTagBlock = ^(NSInteger tag) {
            if (weakSelf.clickTagBlock)weakSelf.clickTagBlock(tag);
        };
        tagV = [tagV initWithTagStr:tagStr];
        if (_tagVProperty) {
            tagV.tagVProperty = _tagVProperty;
        }
        tagV.tag = tagDefine + i;
        [self addSubview:tagV];
        
        CGFloat tagVWidth = [tagV tagVWidth];
        if (tagVWidth > maxWidth - _tagVSpacing * 2) {
            tagVWidth = maxWidth - _tagVSpacing * 2;
        }
        
        //autolayout进行布局
         
        // 不需换行
        if (totalWidth + _tagVSpacing + tagVWidth <= maxWidth) {
            // 说明很可能是单个person已经超过最大宽度了
            if (tagVWidth == maxWidth - _tagVSpacing * 2) {
                [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@(maxWidth - _tagVSpacing * 2));
                }];
            }else {
                [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@(tagVWidth));
                }];
            }
            isFirstColumn = (totalWidth == 0) ? YES : NO;
            totalWidth = totalWidth + _tagVSpacing + tagVWidth;
        }else {
            [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(tagVWidth));
            }];
            totalWidth = _tagVSpacing + tagVWidth;
            isFirstColumn = YES;
            isFirstRow = NO;
            lastRowView = lastColumnView;
            lastColumnView = self;
            rowNums ++;
        }
        [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_tagVProperty.tagVHeight + + _tagVProperty.edgeInsets.top + _tagVProperty.edgeInsets.bottom));
        }];

        if (isFirstRow) {
            [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(_edgeInsets.top));
            }];
        }else {
            [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastRowView.mas_bottom).offset(_lingSpacing);
            }];
        }
        if (isFirstColumn) {
            if(_isAlignRight) {
                [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-self.width);
                }];
            }else {
                [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(_edgeInsets.left);
                }];
            }
        }else {
            if(_isAlignRight) {
                [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastColumnView.mas_left).offset(-(_tagVSpacing + tagVWidth));
                }];
            }else {
                [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastColumnView.mas_right).offset(-(_tagVSpacing));
                }];
            }
        }
        
        //frame布局
        /*
        CGFloat resultWidth;
        CGFloat resultHeight;
        CGFloat resultOriginX;
        CGFloat resultOriginY;
        if (totalWidth + _tagVSpacing + tagVWidth <= maxWidth) {
            if (tagVWidth == maxWidth - _tagVSpacing * 2) {
                resultWidth = maxWidth - _tagVSpacing * 2;
            }else {
                resultWidth = tagVWidth;
            }
            isFirstColumn = (totalWidth == 0) ? YES : NO;
            totalWidth = totalWidth + _tagVSpacing + tagVWidth;
        }else {
            resultWidth = tagVWidth;
            totalWidth = _tagVSpacing + tagVWidth;
            isFirstColumn = YES;
            isFirstRow = NO;
            lastRowView = lastColumnView;
            lastColumnView = self;
            rowNums ++;
        }
        resultHeight = _tagVProperty.tagVHeight + + _tagVProperty.edgeInsets.top + _tagVProperty.edgeInsets.bottom;
        
        if (isFirstRow) {
            resultOriginY = _edgeInsets.top;
        }else {
            resultOriginY = CGRectGetMaxY(lastRowView.frame) + _lingSpacing;
        }
        if (isFirstColumn) {
            if(_isAlignRight) {
                resultOriginX = self.width - _tagVProperty.edgeInsets.right - tagVWidth ;
            }else {
                resultOriginX = _edgeInsets.left;
            }
        }else {
            if(_isAlignRight) {
                resultOriginX = CGRectGetMinX(lastColumnView.frame) - (_tagVSpacing + tagVWidth);
            }else {
                resultOriginX = CGRectGetMaxX(lastColumnView.frame) + _tagVSpacing;
            }
        }
        tagV.frame = CGRectMake(resultOriginX, resultOriginY, resultWidth, resultHeight);
         */
         
        lastColumnView = tagV;
    }
    return self;
}

- (CGSize)getContentSize {
    return CGSizeMake(self.bounds.size.width, [self getContentSizeHeight]);
}

- (CGFloat)getContentSizeHeight {
    return (rowNums + 1) * ([_tagVProperty tagVHeight] + _tagVProperty.edgeInsets.top + _tagVProperty.edgeInsets.bottom) + rowNums * _lingSpacing + _edgeInsets.top + _edgeInsets.bottom;
}

- (void)setFrameSizeToContentSize {
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y, self.bounds.size.width,[self getContentSizeHeight]) ;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for (long i =self.subviews.count - 1;i> -1;i--)//反向遍历，因为主要在最上层
    {
        UIView *subview = self.subviews[i];
        BOOL contains = CGRectContainsPoint(subview.frame, point);
        if(subview.hidden){
            contains = NO;
        }
        if (contains && [subview isKindOfClass:[XYDTagV class]]){
            CGPoint hitPoint = [subview convertPoint:point fromView:self];
            return [subview hitTest:hitPoint withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
