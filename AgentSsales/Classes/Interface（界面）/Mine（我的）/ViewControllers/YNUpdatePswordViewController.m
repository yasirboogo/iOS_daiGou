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
                             @"oldPassword":_tableView.oldPasswod,
                             @"newPassword":_tableView.firPasswod};
    [YNHttpManagers updateUserPwdWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showImage:nil status:LocalChangeSuccess];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                [self.navigationController popViewControllerAnimated:NO];
            }];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalChangeFailure];
            [SVProgressHUD dismissWithDelay:2.0f ];
        }
    } failure:^(NSError *error) {
        //do error things
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
    
    BOOL isEmpty = !_tableView.oldPasswod.length || !_tableView.firPasswod.length || !_tableView.secPasswod.length;
    
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKeychainService];
    
    BOOL isPwdRight = [_tableView.oldPasswod isEqualToString:keychain.allItems[0][@"value"]];
    
    BOOL isPwdEqual = [_tableView.firPasswod isEqualToString:_tableView.secPasswod];
    if (isEmpty) {
        [SVProgressHUD showImage:nil status:LocalInputIsEmpty];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else if (!isPwdRight) {
        [SVProgressHUD showImage:nil status:LocalOldPwdError];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else if(!isPwdEqual) {
        [SVProgressHUD showImage:nil status:LocalPwdDifferent];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else{
        [self startNetWorkingRequestWithUpdateUserPwd];
    }
}
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalChangePwd;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
