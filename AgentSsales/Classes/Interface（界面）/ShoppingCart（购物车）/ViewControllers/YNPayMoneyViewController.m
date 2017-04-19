//
//  YNPayMoneyViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/20.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPayMoneyViewController.h"
#import "YNPayMoneyCollectionView.h"
#import "YNPaySuccessViewController.h"
#import "YNChangeMoneyView.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface YNPayMoneyViewController ()
{
    NSInteger _type;
}
@property (nonatomic,weak) YNPayMoneyCollectionView *collectionView;

@property (nonatomic,weak) YNChangeMoneyView *wayView;

@property (nonatomic,weak) UIButton *rechargeBtn;

@property (nonatomic,weak) NSString *btnTitle;

@property (nonatomic,assign) NSInteger statusIndex;

@property (nonatomic,assign) NSInteger typeIndex;

@end

@implementation YNPayMoneyViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithStartPlanPay];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hanleWXApiPaySuccess:) name:@"WX_PayResult" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 网路请求
-(void)startNetWorkingRequestWithStartPlanPay{
    NSDictionary *params = @{@"orderId":[NSString stringWithFormat:@"%@",_orderId],
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers startPlanPayWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            if (![NSString stringWithFormat:@"%@",self.postage].length) {
                self.collectionView.payMoney = [NSString stringWithFormat:@"%@",response[@"totalprice"]];
            }else {
                self.collectionView.payMoney = [NSString stringWithFormat:@"%@",self.postage];
            }
            self.collectionView.orderDict = response;
            [self handleRechargeButtonWithStasus:NO];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithStartPayMoney{
    NSDictionary *params = @{@"orderId":[NSString stringWithFormat:@"%@",_orderId],
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers startPayMoneyWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self handleRechargeButtonWithStasus:NO];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithStartPayMoneyParameter1{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:_typeIndex],@"type",[NSString stringWithFormat:@"%@",_orderId],@"orderId", nil];
    if (_typeIndex == 3) {
        [params setValue:[NSNumber numberWithInteger:_statusIndex+1] forKey:@"status"];
    }
    [YNHttpManagers startPayMoneyParameter1WithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            if (self.typeIndex == 0) {//支付宝
                [[AlipaySDK defaultService] payOrder:response[@"str"] fromScheme:@"ap20170316235959" callback:^(NSDictionary *resultDic) {
                    NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
                    if (resultStatus == 9000) {
                        [SVProgressHUD showImage:nil status:LocalPaySuccess];
                        [SVProgressHUD dismissWithDelay:2.0f completion:^{
                            YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
                            pushVC.type = 4;
                            [self.navigationController pushViewController:pushVC animated:NO];
                        }];
                    }else{
                        [SVProgressHUD showImage:nil status:LocalPayFailure];
                        [SVProgressHUD dismissWithDelay:2.0f];
                    }
                }];
            }else if (self.typeIndex == 1){//微信
                NSDictionary *dict = response[@"map"];
                PayReq *request = [[PayReq alloc] init];
                request.openID      =               [dict objectForKey:@"appid"];
                request.partnerId   =               [dict objectForKey:@"partnerid"];
                request.prepayId    =               [dict objectForKey:@"prepayid"];
                request.package     =               [dict objectForKey:@"package"];
                request.nonceStr    =               [dict objectForKey:@"noncestr"];
                request.timeStamp   =               [[dict objectForKey:@"timestamp"] intValue];
                request.sign        =               [dict objectForKey:@"sign"];
                BOOL isWXApi = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]];
                if (isWXApi) {
                    [WXApi sendReq:request];
                }else{
                    [SVProgressHUD showImage:nil status:LocalAppUnInstall];
                    [SVProgressHUD dismissWithDelay:2.0f];
                }
            }else if (self.typeIndex == 2){//
                
            }else if (self.typeIndex == 3){
                YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
                pushVC.type = 4;
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];

}
-(void)startNetWorkingRequestWithStartPayMoneyParameter2{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:_typeIndex],@"type",[NSString stringWithFormat:@"%@",_orderId],@"orderId", nil];
    if (_typeIndex == 3) {
        [params setValue:[NSNumber numberWithInteger:_statusIndex+1] forKey:@"status"];
    }
    [YNHttpManagers startPayMoneyParameter2WithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            if (self.typeIndex == 0) {
                [[AlipaySDK defaultService] payOrder:response[@"str"] fromScheme:@"ap20170316233959" callback:^(NSDictionary *resultDic) {
                    NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
                    if (resultStatus == 9000) {
                        [SVProgressHUD showImage:nil status:LocalPaySuccess];
                        [SVProgressHUD dismissWithDelay:2.0f completion:^{
                            YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
                            pushVC.type = 4;
                            [self.navigationController pushViewController:pushVC animated:NO];
                        }];
                    }else{
                        [SVProgressHUD showImage:nil status:LocalPayFailure];
                        [SVProgressHUD dismissWithDelay:2.0f];
                    }
                }];
            }else if (self.typeIndex == 1){
                PayReq *request = [[PayReq alloc] init];
                request.openID = response[@"appid" ];
                request.partnerId = response[@"mch_id"];
                request.prepayId= response[@"prepay_id"];
                request.package = response[@"package"];
                request.nonceStr= response[@"noncestr"];
                request.timeStamp= (UInt32)response[@"timestamp"];
                request.sign = response[@"sign"];
                BOOL isWXApi = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]];
                if (isWXApi) {
                    [WXApi sendReq:request];
                }else{
                    [SVProgressHUD showImage:nil status:LocalAppUnInstall];
                    [SVProgressHUD dismissWithDelay:2.0f];
                }
            }else if (self.typeIndex == 2){//网银
                
            }else if (self.typeIndex == 3){
                YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
                pushVC.type = 4;
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }else{
            //do failure things
            if (self.typeIndex == 3) {
                [SVProgressHUD showImage:nil status:LocalPayFailure];
                [SVProgressHUD dismissWithDelay:2.0f];
            }
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNChangeMoneyView *)wayView{
    if (!_wayView) {
        YNChangeMoneyView *wayView = [[YNChangeMoneyView alloc] initWithRowHeight:W_RATIO(120) width:W_RATIO(660) showNumber:3];
        _wayView = wayView;
        wayView.dataArray = @[@{@"title":LocalChineseMoney,@"image":@"zhongguo_yuan"},
                              @{@"title":LocalMalayMoney,@"image":@"malaixiya_yuan"},
                              @{@"title":LocalAmericanMoney,@"image":@"meiguo_yuan"}];
        wayView.typeIndex = _type;
        [wayView setDidSelectChangeWayCellBlock:^(NSInteger statusIndex) {
            self.statusIndex = statusIndex;
            [self.wayView dismissPopView:YES];
        }];
    }
    return _wayView;
}
-(YNPayMoneyCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.rechargeBtn));
        YNPayMoneyCollectionView *collectionView = [[YNPayMoneyCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        collectionView.typeIndex = _type;
        [collectionView setDidSelectPayWayCellBlock:^(NSInteger typeIndex) {
            self.typeIndex = typeIndex;
            if (typeIndex == 3) {
                [self.wayView showPopView:YES];
            }
            [self handleRechargeButtonWithStasus:YES];
        }];
    }
    return _collectionView;
}
-(UIButton *)rechargeBtn{
    if (!_rechargeBtn) {
        
        UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rechargeBtn = rechargeBtn;
        [self.view addSubview:rechargeBtn];
        
        [self handleRechargeButtonWithStasus:NO];
        
        [rechargeBtn addTarget:self action:@selector(rechargeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        rechargeBtn.frame = CGRectMake(0, SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
    }
    return _rechargeBtn;
}
-(void)handleRechargeButtonWithStasus:(BOOL)enable{
    self.rechargeBtn.enabled = enable;
    
    if (enable) {
        _rechargeBtn.backgroundColor = COLOR_DF463E;
        [_rechargeBtn setTitle:self.btnTitle forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
    }else{
        _rechargeBtn.backgroundColor = COLOR_B7B7B7;
        [_rechargeBtn setTitle:self.btnTitle forState:UIControlStateDisabled];
        [_rechargeBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateDisabled];
    }
}

#pragma mark - 代理实现

#pragma mark - 函数、消息

-(void)hanleWXApiPaySuccess:(NSNotification*)notification{
    NSInteger resultStatus = [notification.userInfo[@"code"] integerValue];
    if (resultStatus == WXSuccess) {/**< 成功    */
        [SVProgressHUD showImage:nil status:LocalPaySuccess];
        [SVProgressHUD dismissWithDelay:0.5f completion:^{
            YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
            pushVC.type = 4;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }else{
        [SVProgressHUD showImage:nil status:LocalPayFailure];
        [SVProgressHUD dismissWithDelay:2.0f ];
    }
}
-(void)rechargeButtonClick{
    if (_shopIndex == 1) {
        [self startNetWorkingRequestWithStartPayMoneyParameter1];
    }else if (_shopIndex == 2){
        [self startNetWorkingRequestWithStartPayMoneyParameter2];
    }
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    if (![NSString stringWithFormat:@"%@",self.postage].length) {
        self.titleLabel.text = LocalPayMoney;
    }else {
        self.titleLabel.text = LocalPayPostage;
    }
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载
-(NSString *)btnTitle{
    return [NSString stringWithFormat:@"%@ %@ %@",LocalFinishPay,LocalMoneyMark,_collectionView.orderDict[@"totalprice"]];
}
#pragma mark - 其他


@end
