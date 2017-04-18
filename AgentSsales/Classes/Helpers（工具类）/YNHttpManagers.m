//
//  YNHttpManagers.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNHttpManagers.h"
#import "AFHTTPSessionManager.h"

#define kSetCache YES


@implementation YNHttpManagers

+(void)setupHttpTool{
    [HttpTool updateBaseUrl:kBaseUrl];
    [HttpTool enableInterfaceDebug:NO];
    [HttpTool setTimeout:15.0f];
    //[HttpTool configCommonHttpHeaders:nil];
    [HttpTool clearCaches];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
}

+(void)handleRequestWithUrl:(NSString*)url refreshCache:(BOOL)refreshCache params:params Success:(void (^)(id response))success failure:(void (^)(NSError *error))failure isTipsSuccess:(BOOL)isTipsSuccess isTipsFailure:(BOOL)isTipsFailure{
    [SVProgressHUD showWithStatus:@"loading"];
    [HttpTool getWithUrl:url refreshCache:refreshCache params:params success:^(id response) {
        success(response);
        [SVProgressHUD dismissWithDelay:0.5f completion:^{
            if ([response[@"code"] isEqualToString:@"success"]) {
                if (isTipsSuccess) {
                    [SVProgressHUD showImage:nil status:LocalLoadSuccess];
                    [SVProgressHUD dismissWithDelay:2.0f];
                }
            }else{
                if (isTipsFailure){
                    [SVProgressHUD showImage:nil status:response[@"message"]];
                    [SVProgressHUD dismissWithDelay:2.0f];
                }
            }
        }];
    } fail:^(NSError *error) {
        failure(error);
        [SVProgressHUD dismissWithDelay:0.5f completion:^{
            [SVProgressHUD showImage:nil status:LocalLoadError];
            [SVProgressHUD dismissWithDelay:2.0f];
        }];
    }];
}

/**
 1.1用户注册
 http://192.168.1.138/daigou/app/appUserController/register.do?loginphone=15820355704&password=123123&country=中国
 loginphone:手机号
 password:密码
 country:国家
 parentId(选填):推荐id
 */
+(void)userRegisterInforWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/register.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 1.2用户登录
 http://192.168.1.138/daigou/app/appUserController/login.do?loginphone=15820355704&password=123123
 params:
 loginphone:手机号
 password:密码
 */
+(void)userLoginInforWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/login.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:NO];
}
/**
 1.3推送
 http://192.168.1.138/daigou/app/appUserController/ispush.do?userId=3&ispush=1215454214545
 params:
 userId:用户id
 ispush:推送id
 */
+(void)pushToUserWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/ispush.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:NO];
}
/**
 1.4忘记密码
 
 http://192.168.1.138/daigou/app/appUserController/forgotPassword.do?phone=15820355704&password=123456
 params:
 phone:用户id
 password:密码
 */
+(void)forgetPasswordWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/forgotPassword.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 1.5短信验证码
 
 http://192.168.1.138/daigou/app/appUserController/send_short_message.do?loginphone=15820355714&type=1
 params:
 loginphone:手机号码
 type:国家，1中国，2马来西亚
 */
+(void)getMsgCodeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/send_short_message.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:NO];
}
/**
 1.6获取国家
 http://192.168.1.138/daigou/app/appUserController/myNation.do?type=0
 params:
 type:语言:0国语1马来语2英语
 */

+(void)getCountryCodeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/myNation.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 1.7设置推送
 http://192.168.1.138/daigou/app/appUserController/setPush.do?userId=3&type=0
 params:
 userId:用户Id
 type:0不需要1需要
 */
+(void)setPushMsgWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/setPush.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 1.8意见反馈
 http://192.168.1.138/daigou/app/appUserController/feedback.do?userId=3&content=哈哈
 params:
 userId:用户Id
 content:内容
 */
+(void)sendSuggestWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/feedback.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 1.9常见问题
 http://192.168.1.138/daigou/app/appUserController/problem.do?type=0&status=2
 params:
 type:语言:0国语1马来语2英语
 status:1常见问题2分销规则3兑换说明
 */
+(void)commonProblemWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/problem.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.1个人信息页面
 http://192.168.1.138/daigou/app/appUserController/personalData.do?userId=3
 params:
 userId:用户id
 */
+(void)getUserInforsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/personalData.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.2修改密码
 http://192.168.1.138/daigou/app/appUserController/updatePassword.do?userId=3&oldPassword=123456&newPassword=123456
 params:
 userId:用户id
 oldPassword:旧密码
 newPassword:新密码
 */
+(void)updateUserPwdWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/updatePassword.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.3修改手机号
 http://192.168.1.138/daigou/app/appUserController/updatePhone.do?phone=15820355704&userId=3
 params:
 userId:用户id
 phone:电话号码
 */
+(void)updateUserPhoneWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/updatePhone.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.4修改个人资料
 http://192.168.1.138/daigou/app/appUserController/personUpdate.do?userId=3&userimg=111.jpg&nickname=哈哈
 params:
 userId:用户id
 idcardId:身份证号
 nickname:用户昵称
 */
+(void)updateUserInforsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/personUpdate.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.5我的订单列表
 http://192.168.1.138/daigou/app/appOrderController/myOrderList.do?userId=3&orderStatus=0&pageIndex=1&pageSize=10&type=0
 params:
 userId:用户id
 orderStatus:订单状态0全部1待处理2待付款3待发货4待收货5已完成
 pageIndex:当前页
 pageSize:显示条数
 type:语言0中国1马来2英文
 */
+(void)getUserOrderListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appOrderController/myOrderList.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.6取消订单
 http://192.168.1.138/daigou/app/appOrderController/cancelOrder.do?orderId=2
 params:
 orderId:订单id
 */
+(void)cancelUserOrderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appOrderController/cancelOrder.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.7提醒发货
 http://192.168.1.138/daigou/app/appOrderController/isAlert.do?orderId=1
 params:
 orderId:订单id
 */
+(void)promptShipmentWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appOrderController/isAlert.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.8确认收货
 http://192.168.1.138/daigou/app/appOrderController/confirmOrder.do?orderId=1
 params:
 orderId:订单id
 */
+(void)confirmShipmentWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appOrderController/confirmOrder.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.9查看物流
 http://192.168.1.138/daigou/app/appOrderController/courierinfo.do?orderId=1
 params:
 orderId:订单id
 */
+(void)viewLogisticsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appOrderController/courierinfo.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.10再来一单
 http://192.168.1.138/daigou/app/appOrderController/againOrder.do?orderId=346&type=0
 params:
 orderId:订单id
 type:语言:0国语1马来语2英语
 */
+(void)anotherOrderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appOrderController/againOrder.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.11我的收藏
 http://192.168.1.138/daigou/app/appUserController/myCollection.do?userId=3&pageIndex=1&pageSize=10&type=0
 params:
 userId:用户id
 pageIndex:当前页
 pageSize:显示的条数
 type:语言:0国语1马来语2英语
 */
+(void)getUserCollectionWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/myCollection.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.12编辑我的收藏
 http://192.168.1.138/daigou/app/appUserController/editCollection.do?collectionId=2,3,4,5,6
 params:
 collectionId:收藏id,多个用逗号拼接过来
 */
+(void)editUserCollectionWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/editCollection.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.13我的分销
 http://192.168.1.138/daigou/app/appUserController/myDistribution.do?userId=3
 params:
 userId:用户id
 */
+(void)getUserDistributionWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/myDistribution.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.14分销记录
 http://192.168.1.138/daigou/app/appUserController/distributionRecord.do?userId=3&pageIndex=1&pageSize=10
 params:
 userId:用户id
 pageIndex:当前页
 pageSize:显示条数
 */
+(void)getDistributionRecordWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/distributionRecord.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.15我的钱包
 http://192.168.1.138/daigou/app/appUserController/myWallet.do?userId=3
 params:
 userId:用户id
 */
+(void)getUserWalletWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/myWallet.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.16兑换汇率
 http://192.168.1.138/daigou/app/appUserController/exchange.do?type=0
 params:
 type:1只有二种人民币汇率0所有汇率
 */
+(void)getExchangeRateWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/exchange.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.17兑换
 http://192.168.1.138/daigou/app/appUserController/convert.do?userId=3&rateId=0.6578&cId=1&eId=2&money=100
 params:
 userId:用户id
 rateId:汇率
 cId:兑换币种1人民币2美元3马来西亚币
 eId:被兑换币种1人民币2美元3马来西亚币
 money:兑换金额
 */
+(void)startExchangeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/convert.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.18我的优惠券
 http://192.168.1.138/daigou/app/appUserController/coupons.do?userId=3&pageIndex=1&pageSize=10&status=2,3
 params:
 userId:用户id
 pageIndex:当前页
 pageSize:显示条数
 status:1可使用,2已过期,3已使用
 type:1人民币2马来西亚币3美元
 */
+(void)getUserCouponWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/coupons.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.19我的地址列表
 http://192.168.1.138/daigou/app/appUserController/myAddress.do?userId=3&pageIndex=1&pageSize=10
 params:
 userId:用户id
 pageIndex:当前页
 pageSize:显示条数
 */
+(void)getUserAddressListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/myAddress.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.20设为默认地址
 http://192.168.1.138/daigou/app/appUserController/defaultAddress.do?addressId=1
 params:
 addressId:地址id
 */
+(void)setDefaultAddressWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/defaultAddress.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:YES isTipsFailure:YES];
}
/**
 2.21新增或者保存地址
 修改请求路径:
 http://192.168.1.138/daigou/app/appUserController/editorAddress.do?userid=3&name=%E7%9C%9F%E5%BF%83%E7%B4%AF&phone=14564872121&country=3357&province=1593&city=1594&area=1597&detailed=%E6%B5%B7%E5%A4%96&email=978392564@qq.com
  保存请求路径:
 http://192.168.1.138/daigou/app/appUserController/editorAddress.do?userid=3&name=%E7%9C%9F%E5%BF%83%E7%B4%AF&phone=14564872121&province=1593&city=1594&area=1597&detailed=%E6%B5%B7%E5%A4%96&email=978392564
 params:
 name:收货人名称
 phone:电话号码
 country:国
 province:省
 city:市
 area:区
 email:邮箱
 detailed:详细地址
 userid:用户id
 id:地址id
 */
+(void)saveNewAddressWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/editorAddress.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:NO];
}
/**
 2.22删除地址
 http://192.168.1.138/daigou/app/appUserController/deleteAddress.do?addressId=3
 params:
 addressId:地址id
 */
+(void)delectUserAddressWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appUserController/deleteAddress.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.23修改头像
 http://192.168.1.138/daigou/app/appUserController/updateHeadimg.do?userId=3&userimg=11.jpg
 params:
 userId:用户id
 userimg:用户头像
 */
+(void)changeUserImageWithImage:(UIImage*)img Params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    [HttpTool uploadWithImage:img url:@"appUserController/updateHeadimg.do?" filename:nil name:@"userimg" mimeType:@"image/jpg/png/jpeg" parameters:params progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
    } success:^(id response) {
        success(response);
    } fail:^(NSError *error) {
        failure(error);
    }];
}
/**
 2.24订单详情
 http://192.168.1.138/daigou/app/appOrderController/orderDetails.do?orderId=4&type=0
 params:
 orderId:订单id
 type:0国语1马来语2英语
 */
+(void)getOrderDetailWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appOrderController/orderDetails.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.25去付款页面
 http://192.168.1.138/daigou/app/appOrderController/payment.do?orderId=4&type=0
 params:
 orderId:订单id
 type:0国语1马来语2英语
 */
+(void)startPlanPayWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appOrderController/payment.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 2.26获取地址
 http://192.168.1.138/daigou/app/appIndexController/provinces.do?code=0&type=0
 params:
 type:0国语1马来语2英语
 code:0国家
 */
+(void)getProvincesWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/provinces.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 3.1资讯分类
 http://192.168.1.138/daigou/app/appIndexController/informationClass.do?type=0
 params:
 type:0国语1马来语2英语
 */
+(void)getAllNewsClassWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/informationClass.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 3.2资讯列表
 http://192.168.1.138/daigou/app/appIndexController/informationList.do?type=0&infoId=1&pageIndex=1&pageSize=10
 params:
 infoId:资讯分类id
 type:0国语1马来语2英语
 pageIndex:当前页
 pageSize:显示条数
 */
+(void)getOneNewsListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/informationList.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 3.3资讯详情
 http://192.168.1.138/daigou/app/appIndexController/informationDetails.do?userId=3&messageId=1&type=0
 params:
 userId:用户id
 messageId:资讯id
 type:0国语1马来语2英语
 */
+(void)getOneNewsDetailWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/informationDetails.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 3.4点赞资讯
 http://192.168.1.138/daigou/app/appIndexController/islike.do?messageId=1&userId=3
 params:
 userId:用户id
 messageId:资讯id
 */
+(void)startLikeNewsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/islike.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 3.5资讯评论
 http://192.168.1.138/daigou/app/appIndexController/infoReview.do?messageId=1&pageIndex=1&pageSize=10
 params:
 messageId:资讯id
 pageIndex:当前页
 pageSize:显示条数
 type:0国语1马来语2英语
 */
+(void)getCommentNewsListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/infoReview.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 3.6评论资讯保存
 http://192.168.1.138/daigou/app/appIndexController/saveInfo.do?infoId=1&userId=3&content=带着你
 params:
 infoId:资讯id
 userId:用户id
 content:评论内容
 */
+(void)saveUserCommentWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/saveInfo.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 4.1购物车列表
 http://192.168.1.138/daigou/app/appShoppingController/shoppingList.do?userId=3&status=1&type=0
 params:
 userId:用户id
 type:0国语1马来语2英语
 status:状态1代购商品2平台商品
 */
+(void)getShoppingCartListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appShoppingController/shoppingList.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 4.2提交订单页面
 http://192.168.1.138/daigou/app/appShoppingController/submitOrders.do?userId=3&shoppingId=1,2&type=0&status=2
 params:
 shoppingId:id
 userId:用户id
 type:0国语1马来语2英语
 status:状态1代购商品2平台商品
 */
+(void)startSubmitOrderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appShoppingController/submitOrders.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:NO];
}
/**
 4.3获取运费方式
 http://192.168.1.138/daigou/app/appShoppingController/freight.do?status=2&goodsId=1,2
 params:
 goodsId:商品id多个拼接逗号
 status:1代购运送方式2平台运送方式
 */
+(void)getFreightWaysWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appShoppingController/freight.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 4.4编辑我的购物车
 http://192.168.1.138/daigou/app/appShoppingController/deleteShopping.do?shoppingId=6,7,8
 params:
 shoppingId:购物车id
 */
+(void)startDelectGoodsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appShoppingController/deleteShopping.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 4.5完善资料保存
 
 http://192.168.1.138/daigou/app/appShoppingController/saveInfo.do?userId=44&username=ss&phone=15820355704&country=3358&province=1593&city=1594&area=1597&detailed=ss&idCard=441481199504021774
 params:
 userId:用户id
 username:收货人
 phone:电话号码
 country:国家
 province:省
 city:城市
 area:地区
 detailed:详细地址
 idCard:身份证号
 */
+(void)prefectUserInforWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appShoppingController/saveInfo.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 4.6修改购物车数量
 http://192.168.1.138/daigou/app/appShoppingController/updateShopping.do?shoppingId=1&count=2
 */
+(void)changeGoodsNumWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appShoppingController/updateShopping.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.1首页广告
 http://192.168.1.138/daigou/app/appIndexController/advertising.do?status=2
 params:
 status:首页广告1推广广告2
 */
+(void)getAdvertiseWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/advertising.do";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.2热门分类
 http://192.168.1.138/daigou/app/appIndexController/hotClass.do?type=0
 params:
 type:0国语1马来语2英语
 status:1代表热门6个0全部
 */
+(void)getHotClassWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/hotClass.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.3特色惠购
 http://192.168.1.138/daigou/app/appIndexController/features.do?type=0&pageIndex=1&pageSize=10
 params:
 type:0国语1马来语2英语
 pageIndex:当前页
 pageSize:显示条数
 */
+(void)getSpecialPurchaseWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/features.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.4商品详情
 http://192.168.1.138/daigou/app/appIndexController/goodsDetails.do?type=0&goodsId=1&userId=3
 params:
 type:0国语1马来语2英语
 goodsId:商品id
 userId:用户id
 */
+(void)getGoodsDetailsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/goodsDetails.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.5商品收藏
 http://192.168.1.138/daigou/app/appIndexController/collectionGoods.do?goodsId=4&userId=3
 params:
 goodsId:商品id
 userId:用户id
 */
+(void)collectGoodsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/collectionGoods.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.6选择款式
 http://192.168.1.138/daigou/app/appIndexController/pattern.do?goodsId=6&type=0
 params:
 type:0国语1马来语2英语
 goodsId:商品id
 */
+(void)selectGoodsTypeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/pattern.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.7加入购物车
 http://192.168.1.138/daigou/app/appIndexController/joinShopping.do?goodsId=6&userId=3&count=1&style=1,2
 params:
 goodsId:商品id
 userId:用户id
 count:购买数量
 style:购买款式,购买多个款式用逗号拼接id过来
 */
+(void)joinToShoppingCartWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/joinShopping.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.8分享记录保存
 http://192.168.1.138/daigou/app/appIndexController/saveShare.do?userId=3&wayId=1
 params:
 userId:用户id
 wayId:1微信分享2qq好友分享3脸书分享4google+分享5msn分享
 */
+(void)shareToThirdWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/saveShare.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.9按分类查询商品
 http://192.168.1.138/daigou/app/appIndexController/classGoods.do?classId=1&pageIndex=1&pageSize=9&type=0
 params:
 classId:分类id
 pageIndex:当前页
 pageSize:显示条数
 type:语言
 */
+(void)goodsClassSearchWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/classGoods.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.10商品搜索
 http://192.168.1.138/daigou/app/appIndexController/goodsSearch.do?searchName=小&pageIndex=1&pageSize=9&type=0
 params:
 searchName:搜索关键字
 pageIndex:当前页
 pageSize:显示条数
 type:语言
 */
+(void)searchGoodsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/goodsSearch.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 5.11商品搜索关键字
 http://192.168.1.138/daigou/app/appIndexController/searchRecords.do?userId=24&content=后悔药
 params:
 userId:用户id
 content:搜索关键字页
 */
+(void)saveSearchKeysWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appIndexController/searchRecords.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:NO];
}
/**
 6.1微信and支付宝
 代购去付款支付宝请求路径:
 http://192.168.1.138/daigou/app/AliPayController/getParameter1.do?type=0&orderId=9
 代购支付宝请求路径:
 http://192.168.1.138/daigou/app/AliPayController/getParameter1.do?userId=3&totalprice=100&postage=10&youhui=0&delivery=ss90&shoppingId=7,8&username=ss&userphone=15820355704&address=ss&type=0
 
 平台去付款支付宝请求路径:
 http://192.168.1.138/daigou/app/AliPayController/getParameter2.do?type=0&orderId=9
 平台支付宝请求路径；
 http://192.168.1.138/daigou/app/AliPayController/getParameter2.do?userId=3&totalprice=100&postage=10&youhui=0&delivery=ss90&shoppingId=15,16&username=ss&userphone=15820355704&address=ss&goodsId=6,7&type=0
 params:
 type:支付类型
 orderId:订单id
 userId:用户id
 totalprice:订单价格
 realprice:实付价格
 postage:运费
 youhui:优惠金额
 delivery:运输方式
 shoppingId:购买的购物车id
 username:收货人
 userphone:电话号码
 address:详细地址
 goodsId:商品id
 status:1人民币支付2马币3美元
 */
+(void)startPayMoneyParameter1WithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"AliPayController/getParameter1.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
+(void)startPayMoneyParameter2WithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"AliPayController/getParameter2.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 6.2充值
 http://192.168.1.138/daigou/app/AliPayController/getBalance.do?type=0&totalprice=100&userId=3&status=1
 http://192.168.1.138/daigou/app/AliPayController/getBalance.do?type=1&totalprice=100&userId=3&status=1
 http://192.168.1.138/daigou/app/AliPayController/getBalance.do?type=2&totalprice=100&userId=3&status=1
 params:
 userId:用户id
 totalprice:订单价格
 type:充值方式0支付宝1微信2马来西亚网银
 status:充值那种币种1人民币2马来西亚3美元
 */
+(void)startRechargeMoneyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"AliPayController/getBalance.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 6.3付款邮费
 支付宝请求路径；
 http://192.168.1.138/daigou/app/AliPayController/payPostage.do?orderId=24&totalprice=100&type=0
 params:
 orderId:订单id
 type:充值方式0支付宝1微信2马来西亚网银
 */
+(void)startPayMoneyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"AliPayController/payPostage.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
/**
 6.4立即购买提交页面
 http://192.168.1.138/daigou/app/appShoppingController/buyNow.do?userId=3&goodsId=1&count=1&type=0
 params:
 goodsId:商品id
 userId:用户id
 count:购买数量
 type:语言
 styleId:选择的款式id
 */
+(void)buyNowToSubmitWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"appShoppingController/buyNow.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:NO];
}
/**
 6.5立即支付
 http://192.168.1.138/daigou/app/AliPayController/payment.do?userId=3&totalprice=100&postage=10&youhui=0&delivery=ss90&username=ss&userphone=15820355704&address=ss&goodsId=6&type=0&count=1&style=ss,ss
 params:
 type:支付类型
 userId:用户id
 totalprice:订单价格
 postage:运费
 youhui:优惠金额
 delivery:运输方式
 username:收货人
 userphone:电话号码
 address:详细地址
 goodsId:商品id
 count:购买数量
 style:选择了款式，把名称拼接过来，比如红色;大;
 */
+(void)payNowMoneyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    NSString *url = @"AliPayController/payment.do?";
    [YNHttpManagers handleRequestWithUrl:url refreshCache:kSetCache params:params Success:^(id response) {
        success(response);
    } failure:^(NSError *error) {
        failure(error);
    } isTipsSuccess:NO isTipsFailure:YES];
}
@end
