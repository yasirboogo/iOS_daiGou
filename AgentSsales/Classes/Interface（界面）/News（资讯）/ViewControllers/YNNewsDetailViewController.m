//
//  YNNewsDetailViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewsDetailViewController.h"

@interface YNNewsDetailViewController ()

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

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];

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
