//
//  ZoomingScrollView.h
//  XYDMWPhotoBrowser
//
//  Created by Michael Waterfall on 14/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYDMWPhotoProtocol.h"
#import "XYDMWTapDetectingImageView.h"
#import "XYDMWTapDetectingView.h"

@class XYDMWPhotoBrowser, XYDMWPhoto, XYDMWCaptionView;

@interface XYDMWZoomingScrollView : UIScrollView <UIScrollViewDelegate, XYDMWTapDetectingImageViewDelegate, XYDMWTapDetectingViewDelegate> {

}

@property () NSUInteger index;
@property (nonatomic) id <XYDMWPhoto> photo;
@property (nonatomic, weak) XYDMWCaptionView *captionView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, weak) UIButton *playButton;

- (id)initWithPhotoBrowser:(XYDMWPhotoBrowser *)browser;
- (void)displayImage;
- (void)displayImageFailure;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)prepareForReuse;
- (BOOL)displayingVideo;
- (void)setImageHidden:(BOOL)hidden;

@end
