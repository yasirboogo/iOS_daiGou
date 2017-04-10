//
//  AppDelegate+ThirdChat.m
//  AgentSsales
//
//  Created by innofive on 17/3/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "AppDelegate+ThirdChat.h"

@implementation AppDelegate (ThirdChat)

-(void)ThirdChatApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [[RCIM sharedRCIM] initWithAppKey:RCIM_AppID];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    //测试的token会在官网的我的应用->api调试 然后往下翻，在页面底部 里面有，创建一个就好了，上线了之后使用生产环境。
    
    [[RCIM sharedRCIM] connectWithToken:RCIM_TokenID success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion
{
    return completion([[RCUserInfo alloc] initWithUserId:userId name:@"name" portrait:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2075750630,4216747848&fm=116&gp=0.jpg"]);
}

// 从 2.6.0 开始 IMKit 可以缓存用户信息到数据库里，开发者可以开启 RCIM.h 里的enablePersistentUserInfoCache (当然也可以不用写这个，个人感觉没有什么显著的用处)
//[RCIM sharedRCIM].enablePersistentUserInfoCache = YES;

@end
