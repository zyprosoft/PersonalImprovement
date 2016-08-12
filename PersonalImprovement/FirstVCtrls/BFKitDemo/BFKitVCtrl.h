//
//  BFKitVCtrl.h
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/10.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "BaseVCtrl.h"
#import "UserInterfaceKitViewController.h"
#import "FoundationViewController.h"
#import "BFKitViewController.h"
#import "InfoViewController.h"
#import "BFKit.h"

@interface BFKitVCtrl : BaseVCtrl

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) UINavigationController *kitNavigationController;
@property (strong, nonatomic) UserInterfaceKitViewController *kitViewController;

@property (strong, nonatomic) UINavigationController *foundationNavigationController;
@property (strong, nonatomic) FoundationViewController *foundationViewController;

@property (strong, nonatomic) UINavigationController *bfkitNavigationController;
@property (strong, nonatomic) BFKitViewController *bfkitViewController;

@property (strong, nonatomic) UINavigationController *infoNavigationController;
@property (strong, nonatomic) InfoViewController *infoViewController;

@property (strong, nonatomic) NSMutableArray *uikitArray;
@property (strong, nonatomic) NSMutableArray *foundationArray;
@property (strong, nonatomic) NSMutableArray *bfkitArray;

@end
