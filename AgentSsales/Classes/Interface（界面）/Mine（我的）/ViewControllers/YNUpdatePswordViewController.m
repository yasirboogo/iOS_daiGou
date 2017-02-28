//
//  YNUpdatePswordViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNUpdatePswordViewController.h"
#import "YNUpdatePswordTableView.h"

@interface YNUpdatePswordViewController ()

@property(nonatomic,strong)YNUpdatePswordTableView *tableView;

@property (nonatomic,weak) UIButton *submitBtn;

@end

@implementation YNUpdatePswordViewController

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
-(void)startNetWorkingRequestWithUpdateUserPwd{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"oldPassword":_tableView.textArrayM[0],
                             @"newPassword":_tableView.textArrayM[1]};
    [YNHttpManagers updateUserPwdWithParams:params success:^(id response) {
        [self.navigationController popViewControllerAnimated:NO];
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNUpdatePswordTableView *)tableView{
    if (!_tableView) {
        YNUpdatePswordTableView *tableView = [[YNUpdatePswordTableView alloc] init];
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
        [submitBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleUpdatePswordSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleUpdatePswordSubmitButtonClick:(UIButton*)btn{
    BOOL isPwdEqual = [_tableView.textArrayM[1] isEqualToString:_tableView.textArrayM[2]];
    BOOL isPwdRight = YES;
    if (!isPwdRight) {
        NSLog(@"密码不正确");
    }else if(!isPwdEqual) {
        NSLog(@"两次密码不一样");
    }else{
        [self startNetWorkingRequestWithUpdateUserPwd];
    }
}
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"修改密码";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
