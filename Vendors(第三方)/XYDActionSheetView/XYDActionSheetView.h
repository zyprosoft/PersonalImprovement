//
//  XYDActionSheetView.h
//  taskMangered
//
//  Created by xiongyoudou on 15/5/21.
//  Copyright (c) 2015年 JiangHong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AfterDismissPushedViewBlock)();

@interface XYDActionSheetView : UIWindow

@property (copy,nonatomic)AfterDismissPushedViewBlock afterDismissPushedViewBlock;

- (void)show;
- (void)dismiss;
-(void)setPushedView:(UIView *)pushedView;

@end
