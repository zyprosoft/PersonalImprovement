//
//  ViewController.h
//  MVCDemo-OC
//
//  Created by xyxxllh on 16/7/27.
//  Copyright © 2016年 XunLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+MVCModel.h"
#import "UIView+MVCModel.h"

@interface MVCDemoVCtrl : UIViewController

@end


@interface MVCDemoVCtrl(TableViewDelegate) <UITableViewDelegate,UITableViewDataSource>

@end

