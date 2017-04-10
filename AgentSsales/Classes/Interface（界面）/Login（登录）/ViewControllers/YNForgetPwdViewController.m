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
                             @"loginphone":[NSString stringWithFormat:@"%@",self.loginphone],
                             @"type":[NSNumber numberWithInteger:self.type+1],
                             };
    [YNHttpManagers getMsgCodeWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            _checkCode = [NSString stringWithFormat:@"%@",response[@"yzm"]];
            DLog(@"login = %@,yzm = %@",_loginphone,_checkCode);
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithUpadatePwd{
    NSDictionary *params = @{@"phone":self.loginphone,
                             @"password":_tableView.firPassword,
                             };
    [YNHttpManagers forgetPasswordWithParams:params success:^(id response) {
        [self.view endEditing:YES];
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKeychainService];
            if (keychain.allKeys) {
                [keychain removeItemForKey:keychain.allKeys.firstObject];
            }
            [keychain setString:@"" forKey:_loginphone];
            [DEFAULTS setObject:(NSDictionary*)response forKey:kUserLoginInfors];
            [DEFAULTS synchronize];
            [SVProgressHUD showImage:nil status:LocalChangeSuccess];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                YNLoginViewController *pushVC = [[YNLoginViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }];
        }else{
            //do failure things
            DLog(@"%@",response[@"message"]);
            [SVProgressHUD showImage:nil status:LocalChangeFailure];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    } failure:^(NSError *error) {
        //do error things
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
        [submitBtn setTitle:LocalConfirmChange forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleUpdatePswordSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleUpdatePswordSubmitButtonClick:(UIButton*)btn{
    [self.view endEditing:YES];
    BOOL isEmpty = !_tableView.checkCode.length || !_tableView.firPassword.length || !_tableView.secPassword.length;
    BOOL isCheckCode = [_tableView.checkCode isEqualToString:_checkCode];
    
    BOOL isEqual = [_tableView.firPassword isEqualToString:_tableView.secPassword];

    if (isEmpty) {
        [SVProgressHUD showImage:nil status:LocalInputIsEmpty];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else if (!isCheckCode) {
        [SVProgressHUD showImage:nil status:LocalCCodeError];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else if (!isEqual){
        [SVProgressHUD showImage:nil status:LocalPwdDifferent];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else{
        [self startNetWorkingRequestWithUpadatePwd];
    }
}
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalFogetPwd;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end

