//
//  YNUpdatePhoneViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNUpdatePhoneViewController.h"
#import "YNUpdatePhoneTableView.h"
#import "YNPhoneAreaCodeView.h"

@interface YNUpdatePhoneViewController ()
{
    NSString *_checkCode;
    NSInteger _type;
}
@property (nonatomic,strong) YNPhoneAreaCodeView *areaCodeView;

@property (nonatomic,assign) NSInteger index;

@property(nonatomic,strong)YNUpdatePhoneTableView *tableView;

@property (nonatomic,weak) UIButton *submitBtn;

@end

@implementation YNUpdatePhoneViewController

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
-(void)startNetWorkingRequestWithGetCountryCode{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type]
                             };
    [YNHttpManagers getCountryCodeWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.areaCodeView.dataArray = response[@"countryArray"];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithPhoneCode{
    NSDictionary *params = @{
                             @"loginphone":_tableView.loginphone,
                             @"type":[NSNumber numberWithInteger:_index+1]
                             };
    [YNHttpManagers getMsgCodeWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            _checkCode = [NSString stringWithFormat:@"%@",response[@"yzm"]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithUpdateUserPhone{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"phone":_tableView.loginphone};
    [YNHttpManagers updateUserPhoneWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showImage:nil status:LocalChangeSuccess];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                [self.navigationController popViewControllerAnimated:NO];
            }];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalChangeFailure];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNPhoneAreaCodeView *)areaCodeView{
    if (!_areaCodeView) {
        YNPhoneAreaCodeView *areaCodeView = [[YNPhoneAreaCodeView alloc] init];
        _areaCodeView = areaCodeView;
        [areaCodeView setDidSelectCodeCellBlock:^(NSInteger index) {
            self.index = index;
            self.tableView.country = self.areaCodeView.dataArray[_index];
        }];
    }
    return _areaCodeView;
}
-(YNUpdatePhoneTableView *)tableView{
    if (!_tableView) {
        YNUpdatePhoneTableView *tableView = [[YNUpdatePhoneTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAreaCellBlock:^{
            [self startNetWorkingRequestWithGetCountryCode];
        }];
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
    [self.view endEditing:YES];
    BOOL isEmpty = !_tableView.country.length || !_tableView.loginphone.length || !_tableView.checkCode;
    BOOL isCheckCode = [_tableView.checkCode isEqualToString:_checkCode];
    if (isEmpty) {
        [SVProgressHUD showImage:nil status:LocalInputIsEmpty];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else if (!isCheckCode) {
        [SVProgressHUD showImage:nil status:LocalCCodeError];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else{
        [self startNetWorkingRequestWithUpdateUserPhone];
    }
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalChangePhone;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
