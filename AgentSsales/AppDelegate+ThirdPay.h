//
//  AppDelegate+ThirdPay.h
//  AgentSsales
//
//  Created by innofive on 17/2/27.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"

@interface AppDelegate (ThirdPay)<WXApiDelegate>

-(void)ThirdPayApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
