//
//  NetRequestClass.m
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/6.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "NetRequestClass.h"
#import <AFNetworking.h>
#import "OldAFHTTPRequestOperationManager.h"

@interface NetRequestClass ()

@end


@implementation NetRequestClass
#pragma 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    __block NSString * changedStated = nil;
    //根据回调信息判断网络类型
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                changedStated = @"未知的网络\n请检查网络设置";
                //                KMyLog(@"stateChanged - > %@",changedStated);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                changedStated = @"当前没有网络连接\n请检查网络设置";
                //                KMyLog(@"stateChanged - > %@",changedStated);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                changedStated = @"您当前使用的网络类型是WIFI";
                //                KMyLog(@"stateChanged - > %@",changedStated);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                changedStated = @"您当前使用的是2G/3G网络\n可能会产生流量费用";
                //                KMyLog(@"stateChanged - > %@",changedStated);
                break;
        }
    }];
    return (changedStated == nil || [changedStated isEqualToString:@"未知的网络\n请检查网络设置"]) ? NO :YES;
}


/***************************************
 在这做判断如果有dic里有errorCode
 调用errorBlock(dic)
 没有errorCode则调用block(dic
 ******************************/

#pragma --mark GET请求方式
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ReturnValueBlock) block
                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    WithFailureBlock: (FailureBlock) failureBlock
{
    OldAFHTTPRequestOperationManager *manager = [[OldAFHTTPRequestOperationManager alloc] init];
    
    OldAFHTTPRequestOperation *op = [manager GET:requestURLString parameters:parameter success:^(OldAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        DDLog(@"%@", dic);
        
        block(dic);
        
    } failure:^(OldAFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error description]);
        failureBlock();
    }];
    op.responseSerializer = [OldAFHTTPResponseSerializer serializer];
    [op start];
}

#pragma --mark POST请求方式

+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock: (ReturnValueBlock) block
                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock
{
    OldAFHTTPRequestOperationManager *manager = [[OldAFHTTPRequestOperationManager alloc] init];
    
    OldAFHTTPRequestOperation *op = [manager POST:requestURLString parameters:parameter success:^(OldAFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        DDLog(@"%@", dic);
        
        block(dic);
        /***************************************
         在这做判断如果有dic里有errorCode
         调用errorBlock(dic)
         没有errorCode则调用block(dic
         ******************************/
        
    } failure:^(OldAFHTTPRequestOperation *operation, NSError *error) {
        failureBlock();
    }];
    
    op.responseSerializer = [OldAFHTTPResponseSerializer serializer];
    
    [op start];

}




@end
