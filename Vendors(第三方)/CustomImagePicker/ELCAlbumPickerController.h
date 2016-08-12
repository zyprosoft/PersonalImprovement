//
//  AlbumPickerController.h
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetPickerFilterDelegate.h"

typedef NS_ENUM(NSInteger,SelectFileType) {
    SelectAllPhotoes,
    SelectAllVideos,
    SelectAllFiles,
};

@interface ELCAlbumPickerController : UITableViewController

@property (nonatomic, weak) id<ELCAssetSelectionDelegate> parent;
@property (nonatomic, strong) NSMutableArray *assetGroups;

// optional, can be used to filter the assets displayed
@property (nonatomic, weak) id<ELCAssetPickerFilterDelegate> assetPickerFilterDelegate;

@property (assign,nonatomic)NSInteger whichGroup;
@property (assign,nonatomic)NSUInteger maxSelectedCount;//图片选择界面可以选择的最多的图片
// 选择图片还是视频
@property (nonatomic,assign)  SelectFileType selectFileType;

@end

