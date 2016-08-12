//
//  SwitchButtonBar.h
//  自我提高大杂烩
//
//  Created by iMac on 14-10-31.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

//完全仿照UITableView的逻辑来写
typedef NSInteger (^ButtonBarDataNumBlock)(void);//共有子buttonCell的个数，并返回
typedef UIView* (^ButtonBarCustomCellBlock)(NSInteger num);//子buttonCell的UI显示
typedef UIView* (^ButtonBarBottomLineBlock)();//底部移动线的UI显示
typedef void (^ButtonBarCellClickBlock)(NSInteger clickNum);//点击cell的触发事件

typedef UIViewController* (^ButtonBarViewCtrlBlock)(NSInteger num);//控制器的显示
typedef void (^ChangeTitleColorBlock)(NSInteger num);//修改序号为num的标题控件的颜色为选中状态，其余为未选中

@interface SwitchButtonBar : UIView
{
   
}

@property (copy,nonatomic)ButtonBarDataNumBlock buttonBarDataNumBlock;
@property (copy,nonatomic)ButtonBarCustomCellBlock buttonBarCustomCellBlock;
@property (copy,nonatomic)ButtonBarBottomLineBlock buttonBarBottomLineBlock;
@property (copy,nonatomic)ButtonBarCellClickBlock buttonBarCellClickBlock;
@property (copy,nonatomic)ButtonBarViewCtrlBlock buttonBarViewCtrlBlock;
@property (copy,nonatomic)ChangeTitleColorBlock changeTitleColorBlock;

-(id)initWithFrame:(CGRect)frame andTopScrollHeight:(CGFloat)height;
-(id)initWithFrame:(CGRect)frame andTopScrollHeight:(CGFloat)height notShowRootScroll:(BOOL)notShow;
-(UIScrollView *)topScrollView;
-(void)setRootScrollCanScroll:(BOOL)canScroll;
-(void)setIsShowTopTotalLine:(BOOL)isShow;
-(void)setIsShowBottonTotalLine:(BOOL)isShow;//是否在底部显示完整的一根从头到尾的线
-(void)setIsShowingBottonLine:(BOOL)isShow;
-(void)setIsShowingSeparatedLine:(BOOL)isShow;
-(void)setSeparatedLineWidth:(float)width;
-(void)setBottomLineHeight:(float)height;
-(void)setBottomLineWidth:(CGFloat)width;
-(void)setSeparatedLineColor:(UIColor *)color;
-(void)setBottomLineColor:(UIColor *)color;
-(void)initButtons;
-(void)tagButtonAtIndex:(NSInteger)tag;
-(UIView *)getCellViewOnIndex:(int)index;

@end
