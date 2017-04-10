//
//  YNPrefectInforViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPrefectInforViewController.h"
#import "YNPrefectInforTableView.h"
#import "YNShoppingCartViewController.h"
#import "YNAreaSelectView.h"
#import "YNFirmOrderViewController.h"

@interface YNPrefectInforViewController ()

@property(nonatomic,strong)YNPrefectInforTableView *tableView;

@property(nonatomic,strong)YNAreaSelectView *areaSelectView;

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
-(void)startNetWorkingRequestWithPrefectUserInfor{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],@"userId",_tableView.name,@"username",_tableView.phone,@"phone",_tableView.locality,@"region",_tableView.details,@"detailed",_tableView.emial,@"emial", nil];
    
    if (_tableView.numberID.length) {
        [params setValue:_tableView.numberID forKey:@"idCard"];
    }
    [YNHttpManagers prefectUserInforWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            YNFirmOrderViewController *pushCV = [[YNFirmOrderViewController alloc] init];
            pushCV.status = _index+1;
            pushCV.shoppingId = _shoppingId;
            pushCV.goodsId = _goodsId;
            pushCV.count = _count;
            [self.navigationController pushViewController:pushCV animated:NO];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNAreaSelectView *)areaSelectView{
    if (!_areaSelectView) {
        CGRect frame = CGRectMake(0,(SCREEN_HEIGHT-W_RATIO(100)*9)/2.0, SCREEN_WIDTH, W_RATIO(100)*9);
        YNAreaSelectView *areaSelectView = [[YNAreaSelectView alloc] initWithFrame:frame];
        _areaSelectView = areaSelectView;
        [areaSelectView setDidSelectAreaSelectResultBlock:^(NSString *area) {
            self.tableView.locality = area;
        }];
    }
    return _areaSelectView;
}
-(YNPrefectInforTableView *)tableView{
    if (!_tableView) {
        YNPrefectInforTableView *tableView = [[YNPrefectInforTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAddressCellBlock:^{
            [self.view endEditing:YES];
            [self.areaSelectView showPopView:YES];
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
        [submitBtn setTitle:LocalSave forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handlePrefectInforSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handlePrefectInforSubmitButtonClick:(UIButton*)btn{
    [self startNetWorkingRequestWithPrefectUserInfor];
}
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalPerfectInfor;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
