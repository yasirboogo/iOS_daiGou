//
//  YNNewAddressViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewAddressViewController.h"
#import "YNNewAddressTableView.h"

@interface YNNewAddressViewController ()

@property(nonatomic,strong)YNNewAddressTableView *tableView;

@end

@implementation YNNewAddressViewController

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
-(YNNewAddressTableView *)tableView{
    if (!_tableView) {
        YNNewAddressTableView *tableView = [[YNNewAddressTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:@"保存" selectTitle:@"保存" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isShow) {
        NSLog(@"%@",weakSelf.tableView.phone);
    }];
    
    self.titleLabel.text = self.titleStr;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
