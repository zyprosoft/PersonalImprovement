//
//  ChatKitVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/31.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "ChatKitVCtrl.h"

#import "LCCKTabBarControllerConfig.h"
#import "LCCKConstantsDefinition.h"
#import "LCChatKitExample.h"
#import "LCCKUtil.h"
#if __has_include(<ChatKit/LCChatKit.h>)
#import <ChatKit/LCChatKit.h>
#else
#import "LCChatKit.h"
#endif
#import "LCCKLoginViewController.h"

@interface ChatKitVCtrl ()

@end

@implementation ChatKitVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addApplicationObserver];
    self.view.backgroundColor = [UIColor whiteColor];
    [LCChatKitExample invokeThisMethodInDidFinishLaunching];
    LCCKLoginViewController *loginViewController = [[LCCKLoginViewController alloc] initWithNibName:@"LCCKLoginViewController" bundle:[NSBundle mainBundle]];
    loginViewController.autoLogin = YES;
    [loginViewController setClientIDHandler:^(NSString *clientID) {
        [LCCKUtil showProgressText:@"open client ..." duration:10.0f];
        [LCChatKitExample invokeThisMethodAfterLoginSuccessWithClientId:clientID success:^{
            [LCCKUtil hideProgress];
            LCCKTabBarControllerConfig *tabBarControllerConfig = [[LCCKTabBarControllerConfig alloc] init];
//            self.window.rootViewController = tabBarControllerConfig.tabBarController;
            [self.navigationController pushViewController:tabBarControllerConfig.tabBarController animated:YES];
        } failed:^(NSError *error) {
            [LCCKUtil hideProgress];
            NSLog(@"%@",error);
        }];
    }];
    [self.navigationController pushViewController:loginViewController animated:YES];
//    self.window.rootViewController = loginViewController;
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 注册应用观察者
- (void)addApplicationObserver {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appWillResign:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
}

- (void)appWillResign:(NSNotification *)noti {
    UIApplication *application = noti.object;
    [LCChatKitExample invokeThisMethodInApplicationWillResignActive:application];
}

- (void)appWillTerminate:(NSNotification *)noti {
    UIApplication *application = noti.object;
    [LCChatKitExample invokeThisMethodInApplicationWillTerminate:application];
}

// 这两处代理方法应该在Appdelegate中调用，但是此处仅作demo展示，所以只放置代码

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [LCChatKitExample invokeThisMethodInDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [LCChatKitExample invokeThisMethodInApplication:application didReceiveRemoteNotification:userInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
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
