//
//  Menu.m
//  FlyweightPattern
//
//  Created by YouXianMing on 15/10/27.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "FlyweightMenu.h"

@interface FlyweightMenu ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, CoffeeFlavor *>  *flavors;

@end

@implementation FlyweightMenu

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
    
        self.flavors = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (CoffeeFlavor *)lookupWithFlavor:(NSString *)flavor {

    NSParameterAssert(flavor);

    if ([self.flavors objectForKey:flavor] == nil) {
        
        CoffeeFlavor *coffeeFlavor = [[CoffeeFlavor alloc] init];
        coffeeFlavor.flavor        = flavor;
        
        self.flavors[flavor] = coffeeFlavor;
    }
    
    return [self.flavors objectForKey:flavor];
}

@end
