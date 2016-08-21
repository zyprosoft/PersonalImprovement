//
//  ViewController.m
//  FactoryPattern
//
//  Created by YouXianMing on 15/7/29.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "FactoryVCtrl1.h"
#import "DeviceCreator.h"

@interface FactoryVCtrl1 ()

@end

@implementation FactoryVCtrl1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    BaseDevice *iPhone = [DeviceCreator deviceCreatorWithDeviceType:kiPhone];
    [iPhone phoneCall];
    NSLog(@"%@", [iPhone systemInfomation]);
    
    BaseDevice *android = [DeviceCreator deviceCreatorWithDeviceType:kAndroid];
    [android phoneCall];
    NSLog(@"%@", [android systemInfomation]);
    
    BaseDevice *windows = [DeviceCreator deviceCreatorWithDeviceType:kWindows];
    [windows phoneCall];
    NSLog(@"%@", [windows systemInfomation]);
}

@end
