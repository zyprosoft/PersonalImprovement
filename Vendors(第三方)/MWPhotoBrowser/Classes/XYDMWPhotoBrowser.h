//
//  XYDMWPhotoBrowser.h
//  XYDMWPhotoBrowser
//
//  Created by Michael Waterfall on 14/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDMWPhoto.h"
#import "XYDMWPhotoProtocol.h"
#import "XYDMWCaptionView.h"

// Debug Logging
#if 0 // Set to 1 to enable debug logging
#define MWLog(x, ...) NSLog(x, ## __VA_ARGS__);
#else
#define MWLog(x, ...)
#endif

@class XYDMWPhotoBrowser;

@protocol XYDMWPhotoBrowserDelegate <NSObject>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(XYDMWPhotoBrowser *)photoBrowser;
- (id <XYDMWPhoto>)photoBrowser:(XYDMWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;

@optional

- (id <XYDMWPhoto>)photoBrowser:(XYDMWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
- (XYDMWCaptionView *)photoBrowser:(XYDMWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index;
- (NSString *)photoBrowser:(XYDMWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(XYDMWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index;
- (void)photoBrowser:(XYDMWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index;
- (BOOL)photoBrowser:(XYDMWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index;
- (void)photoBrowser:(XYDMWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected;
- (void)photoBrowserDidFinishModalPresentation:(XYDMWPhotoBrowser *)photoBrowser;

// 此数方法我加，右上角按钮
- (UIBarButtonItem *)photoBrowserRightTopBarItem:(XYDMWPhotoBrowser *)photoBrowser;
// 导航栏返回按钮
- (UIBarButtonItem *)photoBrowserBackBarItem:(XYDMWPhotoBrowser *)photoBrowser;
// 返回所有toolBar上的items,可以完全接受自定义
- (NSArray *)photoBrowserToolBarItems:(XYDMWPhotoBrowser *)photoBrowser;

@end

@interface XYDMWPhotoBrowser : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet id<XYDMWPhotoBrowserDelegate> delegate;
@property (nonatomic) BOOL zoomPhotosToFill;
@property (nonatomic) BOOL displayNavArrows;
@property (nonatomic) BOOL displayActionButton;
@property (nonatomic) BOOL displaySelectionButtons;
@property (nonatomic) BOOL alwaysShowControls;
@property (nonatomic) BOOL enableGrid;
@property (nonatomic) BOOL enableSwipeToDismiss;
@property (nonatomic) BOOL startOnGrid;
@property (nonatomic) BOOL autoPlayOnAppear;
@property (nonatomic) NSUInteger delayToHideElements;
@property (nonatomic, readonly) NSUInteger currentIndex;

// Customise image selection icons as they are the only icons with a colour tint
// Icon should be located in the app's main bundle
@property (nonatomic, strong) NSString *customImageSelectedIconName;
@property (nonatomic, strong) NSString *customImageSelectedSmallIconName;

// Init
- (id)initWithPhotos:(NSArray *)photosArray;
- (id)initWithDelegate:(id <XYDMWPhotoBrowserDelegate>)delegate;

// Reloads the photo browser and refetches data
- (void)reloadData;

// Set page that photo browser starts on
- (void)setCurrentPhotoIndex:(NSUInteger)index;

// Navigation
- (void)showNextPhotoAnimated:(BOOL)animated;
- (void)showPreviousPhotoAnimated:(BOOL)animated;

/**
 *  我加的属性与方法
 */

// 此方法我加，用以自定义gridBtn
@property (nonatomic) BOOL isSelectAll;
// 是否滚动到底部（在选择图片时，因为最新的图片在最低端，所以希望先移动到底部显示老图片）
@property (nonatomic) BOOL isScrollToBottom;
// 点击返回按钮是回到gird，还是直接退出图片浏览器
@property (assign,nonatomic)BOOL clickBackToExitBrowser;
// 是否正显示gird视图
- (BOOL) isShowingGrid;
- (BOOL)isShowGridBtn;
- (void)selectAllCell;
- (CGRect)frameForPagingScrollView;
- (CGRect)frameForGridCtrl;
- (CGRect)frameForBrowserView;
- (void)clickBackBtn;
- (void)setNavBarAppearance:(BOOL)animated;
- (void)setToolBarAppearance:(UIToolbar *)toolBar ;

@end
