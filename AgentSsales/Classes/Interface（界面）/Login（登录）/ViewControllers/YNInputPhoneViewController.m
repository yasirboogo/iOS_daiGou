//
//  YNInputPhoneViewController.m
//  AgentSsales1
//
//  Created by innofive on 17/2/9.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNInputPhoneViewController.h"
#import "YNForgetPwdViewController.h"
#import "YNInputPhoneTableView.h"
#import "YNPhoneAreaCodeView.h"

@interface YNInputPhoneViewController ()
{
    NSInteger _type;
}

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,weak) YNInputPhoneTableView * tableView ;

@property (nonatomic,weak) UIButton *submitBtn;

@property (nonatomic,strong) YNPhoneAreaCodeView *areaCodeView;

@end

@implementation YNInputPhoneViewController


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
-(YNPhoneAreaCodeView *)areaCodeView{
    if (!_areaCodeView) {
        YNPhoneAreaCodeView *areaCodeView = [[YNPhoneAreaCodeView alloc] init];
        _areaCodeView = areaCodeView;
        //areaCodeView.isTapGesture = YES;
        [areaCodeView setDidSelectCodeCellBlock:^(NSInteger index) {
            self.index = index;
            self.tableView.country = self.areaCodeView.dataArray[_index];
        }];
    }
    return _areaCodeView;
}
-(YNInputPhoneTableView *)tableView{
    if (!_tableView) {
        YNInputPhoneTableView *tableView = [[YNInputPhoneTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAreaCellBlock:^{
            [self startNetWorkingRequestWithGetCountryCode];
        }];
    }
    return _tableView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(W_RATIO(20) ,MaxYF(_tableView)+kMaxSpace, W_RATIO(710), W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = kViewRadius;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:LocalNext forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleRegisterSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalInputID;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
-(void)handleForgetPwdButtonClick:(UIButton*)btn{
    
}
-(void)handleRegisterSubmitButtonClick:(UIButton*)btn{
    if (!_tableView.country.length || !_tableView.loginphone.length) {
        [SVProgressHUD showImage:nil status:LocalInputIsEmpty];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else{
        YNForgetPwdViewController *pushVC = [[YNForgetPwdViewController alloc] init];
        pushVC.type = _index;
        pushVC.loginphone = _tableView.loginphone;
        [self.navigationController pushViewController:pushVC animated:NO];
    }
}

#pragma mark - 数据懒加载

#pragma mark - 其他

@end
