//
//  ThirdShare.h
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdShare : NSObject

// 在应用启动的时候调用
+ (void)setupWithOption:(NSDictionary *)launchingOption
                 appKey:(NSString *)appKey
                channel:(NSString *)channel
       apsForProduction:(BOOL)isProduction
  advertisingIdentifier:(NSString *)advertisingId;


@end
