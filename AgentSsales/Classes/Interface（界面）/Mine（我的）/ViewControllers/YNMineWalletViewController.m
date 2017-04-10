//
//  YNMineWalletViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/4.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineWalletViewController.h"
#import "YNWalletRechargeViewController.h"
#include "YNWalletExchangeViewController.h"
#import "YNMineImgHeaderView.h"
#import "YNWalletTableView.h"
#import "YNTipsSuccessBtnsView.h"
@interface YNMineWalletViewController ()

@property (nonatomic,weak) YNMineImgHeaderView *headerView;

@property (nonatomic,weak) YNWalletTableView *tableView;

@property (nonatomic,weak) YNTipsSuccessBtnsView *btnsView;

@property (nonatomic,strong) NSDictionary *allTypeMoneys;

@end

@implementation YNMineWalletViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLOR_FFFFFF;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startNetWorkingRequestWithUserWalletWithParams];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithExchangeRate];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithUserWalletWithParams{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             };
    [YNHttpManagers getUserWalletWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.allTypeMoneys = response;
            self.headerView.topNumber = [NSString stringWithFormat:@"%.2f",[response[@"rmb"] floatValue]];
            self.headerView.leftNumber = [NSString stringWithFormat:@"%.2f",[response[@"us"] floatValue]];
            self.headerView.rightNumber = [NSString stringWithFormat:@"%.2f",[response[@"myr"] floatValue]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithExchangeRate{
    NSDictionary *params = @{@"type":@1
                             };
    [YNHttpManagers getExchangeRateWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.tableView.dataArray  = response[@"parArray"];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNMineImgHeaderView *)headerView{
    if (!_headerView) {
        YNMineImgHeaderView *headerView = [[YNMineImgHeaderView alloc] init];
        _headerView = headerView;
        [self.view addSubview:headerView];
    }
    return _headerView;
}

-(YNWalletTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0,W_RATIO(560), SCREEN_WIDTH, W_RATIO(500));
        YNWalletTableView *tableView = [[YNWalletTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        tableView.isHaveLine = YES;
    }
    return _tableView;
}
-(YNTipsSuccessBtnsView *)btnsView{
    if (!_btnsView) {
        YNTipsSuccessBtnsView *btnsView = [[YNTipsSuccessBtnsView alloc] init];
        _btnsView = btnsView;
        [self.view addSubview:btnsView];
        btnsView.btnStyle = UIButtonStyle2;
        [btnsView setDidSelectBottomButtonClickBlock:^(NSString *str) {
            if ([str isEqualToString:LocalRecharge]) {
                YNWalletRechargeViewController *pushVC = [[YNWalletRechargeViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([str isEqualToString:LocalMoneyChanging]){
                YNWalletExchangeViewController *pushVC = [[YNWalletExchangeViewController alloc] init];
                pushVC.allTypeMoneys = self.allTypeMoneys;
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
    }
    return _btnsView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    
    self.headerView.topTitleLabel.text = [NSString stringWithFormat:@"%@ (%@)",LocalChineseMoney,LocalYuan];
    self.headerView.leftTitleLabel.text = [NSString stringWithFormat:@"%@ (%@)",LocalAmericanMoney,LocalDollar];
    self.headerView.rightTitleLabel.text = [NSString stringWithFormat:@"%@ (%@)",LocalMalayMoney,LocalRinggit];
    
    self.tableView.itemTitles = @[LocalExchangeRate,LocalBuyIn,LocalSellOut];
    
    self.btnsView.btnTitles = @[LocalRecharge,LocalMoneyChanging];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.navView.backgroundColor = COLOR_CLEAR;

    self.titleLabel.text = LocalMyWallet;
}
-(void)makeUI{
    [super makeUI];
    
    [self.view addSubview:self.btnsView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
