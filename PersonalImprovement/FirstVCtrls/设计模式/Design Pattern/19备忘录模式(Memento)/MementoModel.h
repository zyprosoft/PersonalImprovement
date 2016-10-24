//
//  Model.h
//  MementoPattern
//
//  Created by YouXianMing on 15/9/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MementoCenterProtocol.h"

@interface MementoModel : NSObject <MementoCenterProtocol>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;

@end
