//
//  NormalModelAdapter.m
//  AdapterPattern
//
//  Created by YouXianMing on 15/7/25.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NormalModelAdapter.h"
#import "AdapterNormalModel.h"

@implementation NormalModelAdapter

- (NSString *)name {
    
    AdapterNormalModel *model = self.data;
    return model.name;
}

- (UIColor *)lineColor {
    
    AdapterNormalModel *model = self.data;
    return model.lineColor;
}

- (NSString *)phoneNumber {
    
    AdapterNormalModel *model = self.data;
    return model.phoneNumber;
}

@end
