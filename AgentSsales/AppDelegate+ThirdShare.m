//
//  AppDelegate+ThirdShare.m
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "AppDelegate+ThirdShare.h"
#import "ThirdShare.h"

#define ThirdShareSDK_AppKey  @"1b1f610a2fd51"
#define isProduction     1

@implementation AppDelegate (ThirdShare)

-(void)ThirdShareApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
    [ThirdShare setupWithOption:launchOptions appKey:ThirdShareSDK_AppKey channel:nil apsForProduction:isProduction advertisingIdentifier:nil];
    
   }

@end
