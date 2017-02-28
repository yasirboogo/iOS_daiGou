//
//  YNNewAddressViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewAddressViewController.h"
#import "YNNewAddressTableView.h"
#import "YNAreaSelectView.h"

@interface YNNewAddressViewController ()

@property(nonatomic,strong)YNNewAddressTableView *tableView;

@property(nonatomic,strong)YNAreaSelectView *areaSelectView;

@end

@implementation YNNewAddressViewController

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
-(void)startNetWorkingRequestWithSaveNewAddress{
    NSDictionary *params = [NSDictionary dictionary];
    if (self.type == 0) {
        params = @{@"name":_tableView.name,
                   @"phone":_tableView.phone,
                   @"region":_tableView.locality,
                   @"detailed":_tableView.details,
                   @"id":_address[@"addressId"],
                   @"email":_tableView.email
                   };
    }else if (self.type == 1){
        params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                   @"name":_tableView.name,
                   @"phone":_tableView.phone,
                   @"region":_tableView.locality,
                   @"detailed":_tableView.details,
                   @"email":_tableView.email
                   };
    }
    [YNHttpManagers saveNewAddressWithParams:params success:^(id response) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNNewAddressTableView *)tableView{
    if (!_tableView) {
        YNNewAddressTableView *tableView = [[YNNewAddressTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAddressCellBlock:^{
            [self.view endEditing:YES];
            [self.areaSelectView showPopView:YES];
        }];
    }
    return _tableView;
}
-(YNAreaSelectView *)areaSelectView{
    if (!_areaSelectView) {
        CGRect frame = CGRectMake(0,(SCREEN_HEIGHT-W_RATIO(100)*9)/2.0, SCREEN_WIDTH, W_RATIO(100)*9);
        YNAreaSelectView *areaSelectView = [[YNAreaSelectView alloc] initWithFrame:frame];
        _areaSelectView = areaSelectView;
        [areaSelectView setDidSelectAreaSelectResultBlock:^(NSString *area) {
            self.tableView.area = area;
        }];
    }
    return _areaSelectView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    if (self.address) {
        self.tableView.addressM = [self.address mutableCopy];
    }
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:@"保存" selectTitle:@"保存" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isShow) {
        [weakSelf startNetWorkingRequestWithSaveNewAddress];
    }];
    if (self.type == 0) {
        self.titleLabel.text = @"修改收货地址";
    }else if (self.type == 1){
        self.titleLabel.text = @"新增收货地址";
    }
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
