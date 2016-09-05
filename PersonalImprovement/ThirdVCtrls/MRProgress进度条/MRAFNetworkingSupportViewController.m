//
//  MROldAFNetworkingSupportViewController.m
//  Example
//
//  Created by Marius Rackwitz on 16.07.14.
//  Copyright (c) 2014 Marius Rackwitz. All rights reserved.
//

#import "MROldAFNetworkingSupportViewController.h"
#import "OldAFNetworking.h"
#import "MRActivityIndicatorView.h"
#import "MRCircularProgressView.h"
#import "MRNavigationBarProgressView.h"
#import "MRActivityIndicatorView+OldAFNetworking.h"
#import "MRProgressView+OldAFNetworking.h"
#import "MRProgressOverlayView+OldAFNetworking.h"


@interface MROldAFNetworkingSupportViewController ()

@property (weak, nonatomic) IBOutlet MRActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet MRCircularProgressView *circularProgressView;

@property (nonatomic, strong) OldAFHTTPSessionManager *sessionManager;

@end


@implementation MROldAFNetworkingSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityIndicatorView.hidesWhenStopped = NO;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    OldAFHTTPSessionManager *sessionManager = [[OldAFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://httpbin.org/"] sessionConfiguration:config];
    sessionManager.responseSerializer = [OldAFHTTPResponseSerializer serializer];
    self.sessionManager = sessionManager;
}

- (NSURLSessionDownloadTask *)bytesDownloadTask {
    NSURLSessionDownloadTask *task = [self.sessionManager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"/bytes/1000000" relativeToURL:self.sessionManager.baseURL]]
                                                                         progress:nil
                                                                      destination:nil
                                                                completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error){
                                                                    NSLog(@"Task completed with error: %@", error);
                                                                }];
    [task resume];
    return task;
}

- (IBAction)onActivityIndicatorGo:(id)sender {
    NSURLSessionDataTask *task = [self.sessionManager GET:@"/delay/3"
                                               parameters:nil
                                                 progress:nil
                                                  success:nil
                                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                      NSLog(@"Task %@ failed with error: %@", task, error);
                                                  }];
    [self.activityIndicatorView setAnimatingWithStateOfTask:task];
}

- (IBAction)onCircularProgressViewGo:(id)sender {
    NSURLSessionDownloadTask *task = [self bytesDownloadTask];
    [self.circularProgressView setProgressWithDownloadProgressOfTask:task animated:YES];
}

- (IBAction)onOverlayViewGo:(id)sender {
    NSURLSessionDataTask *task = [self.sessionManager GET:@"/delay/2"
                                               parameters:nil
                                                 progress:nil
                                                  success:nil
                                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                   if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled) {
                                                       NSLog(@"Task was cancelled by user.");
                                                   } else {
                                                       NSLog(@"Task %@ failed with error: %@", task, error);
                                                   }
                                               }];
    
    MRProgressOverlayView *overlayView = [MRProgressOverlayView showOverlayAddedTo:self.view animated:YES];
    [overlayView setModeAndProgressWithStateOfTask:task];
    [overlayView setStopBlockForTask:task];
}

- (IBAction)onOverlayViewUpload:(id)sender {
    // See [OldAFNetworking/OldAFNetworking#2128](https://github.com/OldAFNetworking/OldAFNetworking/issues/2128)
    NSString *fileName = @"aquarium-fish1.jpg";
    NSString *filePath = [NSBundle.mainBundle pathForResource:fileName.stringByDeletingPathExtension ofType:fileName.pathExtension];
    
    // Prepare a temporary file to store the multipart request prior to sending it to the server due to an alleged
    // bug in NSURLSessionTask.
    NSString* tmpFilename = [NSString stringWithFormat:@"%f", NSDate.timeIntervalSinceReferenceDate];
    NSURL* tmpFileUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:tmpFilename]];
    
    // Create a multipart form request.
    NSMutableURLRequest *multipartRequest = [[OldAFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                                       URLString:[[NSURL URLWithString:@"/post" relativeToURL:self.sessionManager.baseURL] absoluteString]
                                                                                                      parameters:nil
                                                                                       constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                           [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath]
                                                                                                                      name:@"file"
                                                                                                                  fileName:fileName
                                                                                                                  mimeType:@"image/jpeg" error:nil];
                                                                                       } error:nil];
    
    // Dump multipart request into the temporary file.
    [OldAFHTTPRequestSerializer.serializer requestWithMultipartFormRequest:multipartRequest
                                            writingStreamContentsToFile:tmpFileUrl
                                                      completionHandler:^(NSError *error) {
                                                          // Once the multipart form is serialized into a temporary file, we can initialize
                                                          // the actual HTTP request using session manager.
                                                           
                                                          // Create default session manager.
                                                          OldAFURLSessionManager *manager = [[OldAFURLSessionManager alloc] initWithSessionConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
                                                            
                                                          // Here note that we are submitting the initial multipart request. We are, however,
                                                          // forcing the body stream to be read from the temporary file.
                                                          NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:multipartRequest
                                                                                                                     fromFile:tmpFileUrl
                                                                                                                     progress:nil
                                                                                                            completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                                                                                // Cleanup: remove temporary file.
                                                                                                                [NSFileManager.defaultManager removeItemAtURL:tmpFileUrl error:nil];
                                                                                                                  
                                                                                                                NSLog(@"Task completed with error: %@", error);
                                                                                                            }];
                                                            
                                                          // Start the file upload.
                                                          [uploadTask resume];
                                                           
                                                          [[MRProgressOverlayView showOverlayAddedTo:self.view animated:YES] setModeAndProgressWithStateOfTask:uploadTask];
                                                      }];
}

- (IBAction)onOverlayViewError:(id)sender {
    NSURLSessionDataTask *task = [self.sessionManager GET:@"/status/418"
                                               parameters:nil
                                                 progress:nil
                                                  success:nil
                                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                      NSLog(@"Task %@ failed, as expected, with error: %@", task, error);
                                                  }];
    [[MRProgressOverlayView showOverlayAddedTo:self.view animated:YES] setModeAndProgressWithStateOfTask:task];
}

- (IBAction)onNavigationBarProgressViewGo:(id)sender {
    NSURLSessionDownloadTask *task = [self bytesDownloadTask];
    [[MRNavigationBarProgressView progressViewForNavigationController:self.navigationController]
     setProgressWithDownloadProgressOfTask:task animated:YES];
}

@end
