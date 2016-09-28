//
//  CarBaseViewCell.h
//  cells
//
//  Created by James Tang on 1/6/14.
//  Copyright (c) 2014 James Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Presenter;

@interface PresenterTableViewCell : UITableViewCell

// PresenterTableViewCell中的所有子控件都没有拖拽outlet到该类中，而是拖拽到了CarPresenter类中
// storyboard中指定了presenter是CarPresenter（CarPresenter->Presenter->UIImageView）
@property (strong, nonatomic) IBOutlet Presenter *presenter;

@end
