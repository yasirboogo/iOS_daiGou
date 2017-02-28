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
-(void)startNetWorkingRequestWithPhoneCode{
    NSDictionary *params = @{
                             @"loginphone":[NSString stringWithFormat:@"%@%@",_areaCodeView.dataArray[_index][@"code"],_tableView.textArrayM[1]]
                             };
    [YNHttpManagers getMsgCodeWithParams:params success:^(id response) {
        _checkCode = [NSString stringWithFormat:@"%@",response];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)startNetWorkingRequestWithUpdateUserPhone{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],@"phone":_tableView.textArrayM[1]};
    [YNHttpManagers updateUserPhoneWithParams:params success:^(id response) {
        [self.navigationController popViewControllerAnimated:NO];
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNPhoneAreaCodeView *)areaCodeView{
    if (!_areaCodeView) {
        CGRect frame = CGRectMake(kMidSpace, (SCREEN_HEIGHT-(W_RATIO(120)*3))/2.0, SCREEN_WIDTH-kMidSpace*2, W_RATIO(120)*3);
        YNPhoneAreaCodeView *areaCodeView = [[YNPhoneAreaCodeView alloc] initWithFrame:frame];
        _areaCodeView = areaCodeView;
        [areaCodeView setDidSelectCodeCellBlock:^(NSInteger index) {
            self.index = index;
            self.tableView.code = self.areaCodeView.dataArray[_index][@"code"];
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
            [self.areaCodeView showPopView:YES];
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
    BOOL isCheckCode = [_tableView.textArrayM[2] isEqualToString:_checkCode];
    if (isCheckCode) {
        [self startNetWorkingRequestWithUpdateUserPhone];
    }
}
-(void)makeData{
    [super makeData];
    self.areaCodeView.dataArray =@[
                                   @{@"image":@"zhongguo_yuan",@"title":@"中国",@"code":@"86"},
                                   @{@"image":@"malaixiya_yuan",@"title":@"马来西亚",@"code":@"60"}
                                   ];
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
