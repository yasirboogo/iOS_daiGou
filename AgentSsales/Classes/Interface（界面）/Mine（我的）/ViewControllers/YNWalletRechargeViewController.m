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

@interface YNWalletRechargeViewController ()

@property (nonatomic,copy) NSString * rechargeMoney;

@property (nonatomic,copy) NSString * btnTitle;

@property (nonatomic,weak) YNWalletAccountView * accountView;

@property (nonatomic,weak) YNPaymentTableView * tableView;

@property (nonatomic,weak) UIButton * rechargeBtn;

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
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求

#pragma mark - 视图加载
-(YNWalletAccountView *)accountView{
    if (!_accountView) {
        YNWalletAccountView *accountView = [[YNWalletAccountView alloc] init];
        _accountView = accountView;
        [self.view addSubview:accountView];
        [accountView setAccountTextFieldBlock:^(NSString *str) {
            self.rechargeMoney = str;
            [self handleRechargeButtonWithStasus:_rechargeBtn.enabled];
            
        }];
        [accountView setTipsLabelClickBlock:^{
            NSLog(@"优惠劵");
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
        [tableView setDidSelectPaymentCellBlock:^(NSString *str) {
            [self handleRechargeButtonWithStasus:YES];
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
-(void)rechargeButtonClick:(UIButton*)btn{
    YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
    pushVC.titleStr = @"支付成功";
    [self.navigationController pushViewController:pushVC animated:NO];
}
-(void)makeData{
    [super makeData];
    
    self.accountView.accountNumber = @"123456789";
    
    self.tableView.dataArray = @[@{@"image":@"zhifubao",@"payment":@"第三方国际支付"},
                                 @{@"image":@"weixin",@"payment":@"微信支付"}];
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    [self addNavigationBarBtnWithTitle:@"充值说明" selectTitle:@"充值说明" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        
    }];

    self.titleLabel.text = @"钱包充值";
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
    return [NSString stringWithFormat:@"%@ %@ %@",@"完成付款",@"$",self.rechargeMoney];
}
#pragma mark - 其他

@end
