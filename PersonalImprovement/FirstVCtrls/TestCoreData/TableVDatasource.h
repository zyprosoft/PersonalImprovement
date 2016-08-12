//
//  TableVDatasource.h
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/4/14.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class TestCoreDataVCtrl;

@protocol DataSourceDelegate
- (void)configureCell:(id)cell withObject:(id)object;
- (void)deleteObject:(id)object;
@end

@interface TableVDatasource : NSObject<UITableViewDataSource,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, weak) id<DataSourceDelegate> delegate;
@property (nonatomic, copy) NSString* reuseIdentifier;
@property (nonatomic) BOOL paused;

- (id)initWithTableView:(UITableView*)tableView identifier:(NSString *)identifier;
- (id)selectedItem;

@end
