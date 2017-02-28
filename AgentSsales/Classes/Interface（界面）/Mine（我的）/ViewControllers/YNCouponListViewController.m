//
//  YNCouponListViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/18.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNCouponListViewController.h"
#import "YNCouponTableView.h"
#import "YNFirmOrderViewController.h"

@interface YNCouponListViewController ()
{
    NSInteger _pageIndex;
    NSInteger _pageSize;
    NSString *_status;
}
@property (nonatomic,weak) YNCouponTableView * tableView;

@property (nonatomic,weak) YNShowEmptyView * emptyView;

@end

@implementation YNCouponListViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLOR_EDEDED;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    [self makeNavigationBar];
    [self makeUI];
    [self startNetWorkingRequestWithUserCoupon];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithUserCoupon{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"pageIndex":[NSNumber numberWithInteger:_pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:_pageSize],
                             @"status":_status,
                             };
    [YNHttpManagers getUserCouponWithParams:params success:^(id response) {
        self.tableView.dataArray = response;
        self.emptyView.hidden = self.tableView.dataArray.count;
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNCouponTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(90));
        YNCouponTableView *tableView = [[YNCouponTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        tableView.isInvalid = self.isInvalid;
        tableView.allPrice = self.allPrice;
        [tableView setDidSelectUseButtonBlock:^(NSString *money,NSString *idMark) {
            YNFirmOrderViewController *lastVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
            if (lastVC.didSelectCouponBlock) {
                lastVC.didSelectCouponBlock(money,idMark);
            }
            [self.parentViewController.navigationController popViewControllerAnimated:NO];
        }];
    }
    return _tableView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(90));
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wudizhi"];
        emptyView.tips = @"当前没有优惠券信息";
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    _pageIndex = 1;
    _pageSize = 10;
    NSArray *stasus = @[@"1",@"2,3"];
    _status = stasus[_index];
}
-(void)makeNavigationBar{

}
-(void)makeUI{

}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
