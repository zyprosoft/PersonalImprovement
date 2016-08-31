//
//  UIViewTap.h
//  Momento
//
//  Created by Michael Waterfall on 04/11/2009.
//  Copyright 2009 d3i. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYDMWTapDetectingViewDelegate;

@interface XYDMWTapDetectingView : UIView {}

@property (nonatomic, weak) id <XYDMWTapDetectingViewDelegate> tapDelegate;

@end

@protocol XYDMWTapDetectingViewDelegate <NSObject>

@optional

- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view tripleTapDetected:(UITouch *)touch;

@end