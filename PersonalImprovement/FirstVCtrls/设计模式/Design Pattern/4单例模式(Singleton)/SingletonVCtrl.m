//
//  ViewController.m
//  SingletonPattern
//
//  Created by YouXianMing on 15/8/6.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "SingletonVCtrl.h"
#import "Singleton.h"

@interface SingletonVCtrl ()

@end

@implementation SingletonVCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    NSLog(@"%@", [Singleton sharedInstance]);
//    NSLog(@"%@", [Singleton new]);
}

@end
