//
//  YNWalletRechargeViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNWalletRechargeViewController.h"
#import "YNPaySuccessViewController.h"
#import "YNWalletAccountView.h"
#import "YNPaymentTableView.h"
#import "YNSelectMoneyTypeTableView.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "YNMineCouponViewController.h"
#import "YNDocumentExplainViewController.h"

@interface YNWalletRechargeViewController ()

@property (nonatomic,copy) NSString * rechargeMoney;

@property (nonatomic,copy) NSString * btnTitle;

@property (nonatomic,weak) YNWalletAccountView * accountView;

@property (nonatomic,weak) YNPaymentTableView * tableView;

@property (nonatomic,weak) YNSelectMoneyTypeTableView * showMoneyType;

@property (nonatomic,weak) UIButton * rechargeBtn;

@property (nonatomic,assign) NSInteger statusIndex;

@property (nonatomic,assign) NSInteger typeIndex;

@end

@implementation YNWalletRechargeViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
-(void)startNetWorkingRequestWithStartRechargeMoney{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"totalprice":_rechargeMoney,
                             @"type":[NSNumber numberWithInteger:_typeIndex],
                             @"status":[NSNumber numberWithInteger:_statusIndex+1]};
    [YNHttpManagers startRechargeMoneyWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            if (self.typeIndex == 0) {
                [[AlipaySDK defaultService] payOrder:response[@"str"] fromScheme:@"ap20170316233959" callback:^(NSDictionary *resultDic) {
                    NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
                    if (resultStatus == 9000) {
                        YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
                        pushVC.type = 1;
                        [self.navigationController pushViewController:pushVC animated:NO];
                    }else if (resultStatus == 8000){
                        NSLog(@"正在处理中");
                    }else if (resultStatus == 4000){
                        NSLog(@"订单支付失败");
                    }else if (resultStatus == 6001){
                        NSLog(@"用户中途取消");
                    }else if (resultStatus == 6002){
                        NSLog(@"网络连接出错");
                    }
                }];
            }else if (self.typeIndex == 1){
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
            }else if (self.typeIndex == 2){
                
            }
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNSelectMoneyTypeTableView *)showMoneyType{
    if (!_showMoneyType) {
        CGRect frame = CGRectMake(kMidSpace, kUINavHeight+W_RATIO(20)+W_RATIO(410), SCREEN_WIDTH-kMidSpace*2, W_RATIO(80)*3);
        YNSelectMoneyTypeTableView *showMoneyType = [[YNSelectMoneyTypeTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _showMoneyType = showMoneyType;
        [self.view addSubview:showMoneyType];
        NSArray *moneyType = @[LocalChineseMoney,LocalMalayMoney,LocalAmericanMoney];
        NSArray *markType = @[LocalYuan,LocalRinggit,LocalDollar];
        showMoneyType.dataArray = moneyType;
        showMoneyType.index = [LanguageManager currentLanguageIndex];
        [showMoneyType setDidSelectMoneyTypeCellBlock:^(NSInteger statusIndex) {
            self.accountView.leftMomeyType = moneyType[statusIndex];
            self.accountView.rightMarkType = markType[statusIndex];
            self.accountView.isShow = NO;
            self.statusIndex = statusIndex;
            [self handleRechargeButtonWithStasus:self.rechargeBtn.enabled];
        }];
    }
    return _showMoneyType;
}
-(YNWalletAccountView *)accountView{
    if (!_accountView) {
        YNWalletAccountView *accountView = [[YNWalletAccountView alloc] init];
        _accountView = accountView;
        [self.view addSubview:accountView];
        [accountView setAccountTextFieldBlock:^(NSString *str) {
            self.rechargeMoney = str;
            [self handleRechargeButtonWithStasus:_rechargeBtn.enabled];
            
        }];
        [accountView setDidSelectLeftShowButtonBlock:^(BOOL isShow) {
            self.showMoneyType.hidden = !isShow;
        }];
        [accountView setTipsLabelClickBlock:^{
            YNMineCouponViewController *pushVC =[[YNMineCouponViewController alloc] init];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _accountView;
}
-(YNPaymentTableView *)tableView{
    if (!_tableView) {
        YNPaymentTableView *tableView = [[YNPaymentTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];
        tableView.frame = CGRectMake(XF(_accountView), MaxYF(_accountView)+kMidSpace, WIDTHF(_accountView),YF(self.rechargeBtn)-MaxYF(_accountView)-kMidSpace*2);
        [tableView setDidSelectPaymentCellBlock:^(NSInteger typeIndex) {
            [self handleRechargeButtonWithStasus:YES];
            self.typeIndex = typeIndex;
        }];
    }
    return _tableView;
}
-(UIButton *)rechargeBtn{
    if (!_rechargeBtn) {

        UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rechargeBtn = rechargeBtn;
        [self.view addSubview:rechargeBtn];
        
        [self handleRechargeButtonWithStasus:NO];
        
        [rechargeBtn addTarget:self action:@selector(rechargeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        rechargeBtn.frame = CGRectMake(0, SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
    }
    return _rechargeBtn;
}
-(void)handleRechargeButtonWithStasus:(BOOL)enable{
    _rechargeBtn.enabled = enable;
    
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
        YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
        pushVC.type = 1;
        [self.navigationController pushViewController:pushVC animated:NO];
    }else if (resultStatus == WXErrCodeCommon){/**< 普通错误类型    */
        
    }else if (resultStatus == WXErrCodeUserCancel){/**< 用户点击取消并返回    */
        
    }else if (resultStatus == WXErrCodeSentFail){/**< 发送失败    */
        
    }else if (resultStatus == WXErrCodeAuthDeny){/**< 授权失败    */
        
    }else if (resultStatus == WXErrCodeUnsupport){/**< 微信不支持    */
        
    }
}
-(void)rechargeButtonClick:(UIButton*)btn{
    if ([_rechargeMoney floatValue]>=0.01f) {
        [self startNetWorkingRequestWithStartRechargeMoney];
    }else{
        [SVProgressHUD showImage:nil status:LocalInputIsError];
        [SVProgressHUD dismissWithDelay:2.0f];
    }
}
-(void)makeData{
    [super makeData];
    
    self.accountView.accountNumber = [DEFAULTS valueForKey:kUserLoginInfors][@"loginphone"];
    
    self.tableView.dataArray = @[@{@"image":@"zhifubao",@"payment":LocalAlipay},
                                 @{@"image":@"weixin",@"payment":LocalWeichat},
                                 @{@"image":@"malaixiya_yuan",@"payment":LocalBankcard}];
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:LocalNote selectTitle:LocalNote font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        YNDocumentExplainViewController *pushVC = [[YNDocumentExplainViewController alloc] init];
        pushVC.status = 4;
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];

    self.titleLabel.text = LocalWalletRecharge;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.rechargeBtn];
}
#pragma mark - 数据懒加载
-(NSString *)rechargeMoney{
    if (!_rechargeMoney) {
        _rechargeMoney = [NSString stringWithFormat:@"0.00"];
    }
    return _rechargeMoney;
}
-(NSString *)btnTitle{
    NSArray *markArr = @[@"¥",@"M.＄",@"$"];
    return [NSString stringWithFormat:@"%@ %@ %@",LocalCompleteRecharge,markArr[self.statusIndex],self.rechargeMoney];
}
#pragma mark - 其他

@end
