//
//  YNAdressViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNAddressViewController.h"
#import "YNNewAddressViewController.h"
#import "YNAddressTableView.h"

@interface YNAddressViewController ()
@property (nonatomic,weak) YNAddressTableView * tableView;

@property (nonatomic,weak) YNShowEmptyView * emptyView;

@end

@implementation YNAddressViewController
#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startNetWorkingRequestWithUserAddressList];
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
-(void)startNetWorkingRequestWithUserAddressList{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize],
                             };
    [YNHttpManagers getUserAddressListWithParams:params success:^(id response) {
        self.tableView.dataArrayM = response;
        self.emptyView.hidden = self.tableView.dataArrayM.count;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithSetDefaultAddressWithAddressId:(NSInteger)addressId{
    NSDictionary *params = @{@"addressId":[NSNumber numberWithInteger:addressId],
                             };
    [YNHttpManagers setDefaultAddressWithParams:params success:^(id response) {
        [self startNetWorkingRequestWithUserAddressList];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithDelectUserAddressWithAddressId:(NSInteger)addressId{
    NSDictionary *params = @{@"addressId":[NSNumber numberWithInteger:addressId],
                             };
    [YNHttpManagers delectUserAddressWithParams:params success:^(id response) {
        [self startNetWorkingRequestWithUserAddressList];
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNAddressTableView *)tableView{
    if (!_tableView) {
        YNAddressTableView *tableView = [[YNAddressTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAddressCellBlock:^(NSIndexPath *indexPath) {
            YNNewAddressViewController *pushVC = [[YNNewAddressViewController alloc] init];
            pushVC.type = 0;
            YNAddressCellFrame *cellFrame = _tableView.dataArrayM[indexPath.row];
            pushVC.address = cellFrame.dict;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        [tableView setDidSelectSetDefaultAddressBlock:^(NSInteger index) {
            [self startNetWorkingRequestWithSetDefaultAddressWithAddressId:index];
        }];
        [tableView setDidSelectSetDelectAddressBlock:^(NSInteger index) {
            [self startNetWorkingRequestWithDelectUserAddressWithAddressId:index];
        }];
    }
    return _tableView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kUINavHeight);
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wudizhi"];
        emptyView.tips = @"暂无收货地址";
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:@"新建" selectTitle:@"新建" font:FONT_15 img:[UIImage imageNamed:@"xinjian"] selectImg:[UIImage imageNamed:@"xinjian"] imgWidth:W_RATIO(30) isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        YNNewAddressViewController *pushVC = [[YNNewAddressViewController alloc] init];
        pushVC.type = 1;
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
    self.titleLabel.text = kLocalizedString(@"addressManagement",@"收货地址管理");
}
-(void)makeUI{
    [super makeUI];

}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end

