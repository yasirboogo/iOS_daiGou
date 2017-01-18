//
//  MineViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#import "YNMineViewController.h"
#import "YNUpdateInforViewController.h"
#import "YNMineTableView.h"
#import "YNMineHeaderView.h"
#import "YNMineOrderViewController.h"

@interface YNMineViewController ()

@property (nonatomic,strong) YNMineHeaderView *headerView;

@property (nonatomic,weak) YNMineTableView *tableView;

@end

@implementation YNMineViewController

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
-(YNMineHeaderView *)headerView{
    if (!_headerView) {
        YNMineHeaderView *headerView = [[YNMineHeaderView alloc] init];
        _headerView = headerView;
        [self.view addSubview:headerView];
        [headerView setDidSelectScrollViewButtonClickBlock:^(NSInteger index) {
            YNMineOrderViewController *pushVC = [[YNMineOrderViewController alloc] init];
            pushVC.index = index;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _headerView;
}

-(YNMineTableView *)tableView{
    if (!_tableView) {
        YNMineTableView *tableView = [[YNMineTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];

        NSArray<NSString*> *viewControllers = @[@"YNMineCollectViewController",
                                                @"YNMineDistributionViewController",
                                                @"YNMineWalletViewController",
                                                @"YNMineCouponViewController",
                                                @"YNAddressViewController",
                                                @"YNMineCodeViewController",
                                                @"YNSettingViewController"];
        
        [tableView setDidSelectMineTableViewCellClickBlock:^(NSInteger idx) {
            YNBaseViewController *pushVC = [[NSClassFromString(viewControllers[idx]) alloc] init];
            
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.headerView.headImg = [UIImage imageNamed:@"testGoods"];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.navView.backgroundColor = COLOR_CLEAR;
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"gerenziliao"] selectImg:nil isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        YNUpdateInforViewController *pushVC = [[YNUpdateInforViewController alloc] init];
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
}
-(void)makeUI{
    [super makeUI];
    
    [self.view addSubview:self.tableView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
