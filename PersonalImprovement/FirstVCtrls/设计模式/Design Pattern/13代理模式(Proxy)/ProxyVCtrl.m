//
//  ViewController.m
//  AppProxy
//
//  Created by YouXianMing on 15/8/4.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "ProxyVCtrl.h"
#import "MessageProtocol.h"
#import "ConcreteProxy.h"

@interface ProxyVCtrl () <MessageProtocol>

@property (nonatomic, strong) ConcreteProxy  *proxy;

@end

@implementation ProxyVCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.proxy = [[ConcreteProxy alloc] initWithCustomer:self];
    [self.proxy helloWorld];
    [self.proxy goodBye];
}

- (void)helloWorld {
    
    NSLog(@"helloWorld");
}

@end
