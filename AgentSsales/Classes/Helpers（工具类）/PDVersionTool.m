//
//  PDVersionTool.m
//  Yios
//
//  Created by 潘东 on 15/10/25.
//  Copyright (c) 2015年 Dream. All rights reserved.
//

#import "PDVersionTool.h"


#define PDVersionInSandboxKey @"VersionInSandboxKey"
@implementation PDVersionTool


+(NSString *)versionInSandbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:PDVersionInSandboxKey];
}

+(NSString *)versionInInfo{
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;

    return infoDict[@"CFBundleVersion"];
}
+(void)saveVersionToSandbox{


    // 取出info的版本号
    NSString *versionInInfo = [self versionInInfo];
    
    // 保存
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:versionInInfo forKey:PDVersionInSandboxKey];
    [defaults synchronize];
}

+(BOOL)isFirstUseApp{
    // 如果是第一次使用，沙里是没有版本号
    if([self versionInSandbox]){
        return NO;
    }
    return YES;
}

+(BOOL)isNewVersion{
    // 把Info.plist的版本号与 SandBox(沙盒)版本号进行比较
    if (![[self versionInInfo] isEqualToString:[self versionInSandbox]]) {
        return YES;
    }
    
    return NO;
}


+(BOOL)needShowNewFeature{
    return ([self isFirstUseApp] || [self isNewVersion]);
}

@end
