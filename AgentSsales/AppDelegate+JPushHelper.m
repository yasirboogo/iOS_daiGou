//
//  AppDelegate+JPushHelper.m
//  ExerciseDiet
//
//  Created by innofive on 16/12/13.
//  Copyright © 2016年 innofive. All rights reserved.
//

#import "AppDelegate+JPushHelper.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#define JPushSDK_AppKey  @"a49f08e8dd65a4140029300c"
#define isProduction     NO

@implementation AppDelegate (JPushHelper)

-(void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    //Required
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    NSSet *categories = nil;// 可以添加自定义categories
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:categories];
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:JPushSDK_AppKey
                          channel:@"App Store"
                 apsForProduction:isProduction];
    
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    if (application.applicationState == UIApplicationStateActive) {//前台信息
        
        NSDictionary *options = @{
                                  kCRToastTextKey : userInfo[@"aps"][@"alert"],
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor redColor],
                                  kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                                  kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                                  kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionLeft),
                                  kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionRight)
                                  };
        [CRToastManager showNotificationWithOptions:options
                                     apperanceBlock:^(void) {
                                         NSLog(@"Appeared");
                                     }
                                    completionBlock:^(void) {
                                        NSLog(@"Completed");
                                    }];
    }else{//后台信息
        
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark 获取当前的停留的VC用来实现任意页面跳转到指定页面
- (UIViewController *)currentViewController{
    UIViewController *currVC =nil;
    UIViewController *Rootvc =self.window.rootViewController;
    do{
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)Rootvc;
            UIViewController *v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if ([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController *tabvc = (UITabBarController *)Rootvc;
            currVC = tabvc;
            Rootvc = [tabvc.viewControllers objectAtIndex:tabvc.selectedIndex];
            continue;
        }
        
    }while (Rootvc !=nil);
    return currVC;
}

@end
