//
//  YNShowMoreClassViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/28.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNShowMoreClassViewController.h"


@interface YNShowMoreClassViewController ()


@property (nonatomic,weak)UIView *allClassBar;

@property (nonatomic,weak)UIView *showAllView;

@property (nonatomic,weak)UIButton *showBtn;

@end

@implementation YNShowMoreClassViewController

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
    self.titleLabel.text = NSLS(@"分类", @"分类");
}
-(void)makeUI{
    [super makeUI];

}

#pragma mark - 数据懒加载

#pragma mark - 其他

@end
