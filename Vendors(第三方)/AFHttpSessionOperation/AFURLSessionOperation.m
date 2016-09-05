//
//  OldAFURLSessionOperation.m
//
//  Created by Robert Ryan on 12/13/15.
//  Copyright © 2015 Robert Ryan. All rights reserved.
//

#import "OldAFURLSessionOperation.h"
#import "OldAFURLSessionManager.h"

@interface OldAFURLSessionOperation ()

@property (nonatomic, strong, readwrite, nullable) NSURLSessionTask *task;

@end

@implementation OldAFURLSessionOperation

+ (instancetype)dataOperationWithManager:(OldAFURLSessionManager *)manager
                                 request:(NSURLRequest *)request
                       completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler {
    OldAFURLSessionOperation *operation = [[OldAFURLSessionOperation alloc] init];
    
    operation.task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) completionHandler(response, responseObject, error);
        [operation completeOperation];
    }];
    
    return operation;
}

+ (instancetype)dataOperationWithManager:(OldAFURLSessionManager *)manager
                                 request:(NSURLRequest *)request
                          uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                        downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                       completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler {
    OldAFURLSessionOperation *operation = [[OldAFURLSessionOperation alloc] init];
    
    operation.task = [manager dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) completionHandler(response, responseObject, error);
        [operation completeOperation];
    }];
    
    return operation;
}

- (instancetype)uploadOperationWithManager:(OldAFURLSessionManager *)manager
                                   request:(NSURLRequest *)request
                                  fromFile:(NSURL *)fileURL
                                  progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                         completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError  * _Nullable error))completionHandler {
    OldAFURLSessionOperation *operation = [[OldAFURLSessionOperation alloc] init];
    
    operation.task = [manager uploadTaskWithRequest:request fromFile:fileURL progress:uploadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) completionHandler(response, responseObject, error);
        [operation completeOperation];
    }];
    
    return operation;
}

+ (instancetype)uploadOperationWithManager:(OldAFURLSessionManager *)manager
                                   request:(NSURLRequest *)request
                                  fromData:(nullable NSData *)bodyData
                                  progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                         completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError * _Nullable error))completionHandler {
    OldAFURLSessionOperation *operation = [[OldAFURLSessionOperation alloc] init];
    
    operation.task = [manager uploadTaskWithRequest:request fromData:bodyData progress:uploadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) completionHandler(response, responseObject, error);
        [operation completeOperation];
    }];
    
    return operation;
}

+ (instancetype)uploadOperationWithManager:(OldAFURLSessionManager *)manager
                           streamedRequest:(NSURLRequest *)request
                                  progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                         completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError * _Nullable error))completionHandler {
    OldAFURLSessionOperation *operation = [[OldAFURLSessionOperation alloc] init];
    
    operation.task = [manager uploadTaskWithStreamedRequest:request progress:uploadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) completionHandler(response, responseObject, error);
        [operation completeOperation];
    }];
    
    return operation;
}

+ (instancetype)downloadOperationWithManager:(OldAFURLSessionManager *)manager
                                     request:(NSURLRequest *)request
                                    progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                 destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                           completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler {
    OldAFURLSessionOperation *operation = [[OldAFURLSessionOperation alloc] init];
    
    operation.task = [manager downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completionHandler) completionHandler(response, filePath, error);
        [operation completeOperation];
    }];
    
    return operation;
}

+ (instancetype)downloadOperationWithManager:(OldAFURLSessionManager *)manager
                                  resumeData:(NSData *)resumeData
                                    progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                 destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                           completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler {
    OldAFURLSessionOperation *operation = [[OldAFURLSessionOperation alloc] init];
    
    operation.task = [manager downloadTaskWithResumeData:resumeData progress:downloadProgressBlock destination:destination completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (completionHandler) completionHandler(response, filePath, error);
        [operation completeOperation];
    }];
    
    return operation;
}

- (void)main {
    [self.task resume];
}

- (void)completeOperation {
    self.task = nil;
    [super completeOperation];
}

- (void)cancel {
    [self.task cancel];
    [super cancel];
}

@end
