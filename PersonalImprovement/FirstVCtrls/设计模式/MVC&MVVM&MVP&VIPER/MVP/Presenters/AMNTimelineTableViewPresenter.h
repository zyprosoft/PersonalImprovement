//
//  AMNTimelineTableViewPresenter.h
//  MVPExample-ObjectiveC
//
//  Created by amacou on 2016/02/18.
//  Copyright © 2016年 amacou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMNPresenterProtocol.h"

@interface AMNTimelineTableViewPresenter : NSObject <UITableViewDataSource, UITableViewDelegate, AMNPresenterProtocol>

//AMNTopViewController中的tableview视图作为该属性
@property (nonatomic, weak) IBOutlet UITableView *view;

// AMNTopViewController实例作为该属性
@property (nonatomic, weak) IBOutlet UIViewController *viewController;
@end
