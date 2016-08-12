//
//  XYDTagContainerV.h
//  TestTagV
//
//  Created by xiong有都 on 16/3/9.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDTagV.h"

@interface XYDTagContainerV : UIScrollView

@property (assign,nonatomic)BOOL isAlignRight;

/**
 *  spacing between Tag views on a row.
 */
@property (assign,nonatomic)CGFloat tagVSpacing;

/**
 *  spacing between lines
 */
@property (assign,nonatomic)CGFloat lingSpacing;

@property (assign,nonatomic)UIEdgeInsets edgeInsets;

@property (strong,nonatomic)TagViewProperty *tagVProperty;

@property (copy,nonatomic)ClickTagBlock clickTagBlock;

+ (XYDTagContainerV *)tagContainerVWithStrArr:(NSArray *)strArr;
- (XYDTagContainerV *)initWithStrArr:(NSArray *)strArr;
- (CGSize)getContentSize;
- (CGFloat)getContentSizeHeight;
- (void)setFrameSizeToContentSize;

@end
