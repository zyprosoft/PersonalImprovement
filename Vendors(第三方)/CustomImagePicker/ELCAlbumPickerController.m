//
//  AlbumPickerController.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"

#import "ScanPhotoesViewCtrl.h"

@interface ELCAlbumPickerController ()

@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation ELCAlbumPickerController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MyTool hideExtraTableviewSeparatedLine:self.tableView];
    [self.navigationItem setTitle:@"选择相册"];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self.parent action:@selector(cancelImagePicker)];
	[self.navigationItem setRightBarButtonItem:cancelButton];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.assetGroups = tempArray;
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    self.library = assetLibrary;

    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^{
        @autoreleasepool {
        
        // Group enumerator Block
            void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
                if (group == nil) {
                    return;
                }
                if (_selectFileType == SelectAllVideos) {
                    [group setAssetsFilter:[ALAssetsFilter allVideos]];
                }else if (_selectFileType == SelectAllPhotoes){
                    [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                }else {
                    [group setAssetsFilter:[ALAssetsFilter allAssets]];
                }
                if ([group numberOfAssets] != 0) {
                    // added fix for camera albums order
                    NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                    NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                    // 显示“我的照片流”图片大图会有问题，因此此处过滤掉
                    if (![[sGroupPropertyName lowercaseString] isEqualToString:NSLocalizedString(@"my photo stream", nil)]) {
                        if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
                            [self.assetGroups insertObject:group atIndex:0];
                        }else {
                            [self.assetGroups addObject:group];
                        }
                        
                        // Reload albums
                        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
                    }
                }
            };
            
            // Group Enumerator Failure Block
            void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                int author = [ALAssetsLibrary authorizationStatus];
                NSString *alertStr;
                switch (author) {
                    case ALAuthorizationStatusDenied:{
                        alertStr = @"请在iPhone的“设置-隐私-照片”选项中，允许任易清单访问你的手机相册";
                    }break;
                    default:break;
                }
                 UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"无法访问照片" message:alertStr delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alert show];
                
            };
            // Enumerate Albums
            [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                   usingBlock:assetGroupEnumerator 
                                 failureBlock:assetGroupEnumberatorFailure];
        }
    });
    
}

- (void)reloadTableView {
	[self.tableView reloadData];
    [self.navigationItem setTitle:@"相册"];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.assetGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ALAssetsGroup *g = (ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row];
    if (_selectFileType == SelectAllVideos) {
        [g setAssetsFilter:[ALAssetsFilter allVideos]];
    }else if (_selectFileType == SelectAllPhotoes){
        [g setAssetsFilter:[ALAssetsFilter allPhotos]];
    }else {
        [g setAssetsFilter:[ALAssetsFilter allAssets]];
    }
    NSInteger gCount = [g numberOfAssets];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%lld)",[g valueForProperty:ALAssetsGroupPropertyName], (long long)gCount];
    [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row] posterImage]]];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

//选中某一个相册进入到相册内部时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 57;
}


//点击Done按钮之后调用该方法
-(void)photoBrowserDidClickDone:(MWPhotoBrowser *)photoBrowser andSelectionArray:(NSArray *)arry {
    NSMutableArray *assetArray = [NSMutableArray array];
    ALAssetsGroup *assetGroup = self.assetGroups[self.whichGroup];
    [assetGroup enumerateAssetsUsingBlock:^(ALAsset*asset, NSUInteger index, BOOL *stop) {
        //从group里面
         if (asset) {
             BOOL isSelect = [arry[index] boolValue];
             if (isSelect) {
                 [assetArray addObject:asset];
             }
         }
     }];
    [_parent selectedAssets:assetArray];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end

