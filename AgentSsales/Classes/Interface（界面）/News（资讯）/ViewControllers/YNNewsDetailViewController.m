//
//  YNNewsDetailViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewsDetailViewController.h"
#import "YNNewsDetailHeaderView.h"
#import "YNNewsCommentTableView.h"
#import "YNNewsCommentSendView.h"

@interface YNNewsDetailViewController ()

@property (nonatomic,weak) YNNewsDetailHeaderView * headerView;

@property (nonatomic,weak) YNNewsCommentTableView * tableView;

@property (nonatomic,weak) YNNewsCommentSendView * sendView;

@end

@implementation YNNewsDetailViewController

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
-(YNNewsDetailHeaderView *)headerView{
    if (!_headerView) {
        YNNewsDetailHeaderView *headerView = [[YNNewsDetailHeaderView alloc] init];
        _headerView = headerView;
        _tableView.tableHeaderView = headerView;
        headerView.dict = @{@"title":@"未来这一新光源系统装置建成后，将满足我国重大战略需求",@"type":@"新闻",@"time":@"2016-12-12 16:05:54"};
        [headerView setHtmlDidLoadFinish:^{
            _tableView.tableHeaderView = _headerView;
        }];
    }
    return _headerView;
}
-(YNNewsCommentTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.sendView));
        YNNewsCommentTableView *tableView = [[YNNewsCommentTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}
-(YNNewsCommentSendView *)sendView{
    if (!_sendView) {
        CGRect frame = CGRectMake(0, SCREEN_HEIGHT-W_RATIO(90), SCREEN_WIDTH, W_RATIO(90));
        YNNewsCommentSendView *sendView = [[YNNewsCommentSendView alloc] initWithFrame:frame];
        _sendView = sendView;
        [self.view addSubview:sendView];
        [sendView setDidSelectSendButtonClickBlock:^(NSString *str) {
            NSLog(@"%@",str);
        }];
    }
    return _sendView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.tableView.dataArray = @[@{@"ico":@"testGoods",@"name":@"在“十三五”期间",@"time":@"3分钟前",@"content":@"中国科学院消息，在“十三五”期间，我国将在北京建设一台高性能的高能同步辐射光源，也称为“北京光源”，其设计亮度及相干度均高于世界现有、在建或计划中的光源。未来这一新光源系统装置建成后，将满足我国重大战略需求，并对众多基础科学的研究发挥关键支撑作用。"}];

}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"资讯详情";

}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
