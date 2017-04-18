//
//  YNHttpManagers.h
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YNHttpManagers : NSObject


+(void)setupHttpTool;

/**
 1.1用户注册
 */
+(void)userRegisterInforWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 1.2用户登录
 */
+(void)userLoginInforWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 1.3推送
 */
+(void)pushToUserWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 1.4忘记密码
 */
+(void)forgetPasswordWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 1.5短信验证码
 */
+(void)getMsgCodeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 1.6获取国家
 */
+(void)getCountryCodeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 1.7设置推送
 */
+(void)setPushMsgWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 1.8意见反馈
 */
+(void)sendSuggestWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 1.9常见问题
 */
+(void)commonProblemWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.1个人信息页面
 */
+(void)getUserInforsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.2修改密码
 */
+(void)updateUserPwdWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.3修改手机号
 */
+(void)updateUserPhoneWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.4修改个人资料
 */
+(void)updateUserInforsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.5我的订单列表
 */
+(void)getUserOrderListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.6取消订单
 */
+(void)cancelUserOrderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.7提醒发货
 */
+(void)promptShipmentWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.8确认发货
 */
+(void)confirmShipmentWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.9查看物流
 */
+(void)viewLogisticsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.10再来一单
 */
+(void)anotherOrderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.11我的收藏
 */
+(void)getUserCollectionWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.12编辑我的收藏
 */
+(void)editUserCollectionWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.13我的分销
 */
+(void)getUserDistributionWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.14分销记录
 */
+(void)getDistributionRecordWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.15我的钱包
 */
+(void)getUserWalletWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.16兑换汇率
 */
+(void)getExchangeRateWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.17兑换
 */
+(void)startExchangeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.18我的优惠券
 */
+(void)getUserCouponWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.19我的地址列表
 */
+(void)getUserAddressListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.20设为默认地址
 */
+(void)setDefaultAddressWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.21新增或者保存地址
 */
+(void)saveNewAddressWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.22删除地址
 */
+(void)delectUserAddressWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.23修改头像
 */
+(void)changeUserImageWithImage:(UIImage*)img Params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.24订单详情
 */
+(void)getOrderDetailWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.25去付款页面
 */
+(void)startPlanPayWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 2.26获取地址
 */
+(void)getProvincesWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 3.1资讯分类
 */
+(void)getAllNewsClassWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 3.2资讯列表
 */
+(void)getOneNewsListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 3.3资讯详情
 */
+(void)getOneNewsDetailWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 3.4点赞资讯
 */
+(void)startLikeNewsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 3.5资讯评论
 */
+(void)getCommentNewsListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 3.6评论资讯保存
 */
+(void)saveUserCommentWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 4.1购物车列表
 */
+(void)getShoppingCartListWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 4.2提交订单页面
 */
+(void)startSubmitOrderWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 4.3获取运费方式
 */
+(void)getFreightWaysWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 4.4编辑我的购物车
 */
+(void)startDelectGoodsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 4.5完善资料保存
 */
+(void)prefectUserInforWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 4.6修改购物车数量
 */
+(void)changeGoodsNumWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.1首页广告
 */
+(void)getAdvertiseWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.2热门分类
 */
+(void)getHotClassWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.3特色惠购
 */
+(void)getSpecialPurchaseWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.4商品详情
 */
+(void)getGoodsDetailsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.5商品收藏
 */
+(void)collectGoodsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.6选择款式
 */
+(void)selectGoodsTypeWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.7加入购物车
 */
+(void)joinToShoppingCartWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.8分享记录保存
 */
+(void)shareToThirdWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.9按分类查询商品
 */
+(void)goodsClassSearchWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.10商品搜索
 */
+(void)searchGoodsWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 5.11商品搜索关键字
 */
+(void)saveSearchKeysWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 6.1微信and支付宝代购
 */
+(void)startPayMoneyParameter1WithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 6.1微信and支付宝平台
 */
+(void)startPayMoneyParameter2WithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 6.2充值
 */
+(void)startRechargeMoneyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 6.3付款邮费
 */
+(void)startPayMoneyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 6.4立即购买提交页面
 */
+(void)buyNowToSubmitWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 6.5立即支付
 */
+(void)payNowMoneyWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
@end
