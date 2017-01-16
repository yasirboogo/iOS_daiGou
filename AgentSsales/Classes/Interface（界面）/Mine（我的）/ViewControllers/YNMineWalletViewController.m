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

@end

@implementation YNMineWalletViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLOR_FFFFFF;
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
            if ([str isEqualToString:@"充值"]) {
                YNWalletRechargeViewController *pushVC = [[YNWalletRechargeViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([str isEqualToString:@"兑换货币"]){
                YNWalletExchangeViewController *pushVC = [[YNWalletExchangeViewController alloc] init];
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
    
    self.headerView.topTitleLabel.text = @"人民币（元）";
    self.headerView.leftTitleLabel.text = @"美元（美元）";
    self.headerView.rightTitleLabel.text = @"马来西亚（令吉）";
    
    self.headerView.topNumber = @"365.12";
    
    self.headerView.leftNumber = @"50.16";
    
    self.headerView.rightNumber = @"120.52";
    
    
    self.tableView.itemTitles = @[@"实时汇率",@"买进",@"卖出"];
    
    self.tableView.dataArray = @[
                                 @{@"image":@"malaixiya_guoqi",@"country":@"马来西亚币",@"buyIn":@"0.6545",@"sellOut":@"1.6057"},
                                 @{@"image":@"meiguo_guoqi",@"country":@"美元",@"buyIn":@"5.1457",@"sellOut":@"20.1457"}];
    self.btnsView.btnTitles = @[@"充值",@"兑换货币"];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.navView.backgroundColor = COLOR_CLEAR;

    self.titleLabel.text = @"我的钱包";
}
-(void)makeUI{
    [super makeUI];
    
    [self.view addSubview:self.btnsView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
