//
//  BFKitVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/10.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "BFKitVCtrl.h"

@interface BFKitVCtrl ()

@end

@implementation BFKitVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _bfkitArray = [[NSMutableArray alloc] initWithArray:@[@"BFApp",
                                                          @"BFButton",
                                                          @"BFCryptor",
                                                          @"BFDataStructures",
                                                          @"BFLog",
                                                          @"BFPassword",
                                                          @"BFSystemSound",
                                                          @"BFTextField",
                                                          @"BFTouchID",
                                                          ]];
    
    _uikitArray = [[NSMutableArray alloc] initWithArray:@[@"UIButton",
                                                          @"UIColor",
                                                          @"UIDevice",
                                                          @"UIFont",
                                                          @"UIImage",
                                                          @"UIImageView",
                                                          @"UILabel",
                                                          @"UINavigationBar",
                                                          @"UIScreen",
                                                          @"UIScrollView",
                                                          @"UITableView",
                                                          @"UITextField",
                                                          @"UITextView",
                                                          @"UIToolbar",
                                                          @"UIView",
                                                          @"UIWebView",
                                                          @"UIWindow"]];
    
    _foundationArray = [[NSMutableArray alloc] initWithArray:@[@"NSArray",
                                                               @"NSData",
                                                               @"NSDate",
                                                               @"NSDictionary",
                                                               @"NSFileManager",
                                                               @"NSMutableArray",
                                                               @"NSMutableDictionary",
                                                               @"NSNumber",
                                                               @"NSObject",
                                                               @"NSProcessInfo",
                                                               @"NSString",
                                                               @"NSThread"]];
    
    _infoViewController = [[InfoViewController alloc] init];
    _infoNavigationController = [[UINavigationController alloc] initWithRootViewController:_infoViewController];
    
    _bfkitViewController = [[BFKitViewController alloc] init];
    _bfkitViewController.bfKitVCtrl = self;
    _bfkitNavigationController = [[UINavigationController alloc] initWithRootViewController:_bfkitViewController];
    
    _kitViewController = [[UserInterfaceKitViewController alloc] init];
    _kitViewController.bfKitVCtrl = self;
    _kitNavigationController = [[UINavigationController alloc] initWithRootViewController:_kitViewController];
    
    _foundationViewController = [[FoundationViewController alloc] init];
    _foundationViewController.bfKitVCtrl = self;
    _foundationNavigationController = [[UINavigationController alloc] initWithRootViewController:_foundationViewController];
    
    _tabBarController = [[UITabBarController alloc] init];
    [_tabBarController setViewControllers:@[_bfkitNavigationController, _kitNavigationController ,_foundationNavigationController]];
    
    KCurrentWindow.rootViewController = _tabBarController;
}


@end
