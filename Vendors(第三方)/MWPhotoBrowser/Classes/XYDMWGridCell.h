//
//  XYDMWGridCell.h
//  XYDMWPhotoBrowser
//
//  Created by Michael Waterfall on 08/10/2013.
//
//

#import <UIKit/UIKit.h>
#import "XYDMWPhoto.h"
#import "XYDMWGridViewController.h"

@interface XYDMWGridCell : UICollectionViewCell {}

@property (nonatomic, weak) XYDMWGridViewController *gridController;
@property (nonatomic) NSUInteger index;
@property (nonatomic) id <XYDMWPhoto> photo;
// 是否处于选择模式下
@property (nonatomic) BOOL selectionMode;
@property (nonatomic) BOOL isSelected;

- (void)displayImage;
- (void)selectionButtonPressed;

@end
