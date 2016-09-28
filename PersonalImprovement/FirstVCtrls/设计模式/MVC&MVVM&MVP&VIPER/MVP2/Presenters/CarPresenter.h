//
//  CarPresenter.h
//

#import <Foundation/Foundation.h>
#import "Presenter.h"

// 继承自Presenter
@interface CarPresenter : Presenter

// 将PresenterTableViewCell中的所有子控件都拖拽属性到了此类中
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modalLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;

@end
