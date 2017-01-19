//
//  YNPrefectInforViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPrefectInforViewController.h"
#import "YNPrefectInforTableView.h"

@interface YNPrefectInforViewController ()

@property(nonatomic,strong)YNPrefectInforTableView *tableView;

@property (nonatomic,weak) UIButton *submitBtn;

@end

@implementation YNPrefectInforViewController

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
-(YNPrefectInforTableView *)tableView{
    if (!_tableView) {
        YNPrefectInforTableView *tableView = [[YNPrefectInforTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:@"保存" forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handlePrefectInforSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handlePrefectInforSubmitButtonClick:(UIButton*)btn{
//    NSLog(@"%@",_tableView.textArrayM);
}
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"修改手机";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
