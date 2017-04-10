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
    NSInteger _type;
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
    [self startNetWorkingRequestWithUserCoupon];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
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
                             @"type":[NSNumber numberWithInteger:_type+1]
                             };
    
    [YNHttpManagers getUserCouponWithParams:params success:^(id response) {
        [self handleEndMJRefresh];
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self handleMJRefreshComplateWithResponse:response[@"couponsArray"]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
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
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageIndex = 1;
            [tableView.mj_footer endRefreshing];
            [self startNetWorkingRequestWithUserCoupon];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageIndex += 1;
            [tableView.mj_header endRefreshing];
            [self startNetWorkingRequestWithUserCoupon];
        }];
    }
    return _tableView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, W_RATIO(2), SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(90)-W_RATIO(2));
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wudizhi"];
        emptyView.tips = LocalNoCouponTisp;
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleMJRefreshComplateWithResponse:(NSArray*)response{
    if (_pageIndex == 1) {
        _tableView.dataArrayM = [NSMutableArray arrayWithArray:response];
        self.emptyView.hidden = _tableView.dataArrayM.count;
    }else{
        [_tableView.dataArrayM addObjectsFromArray:response];
    }
    [_tableView reloadData];
    if (response.count == 0) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}
-(void)handleEndMJRefresh{
    if (_pageIndex == 1) {
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}
-(void)makeData{
    _pageIndex = 1;
    _pageSize = 10;
    NSArray *stasus = @[@"1",@"2,3"];
    _status = stasus[_index];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{

}
-(void)makeUI{

}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
