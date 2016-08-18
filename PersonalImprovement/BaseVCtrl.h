//
//  BaseVCtrl.h
//  ShopApp
//
//  Created by xiong有都 on 15/11/1.
//  Copyright © 2015年 xiong有都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVCtrl : UIViewController
@property (strong,nonatomic)NSMutableArray *titleArray;
@property (strong,nonatomic)NSMutableArray *classArray;

- (void)setBackBtn:(BOOL)isHidden navBarHidden:(BOOL)isNavBarHidden;
- (void)addCell:(NSString *)title class:(NSString *)className;

@end
