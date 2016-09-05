//
//  ZYChatVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/9/5.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "ZYChatVCtrl.h"

#import "GJGCRecentChatViewController.h"
#import "GJGCMyHomePageViewController.h"
#import "GJGCPublicGroupListViewController.h"
#import "HALoginViewController.h"
#import "BTTabBarRootController.h"
#import "GJGCChatSystemNotiReciever.h"

#define EaseMobAppKey     @"zyprosoft#zychat"

@interface ZYChatVCtrl ()

@property (nonatomic,strong)UINavigationController *loginNav;

@end

@implementation ZYChatVCtrl

- (void)logOutAction
{
    if (!self.loginNav) {
        
        HALoginViewController *loginVC = [[HALoginViewController alloc]init];
        loginVC.title = @"iOS码农之家";
        
        self.loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        
        UIImage *navigationBarBack = GJCFQuickImageByColorWithSize([GJGCCommonFontColorStyle mainThemeColor], CGSizeMake(GJCFSystemScreenWidth * GJCFScreenScale, 64.f * GJCFScreenScale));
        [self.loginNav.navigationBar setBackgroundImage:navigationBarBack forBarMetrics:UIBarMetricsDefault];
    }
    if (self.window.rootViewController) {
        self.window.rootViewController = nil;
    }
    KCurrentWindow.rootViewController = self.loginNav;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //注册环信
    EMOptions *options = [EMOptions optionsWithAppkey:EaseMobAppKey];
    options.apnsCertName = @"zychat_apns";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient sharedClient] dataMigrationTo3];
    
    HALoginViewController *loginVC = [[HALoginViewController alloc]init];
    loginVC.title = @"iOS码农之家";
    
    self.loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    
    UIImage *navigationBarBack = GJCFQuickImageByColorWithSize([GJGCCommonFontColorStyle mainThemeColor], CGSizeMake(GJCFSystemScreenWidth * GJCFScreenScale, 64.f * GJCFScreenScale));
    [self.loginNav.navigationBar setBackgroundImage:navigationBarBack forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController pushViewController:self.loginNav];
    
    //观察登录结果
    [GJCFNotificationCenter addObserver:self selector:@selector(observeLoginStatus:) name:ZYUserCenterLoginEaseMobSuccessNoti object:nil];
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
}

- (void)setupTab
{
    BTTabBarRootController *tabBar = [[BTTabBarRootController alloc]init];
    
    self.window.rootViewController = tabBar;
}

- (void)observeLoginStatus:(NSNotification *)noti
{
    NSInteger state = [noti.object[@"state"] integerValue];
    
    if (state == 0) {
        
        BTToast(@"登陆失败");
    }
    
    if (state == 1) {
        
        BTToast(@"登录成功");
        
        //启动系统消息收发
        [[GJGCChatSystemNotiReciever shareReciever] systemAssistConversation];
        
        [self setupTab];
    }
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
