//
//  XYDTabBarController.h
//  XYDTarbar
//
//  Created by xiong有都 on 16/6/19.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDPlusButton.h"

FOUNDATION_EXTERN NSString *const XYDTabBarItemTitle;
FOUNDATION_EXTERN NSString *const XYDTabBarItemImage;
FOUNDATION_EXTERN NSString *const XYDTabBarItemSelectedImage;

@interface XYDTabBarController : UITabBarController

/*!
 * The Attributes of items which is displayed on the tab bar.
 */
@property (nullable, nonatomic, readwrite, copy)  NSArray<NSDictionary *> *tabBarItemsAttributes;

/*!
 * Customize UITabBar height
 */
@property (nonatomic, assign) CGFloat tabBarHeight;

/*!
 * To set both UIBarItem image view attributes in the tabBar,
 * default is UIEdgeInsetsZero.
 */
@property (nonatomic, readwrite, assign) UIEdgeInsets imageInsets;

// custom plusButton instance
@property (nonatomic,strong,nullable) XYDPlusButton <XYDPlusButtonProtocol> *plusButton;

/*!
 * To set both UIBarItem label text attributes in the tabBar,
 * use the following to tweak the relative position of the label within the tab button (for handling visual centering corrections if needed because of custom text attributes)
 */
@property (nonatomic, readwrite, assign) UIOffset titlePositionAdjustment;

- (instancetype)initWithViewControllers:(nullable NSArray<UIViewController *> *)viewControllers plusButton:(XYDPlusButton<XYDPlusButtonProtocol> *)plusButton tabBarItemsAttributes:(nullable NSArray<NSDictionary *> *)tabBarItemsAttributes;

+ (instancetype)tabBarControllerWithViewControllers:(nullable NSArray<UIViewController *> *)viewControllers plusButton:(XYDPlusButton<XYDPlusButtonProtocol> *)plusButton tabBarItemsAttributes:(nullable NSArray<NSDictionary *> *)tabBarItemsAttributes;

@end

@interface UIViewController (XYDTabBarController)


/*!
 * If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.
 * If `self` is kind of `UIViewController`, this method will return the nearest ancestor in the view controller hierarchy that is a tab bar controller. If `self` is not kind of `UIViewController`, it will return the `rootViewController` of the `rootWindow` as long as you have set the `XYDTabBarController` as the  `rootViewController`. Otherwise return nil. (read-only)
 */
@property (nullable, nonatomic, readonly) XYDTabBarController *xyd_tabBarController;

@end
