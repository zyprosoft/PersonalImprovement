//
//  ViewController.m
//  AbstractFactoryPattern
//
//  Created by YouXianMing on 15/8/2.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "AbstractFactoryVCtrl1.h"
#import "AcmeBrandingFactory.h"
#import "SierraBrandingFactory.h"

@interface AbstractFactoryVCtrl1 ()

@end

@implementation AbstractFactoryVCtrl1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    BrandingFactory *acmeFactory = [AcmeBrandingFactory factory];
    [acmeFactory brandedView];
    [acmeFactory brandedMainButton];
    
    BrandingFactory *sierraFactory = [SierraBrandingFactory factory];
    [sierraFactory brandedView];
    [sierraFactory brandedMainButton];
}

@end
