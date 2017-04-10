//
//  YNMineDistributionViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/4.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineDistributionViewController.h"
#import "YNDocumentExplainViewController.h"
#import "YNUpdateInforViewController.h"
#import "YNDistributionTableView.h"
#import "YNMineImgHeaderView.h"

@interface YNMineDistributionViewController ()

@property (nonatomic,strong) YNMineImgHeaderView *headerView;

@property (nonatomic,weak) YNDistributionTableView *tableView;

@end

@implementation YNMineDistributionViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithUserDistribution];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithUserDistribution{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"]};
    [YNHttpManagers getUserDistributionWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.headerView.topNumber = [NSString stringWithFormat:@"%.2f",[response[@"commission"] floatValue]];
            self.headerView.leftNumber = [NSString stringWithFormat:@"%.2f",[response[@"history"] floatValue]];
            self.headerView.rightNumber = [NSString stringWithFormat:@"%@",response[@"fans"]];
            [self startNetWorkingRequestWithDistributionRecord];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithDistributionRecord{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize]};
    [YNHttpManagers getDistributionRecordWithParams:params success:^(id response) {
        [self handleEndMJRefresh];
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self handleMJRefreshComplateWithResponse:response[@"commissionArray"]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
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

-(YNDistributionTableView *)tableView{
    if (!_tableView) {
        YNDistributionTableView *tableView = [[YNDistributionTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];
        
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageIndex = 1;
            [tableView.mj_footer endRefreshing];
            [self startNetWorkingRequestWithDistributionRecord];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            [tableView.mj_header endRefreshing];
            [self startNetWorkingRequestWithDistributionRecord];
        }];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleMJRefreshComplateWithResponse:(NSArray*)response{
    if (self.pageIndex == 1) {
        _tableView.dataArrayM = [NSMutableArray arrayWithArray:response];
    }else{
        [_tableView.dataArrayM addObjectsFromArray:response];
    }
    [_tableView reloadData];
    if (response.count == 0) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}
-(void)handleEndMJRefresh{
    if (self.pageIndex == 1) {
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}
-(void)makeData{
    [super makeData];
    
    self.headerView.topTitleLabel.text = [NSString stringWithFormat:@"%@ (%@) ",LocalTotalCommiss,LocalMoneyType];
    self.headerView.leftTitleLabel.text = [NSString stringWithFormat:@"%@ (%@)",LocalHistCommiss,LocalMoneyType];
    self.headerView.rightTitleLabel.text = [NSString stringWithFormat:@"%@ (%@)",LocalMyFans,LocalPeople];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.navView.backgroundColor = COLOR_CLEAR;
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:LocalRegular selectTitle:LocalRegular font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        YNDocumentExplainViewController *pushVC = [[YNDocumentExplainViewController alloc] init];
        pushVC.status = 2;
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
        
    }];
    self.titleLabel.text = LocalMyDistribution;
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
