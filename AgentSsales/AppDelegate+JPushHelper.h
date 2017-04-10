//
//  AppDelegate+JPushHelper.h
//  ExerciseDiet
//
//  Created by innofive on 16/12/13.
//  Copyright © 2016年 innofive. All rights reserved.
//

#import "AppDelegate.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
@interface AppDelegate (JPushHelper)<JPUSHRegisterDelegate>

-(void)JPushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
