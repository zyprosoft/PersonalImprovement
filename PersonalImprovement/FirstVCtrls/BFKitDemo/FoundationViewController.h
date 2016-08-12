//
//  FoundationViewController.h
//  BFKitDemo
//
//  Created by Fabrizio on 08/09/14.
//  Copyright (c) 2014 Fabrizio Brancati. All rights reserved.
//

@import UIKit;
@class BFKitVCtrl;

@interface FoundationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak,nonatomic)BFKitVCtrl *bfKitVCtrl;

@end
