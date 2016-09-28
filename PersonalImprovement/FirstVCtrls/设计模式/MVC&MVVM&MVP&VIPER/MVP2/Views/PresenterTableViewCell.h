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
// 个人感觉，这样不好理解，应该还是将所有的子控件拖拽到当前类PresenterTableViewCell中，然后在CarPresenter中拖拽当前类PresenterTableViewCell作为属性，这样CarPresenter中同时有cell和model了，就可以配置界面控件值了（但是这样也不好，因为当前类中已经有有了presenter属性了）

// storyboard中指定了presenter是CarPresenter（CarPresenter->Presenter->UIImageView）
@property (strong, nonatomic) IBOutlet Presenter *presenter;

@end
