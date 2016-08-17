//
//  NetworkService.h
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkModel.h"


@protocol NetworkServiceProtocol <NSObject>

- (void)getAvatarList:(NSArray <Avatar *> *)list;

@end

@interface NetworkService : NSObject<NetworkServiceProtocol> 

@end
