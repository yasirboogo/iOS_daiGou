//
//  AppDelegate+ThirdChat.h
//  AgentSsales
//
//  Created by innofive on 17/3/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>

#define RCIM_SERVICE_ID @"KEFU148973091972715"

#define RCIM_AppID @"p5tvi9dspjgu4"

#define RCIM_TokenID @"z1pYxcGoCYK5X7u/+pKR8m5mfwC8mFi6M2MFrltmuPq/yGnpm/AnPw6dTUBL1YfqeJLpHDFk8qZ/tKfSaQmy8OWyk0W6KWkb"

@interface AppDelegate (ThirdChat)<RCIMUserInfoDataSource>

-(void)ThirdChatApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
