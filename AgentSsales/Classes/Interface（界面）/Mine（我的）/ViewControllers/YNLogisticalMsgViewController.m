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
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.tableView.dataArray = response[@"info"];
            self.emptyView.hidden = self.tableView.dataArray.count;
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
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
        CGRect frame = CGRectMake(0,kUINavHeight+W_RATIO(2), SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(2));
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wuwuliu"];
        emptyView.tips = LocalNoLogisticsTips;
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalLogisticsInfor;
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
