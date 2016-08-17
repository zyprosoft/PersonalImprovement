//
//  UIImage+AsyncLoadImage.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "UIImageView+AsyncLoadImage.h"

@implementation UIImageView (AsyncLoadImage)

- (void)imageFromUrl:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.image = [UIImage imageWithData:data];
    }];
}

@end
