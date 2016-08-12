//
//  XYDTagV.h
//  TestTagV
//
//  Created by xiong有都 on 16/3/9.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagViewProperty.h"
#define tagDefine 1000

typedef void (^ClickTagBlock)(NSInteger clickTag);

@interface XYDTagV : UIView

@property (copy,nonatomic)NSString *tagStr;
@property (strong,nonatomic)TagViewProperty *tagVProperty;

@property (copy,nonatomic)ClickTagBlock clickTagBlock;

+ (XYDTagV *)tagVWithTagStr:(NSString *)str;
- (XYDTagV *)initWithTagStr:(NSString *)str;

- (CGFloat)tagVWidth;
- (CGFloat)tagVHeight;

@end
