//
//  RestAPICaller.h
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RestAPIProtocol <NSObject>

/**
 * Do an http GET request to url specified
 *
 * @param url String?
 */
- (NSURLSessionDataTask *)doGetWithStr:(NSString *)url callback:(NSDictionary <NSString *,id> *)callback;

@optional
/**
 * Do an http POST request to url specified
 *
 * @param url String?
 * @param data NSData? http body
 */
- (NSString *)doPost:(NSString *)url data:(NSData *)data;

@end

@interface RestAPICaller : NSObject<RestAPIProtocol>

@end
