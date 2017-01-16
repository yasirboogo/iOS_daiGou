//
//  YNWalletExchangeViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNWalletExchangeViewController.h"
#import "YNPaySuccessViewController.h"
#import "YNChangeMoneyTableView.h"
//#import "YNChangeMoneyView.h"
#import "YNWalletTableView.h"

@interface YNWalletExchangeViewController ()

/** 持有/兑换货币 */
@property (nonatomic,weak) YNChangeMoneyTableView * changeMoneyTableView;
/** 汇率 */
@property (nonatomic,weak) YNWalletTableView * walletTableView;
/** 确认兑换按钮 */
@property (nonatomic,weak) UIButton * submitBtn;

@end

@implementation YNWalletExchangeViewController


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
-(YNChangeMoneyTableView *)changeMoneyTableView{
    if (!_changeMoneyTableView) {
        YNChangeMoneyTableView *changeMoneyTableView = [[YNChangeMoneyTableView alloc] init];
        _changeMoneyTableView = changeMoneyTableView;
        [self.view addSubview:changeMoneyTableView];
    }
    return _changeMoneyTableView;
}
-(YNWalletTableView *)walletTableView{
    if (!_walletTableView) {
        CGRect frame = CGRectMake(W_RATIO(20),MaxYF(_changeMoneyTableView), SCREEN_WIDTH-W_RATIO(20)*2, W_RATIO(100)*2+W_RATIO(84));
        YNWalletTableView *walletTableView = [[YNWalletTableView alloc] initWithFrame:frame];
        _walletTableView = walletTableView;
        [self.view addSubview:walletTableView];
        walletTableView.isHaveLine = NO;
        walletTableView.layer.masksToBounds = YES;
        walletTableView.layer.cornerRadius = W_RATIO(20);
        
    }
    return _walletTableView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:@"确认兑换" forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleConfirmSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
#pragma mark - 代理实现
-(void)handleConfirmSubmitButtonClick:(UIButton*)btn{
    YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
    pushVC.titleStr = @"兑换成功";
    [self.navigationController pushViewController:pushVC animated:NO];
}
#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    
    [self changeMoneyTableView];
    
    self.walletTableView.itemTitles = @[@"人民币(主)",@"买进",@"卖出"];
    
    self.walletTableView.dataArray = @[
                                       @{@"image":@"malaixiya_guoqi",@"country":@"马来西亚币",@"buyIn":@"0.6545",@"sellOut":@"1.6057"},
                                       @{@"image":@"meiguo_guoqi",@"country":@"美元",@"buyIn":@"5.1457",@"sellOut":@"20.1457"}];
}

-(void)makeNavigationBar{
    [super makeNavigationBar];
    
    [self addNavigationBarBtnWithTitle:@"兑换说明" selectTitle:@"兑换说明" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {

    }];

    self.titleLabel.text = @"货币兑换";
}
-(void)makeUI{
    [super makeUI];
    
    
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载
-(void)setBalanceMoney:(NSString *)balanceMoney{
    _balanceMoney = balanceMoney;
}
#pragma mark - 其他

@end
