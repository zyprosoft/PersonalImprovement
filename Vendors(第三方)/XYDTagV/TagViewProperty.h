//
//  TagViewProperty.h
//  TestTagV
//
//  Created by xiongyoudou on 16/3/10.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TagViewProperty : NSObject

/**
 *  whether tagV have its constant width,adjust to its content when value is 0;
 */
@property (assign,nonatomic)CGFloat tagVWidth;

@property (assign,nonatomic)CGFloat tagVHeight;

@property (strong,nonatomic)UIFont *font;
@property (strong,nonatomic)UIColor *textColor;
@property (strong,nonatomic)UIColor *backgroundColor;
@property (strong,nonatomic)UIColor *borderColor;
@property (assign,nonatomic)CGFloat borderWidth;
@property (assign,nonatomic)CGFloat borderCornerRadius;

@property (strong,nonatomic)UIImage *backgroundImage;
@property (strong,nonatomic)UIImage *highlightedBackgroundImage;

@property (assign,nonatomic)UIEdgeInsets edgeInsets;

@end
