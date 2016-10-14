//
//  ViewController.m
//  SingletonPattern
//
//  Created by YouXianMing on 15/8/6.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "SingletonVCtrl1.h"
#import "Singleton.h"

@interface SingletonVCtrl1 ()

@end

@implementation SingletonVCtrl1

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    NSLog(@"%@", [Singleton sharedInstance]);
//    NSLog(@"%@", [Singleton new]);
}

@end
