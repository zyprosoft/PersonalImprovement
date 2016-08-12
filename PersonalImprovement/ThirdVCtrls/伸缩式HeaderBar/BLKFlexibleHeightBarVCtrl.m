//
//  BLKFlexibleHeightBarVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/11.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "BLKFlexibleHeightBarVCtrl.h"
#import "SquareCashStyleViewController.h"
#import "FacebookStyleViewController.h"

@interface BLKFlexibleHeightBarVCtrl ()

@end

@implementation BLKFlexibleHeightBarVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)clickBtn1:(id)sender {
    SquareCashStyleViewController *ctrl = [[SquareCashStyleViewController alloc]initWithNibName:@"SquareCashStyleViewController" bundle:nil];
    [self presentViewController:ctrl animated:YES completion:nil];
}
- (IBAction)clickBtn2:(id)sender {
    FacebookStyleViewController *ctrl = [[FacebookStyleViewController alloc]initWithNibName:@"FacebookStyleViewController" bundle:nil];
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
