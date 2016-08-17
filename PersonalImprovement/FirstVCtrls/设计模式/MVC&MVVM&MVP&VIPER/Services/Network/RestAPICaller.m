//
//  RestAPICaller.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "RestAPICaller.h"
#import "AFNetworking.h"
#import "<#header#>"

@interface RestAPICaller () {
    AFHTTPSessionManager *sessionManager;
}

@end

@implementation RestAPICaller

- (instancetype)init
{
    self = [super init];
    if (self) {
        sessionManager= [[AFHTTPSessionManager alloc]init];
        sessionManager.responseSerializer.acceptableContentTypes = @[ @"application/json", @"text/plain" ];
    }
    return self;
}

- (NSURLSessionDataTask *)doGetWithStr:(NSString *)url callback:(NSDictionary <NSString *,id> *)callback {
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer new];
    NSURLRequest *request = [serializer requestWithMethod:@"get" URLString:url parameters:nil error:nil];
    NSURLSessionDataTask *task = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    return task;
}

@end
