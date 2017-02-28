//
//  YNLogisticalMsgViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNLogisticalMsgViewController.h"
#import "YNLogisticalMsgTableView.h"

@interface YNLogisticalMsgViewController ()

@property (nonatomic,weak) YNLogisticalMsgTableView * tableView;

@property (nonatomic,weak) YNShowEmptyView * emptyView;

@end

@implementation YNLogisticalMsgViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithViewLogistics];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithViewLogistics{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId]};
    [YNHttpManagers viewLogisticsWithParams:params success:^(id response) {
        self.tableView.dataArray = response;
        self.emptyView.hidden = self.tableView.dataArray.count;
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNLogisticalMsgTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        YNLogisticalMsgTableView *tableView = [[YNLogisticalMsgTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0,kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wuwuliu"];
        emptyView.tips = @"当前没有物流信息";
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    /*
    self.tableView.dataArray = @[
                                 @{@"msg":@"卖家已签收，感谢使用EMS快递",@"time":@"2016-11-12 09:48"},
                                 @{@"msg":@"广州市集散中心 已发出",@"time":@"2016-11-12 09:48"},
                                 @{@"msg":@"顺丰快递 佛山市长城区新明二路营业点收件员 已揽件",@"time":@"2016-11-12 09:48"},
                                 @{@"msg":@"你的快递由佛山门店安排发货",@"time":@"2016-11-12 09:48"}
                                 ];
     */
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"物流信息";
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
