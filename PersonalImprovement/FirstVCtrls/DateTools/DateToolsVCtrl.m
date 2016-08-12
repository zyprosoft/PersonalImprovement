//
//  DateToolsVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/18.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "DateToolsVCtrl.h"
#import "DateToolsViewController.h"
#import "TimePeriodsViewController.h"
#import "Colours.h"

@interface DateToolsVCtrl ()

@end

@implementation DateToolsVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    DateToolsViewController *dtVC = [[DateToolsViewController alloc] initWithNibName:@"DateToolsViewController" bundle:nil];
    
    TimePeriodsViewController *tpVC = [[TimePeriodsViewController alloc] initWithNibName:@"TimePeriodsViewController" bundle:nil];
    
    //Initialize tab bar controller
    self.tabBarController = [[UITabBarController alloc] init];
    
    //Style tab bar
    if ([self.tabBarController.tabBar respondsToSelector:@selector(setTranslucent:)]) {
        [self.tabBarController.tabBar setTranslucent:NO];
        [self.tabBarController.tabBar setTintColor:[UIColor infoBlueColor]];
    }
    else {
        [self.tabBarController.tabBar setBackgroundColor:[UIColor infoBlueColor]];
    }
    
    //Add view controllers
    self.tabBarController.viewControllers = @[dtVC, tpVC];
    KCurrentWindow.rootViewController = self.tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
