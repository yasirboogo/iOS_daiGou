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
-(YNPhoneAreaCodeView *)areaCodeView{
    if (!_areaCodeView) {
        CGRect frame = CGRectMake(kMidSpace, (SCREEN_HEIGHT-(W_RATIO(120)*3))/2.0, SCREEN_WIDTH-kMidSpace*2, W_RATIO(120)*3);
        YNPhoneAreaCodeView *areaCodeView = [[YNPhoneAreaCodeView alloc] initWithFrame:frame];
        _areaCodeView = areaCodeView;
        //areaCodeView.isTapGesture = YES;
        [areaCodeView setDidSelectCodeCellBlock:^(NSInteger index) {
            self.index = index;
            self.tableView.code = self.areaCodeView.dataArray[_index][@"code"];
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
            [self.areaCodeView showPopView:YES];
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
        [submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
    self.areaCodeView.dataArray =@[
                                   @{@"image":@"zhongguo_yuan",@"title":@"中国",@"code":@"86"},
                                   @{@"image":@"malaixiya_yuan",@"title":@"马来西亚",@"code":@"60"}
                                   ];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"输入账号";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
-(void)handleForgetPwdButtonClick:(UIButton*)btn{
    
}
-(void)handleRegisterSubmitButtonClick:(UIButton*)btn{
    
    YNForgetPwdViewController *pushVC = [[YNForgetPwdViewController alloc] init];
    pushVC.code = _areaCodeView.dataArray[_index][@"code"];
    pushVC.phone = _tableView.textArrayM[1];
    [self.navigationController pushViewController:pushVC animated:NO];
}

#pragma mark - 数据懒加载

#pragma mark - 其他

@end
