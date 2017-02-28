//
//  ThirdShare.m
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "ThirdShare.h"
#import "WXApi.h"

@interface ThirdShare ()<WXApiDelegate>

@end

@implementation ThirdShare

+(void)setupWithOption:(NSDictionary *)launchingOption appKey:(NSString *)appKey channel:(NSString *)channel apsForProduction:(BOOL)isProduction advertisingIdentifier:(NSString *)advertisingId{
    
    [WXApi registerApp:@"wx1234567890"];//此为申请下来的key一般以wx开头
    
    
    
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)onResp:(BaseResp *)resp {
    
    //把返回的类型转换成与发送时相对于的返回类型,这里为SendMessageToWXResp
    SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
    
    //使用UIAlertView 显示回调信息
    NSString *str = [NSString stringWithFormat:@"%d",sendResp.errCode];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"回调信息" message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertview show];
}
+(void)thirdShareWithType:(NSInteger)type title:(NSString*)title description:(NSString*)description image:(UIImage*)image url:(NSString*)url{
    if (type == 1) {
        SendMessageToWXReq *sendWXReq = [[SendMessageToWXReq alloc] init];
        sendWXReq.bText = NO;//不使用文本信息
        sendWXReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
        //创建分享内容对象
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = title;//分享标题
        urlMessage.description = description;//分享描述
        [urlMessage setThumbImage:image];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
        //创建多媒体对象
        WXWebpageObject *wxbObj = [WXWebpageObject object];
        wxbObj.webpageUrl = url;//分享链接
        //完成发送对象实例
        urlMessage.mediaObject = wxbObj;
        sendWXReq.message = urlMessage;
        //发送分享信息
        [WXApi sendReq:sendWXReq];
    }else if (type == 2){
        
    }else if (type == 3){
        
    }else if (type == 4){
        
    }else if (type == 5){
        
    }else if (type == 6){
        
    }
}
@end
