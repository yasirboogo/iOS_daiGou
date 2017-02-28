//
//  YNForgetPwdViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNForgetPwdViewController.h"
#import "YNForgetPwdTableView.h"
#import "YNLoginViewController.h"

@interface YNForgetPwdViewController ()
{
    NSString *_checkCode;
}
@property(nonatomic,strong)YNForgetPwdTableView *tableView;

@property (nonatomic,weak) UIButton *submitBtn;

@end

@implementation YNForgetPwdViewController

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
-(void)startNetWorkingRequestWithPhoneCode{
    NSDictionary *params = @{
                             @"loginphone":[NSString stringWithFormat:@"%@%@",self.code,self.phone]
                             };
    [YNHttpManagers getMsgCodeWithParams:params success:^(id response) {
        _checkCode = response;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)startNetWorkingRequestWithUpadatePwd{
    NSDictionary *params = @{
                             @"phone":self.phone,
                             @"password":_tableView.textArrayM[1],
                             };
    [YNHttpManagers forgetPasswordWithParams:params success:^(id response) {
        [self.view endEditing:YES];
        YNLoginViewController *pushVC =[[YNLoginViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:NO];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 视图加载
-(YNForgetPwdTableView *)tableView{
    if (!_tableView) {
        YNForgetPwdTableView *tableView = [[YNForgetPwdTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectSendPhoneCodeBlock:^{
            [self startNetWorkingRequestWithPhoneCode];
        }];
    }
    return _tableView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(W_RATIO(20) ,MaxYF(_tableView)+kMaxSpace, W_RATIO(710), W_RATIO(100));
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = kViewRadius;
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
    [self startNetWorkingRequestWithUpadatePwd];
}
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"忘记密码";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end

