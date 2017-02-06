//
//  YNTerraceGoodsViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/4.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNTerraceGoodsViewController.h"

@interface YNTerraceGoodsViewController ()

@end

@implementation YNTerraceGoodsViewController

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
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"jinrugouwuche"] selectImg:nil isOnRight:YES btnClickBlock:^(BOOL isShow) {
    }];
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"shoucang_bai"] selectImg:[UIImage imageNamed:@"shoucang_huang"] isOnRight:YES btnClickBlock:^(BOOL isShow) {
    }];
    
}
-(void)makeUI{
    [super makeUI];
}

#pragma mark - 数据懒加载

#pragma mark - 其他

@end
