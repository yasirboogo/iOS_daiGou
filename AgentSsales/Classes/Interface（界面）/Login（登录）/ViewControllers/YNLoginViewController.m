//
//  YNLoginViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNLoginViewController.h"
#import "YNLoginTableView.h"
#import "YNRegisterViewController.h"
#import "YNForgetPwdViewController.h"

@interface YNLoginViewController ()

@property (nonatomic,weak) YNLoginTableView * tableView ;

@property (nonatomic,weak) UIButton *forgetBtn;

@property (nonatomic,weak) UIButton *submitBtn;

@end

@implementation YNLoginViewController


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
-(YNLoginTableView *)tableView{
    if (!_tableView) {
        YNLoginTableView *tableView = [[YNLoginTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}
-(UIButton *)forgetBtn{
    if (!_forgetBtn) {
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetBtn = forgetBtn;
        [self.view addSubview:forgetBtn];
        forgetBtn.titleLabel.font = FONT(26);
        [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        forgetBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -W_RATIO(20), 0, 0);
        [forgetBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        [forgetBtn setImage:[UIImage imageNamed:@"wenhao_hong"] forState:UIControlStateNormal];
        [forgetBtn addTarget:self action:@selector(handleForgetPwdButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize forgetBtnSize = [forgetBtn.titleLabel.text calculateHightWithFont:forgetBtn.titleLabel.font maxWidth:0];
        forgetBtn.frame = CGRectMake(SCREEN_WIDTH-(forgetBtnSize.width+kMidSpace*2) ,MaxYF(_tableView)+kMinSpace,forgetBtnSize.width+kMidSpace*2, W_RATIO(80));
    }
    return _forgetBtn;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(W_RATIO(20) ,MaxYF(_tableView)+W_RATIO(122), W_RATIO(710), W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = kViewRadius;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:@"登录" forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleLoginSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:@"注册" selectTitle:@"注册" font:FONT(30) isOnRight:YES btnClickBlock:^(BOOL isShow) {
        YNRegisterViewController *pushVC = [[YNRegisterViewController alloc] init];
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
    self.backButton.hidden = YES;
    self.titleLabel.text = @"登录";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.submitBtn];
}
-(void)handleForgetPwdButtonClick:(UIButton*)btn{
    YNForgetPwdViewController *pushVC = [[YNForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:pushVC animated:NO];
}
-(void)handleLoginSubmitButtonClick:(UIButton*)btn{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
