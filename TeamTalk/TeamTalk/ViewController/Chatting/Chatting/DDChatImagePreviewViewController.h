//
//  DDChatImagePreviewViewController.h
//  IOSDuoduo
//
//  Created by Michael Scofield on 2014-06-11.
//  Copyright (c) 2014 dujia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYDMWPhotoBrowser.h"
#import "LCActionSheet.h"
@interface DDChatImagePreviewViewController : UIViewController<XYDMWPhotoBrowserDelegate,UIActionSheetDelegate,LCActionSheetDelegate>
@property(nonatomic,strong)NSMutableArray *photos;
@property(nonatomic)NSInteger index;
@property(nonatomic)NSString *QRCodeResult;
@property(strong)UIImage *previewImage;
@end