//
//  XYDTabBarControllerConfig.m
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/27.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "XYDTabBarControllerConfig.h"
#import "FirstVCtrl.h"
#import "SecondVCtrl.h"
#import "ThirdVCtrl.h"
#import "FourthVCtrl.h"
#import "XYDRoundCircularButton.h"
#import "CustomNavigationCtrl.h"

@implementation XYDTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return XYDTabBarController
 */
- (XYDTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        XYDTabBarController *tabBarController = [XYDTabBarController tabBarControllerWithViewControllers:self.viewControllers plusButton:[XYDRoundCircularButton new] tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    FirstVCtrl *vctrl1 = [[FirstVCtrl alloc] initWithNibName:@"FirstVCtrl" bundle:nil];
    SecondVCtrl *vctrl2 = [[SecondVCtrl alloc] initWithNibName:@"SecondVCtrl" bundle:nil];
    ThirdVCtrl *vctrl3 = [[ThirdVCtrl alloc] initWithNibName:@"ThirdVCtrl" bundle:nil];
    FourthVCtrl *vctrl4 = [[FourthVCtrl alloc] initWithNibName:@"FourthVCtrl" bundle:nil];
    
    CustomNavigationCtrl *nav1 = [CustomNavigationCtrl configNavigationCtrlwithRootVC:vctrl1     andImageName:nil OrColor:KNavBarColor];
    CustomNavigationCtrl *nav2 = [CustomNavigationCtrl configNavigationCtrlwithRootVC:vctrl2 andImageName:nil OrColor:KNavBarColor];
    CustomNavigationCtrl *nav3 = [CustomNavigationCtrl configNavigationCtrlwithRootVC:vctrl3 andImageName:nil OrColor:KNavBarColor];
    CustomNavigationCtrl *nav4 = [CustomNavigationCtrl configNavigationCtrlwithRootVC:vctrl4 andImageName:nil OrColor:KNavBarColor];
    
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    //tabBarController.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    //tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    NSArray *viewControllers = @[nav1,nav2,nav3,nav4];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 XYDTabBarItemTitle : @"功能",
                                                 XYDTabBarItemImage : @"home_normal",
                                                 XYDTabBarItemSelectedImage : @"home_highlight",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  XYDTabBarItemTitle : @"功能效果",
                                                  XYDTabBarItemImage : @"mycity_normal",
                                                  XYDTabBarItemSelectedImage : @"mycity_highlight",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 XYDTabBarItemTitle : @"动画效果",
                                                 XYDTabBarItemImage : @"message_normal",
                                                 XYDTabBarItemSelectedImage : @"message_highlight",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  XYDTabBarItemTitle : @"完整工程",
                                                  XYDTabBarItemImage : @"account_normal",
                                                  XYDTabBarItemSelectedImage : @"account_highlight"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(XYDTabBarController *)tabBarController {
#warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = 40.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait){
            NSLog(@"Landscape portrait!");
        }
    };
}



+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
