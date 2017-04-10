//
//  AppDelegate+FirUpdate.m
//  AgentSsales2
//
//  Created by innofive on 17/3/20.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "AppDelegate+FirUpdate.h"

#define kFirToken @"0090bc147f5c13b12438fa3e24e369fe"

#define kFirId @"58b951f6959d69207d00066b"

@implementation AppDelegate (FirUpdate)

-(void)FirUpdateApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    NSString *firUrl = [NSString stringWithFormat:@"http://api.fir.im/apps/%@/download_token?&api_token=%@",kFirId,kFirToken];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:firUrl]];
    NSURLSessionDataTask *tast = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *openUrl = [NSString stringWithFormat:@"tms-services://?action=download-manifest&url=http://download.fir.im/apps/%@/install?download_token=%@",kFirId,dict[@"download_token"]];
        NSLog(@"%@",openUrl);
        [application openURL:[NSURL URLWithString:openUrl]];
    }];
    
    BOOL isUpdate = [IOS_BUILD floatValue] > [[DEFAULTS valueForKey:@"IOS_BUILD"] floatValue] ? YES : NO;
    
    if (isUpdate) {
        [tast resume];
        [DEFAULTS setObject:IOS_BUILD forKey:@"IOS_BUILD"];
    }
}

@end
