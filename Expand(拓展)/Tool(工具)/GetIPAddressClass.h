//
//  GetIPAddressClass.h
//  GetIPAddressDemo
//
//  Created by WeCarMac02 on 16/3/31.
//  Copyright © 2016年 ZHIHUA WU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
@interface GetIPAddressClass : NSObject
+ (NSString *) localIPAddress;
@end
