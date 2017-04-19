//
//  YNOrderViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNOrderViewController.h"
#import "YNGoodsCartCollectionView.h"
#import "YNOrderDetailsViewController.h"
#import "YNLogisticalMsgViewController.h"
#import "YNPayMoneyViewController.h"
#import "YNTipsPerfectInforView.h"
#import "YNPaySuccessViewController.h"

@interface YNOrderViewController ()
{
    NSInteger _orderStatus;
    NSInteger _pageIndex;
    NSInteger _pageSize;
    NSInteger _type;
    
    NSInteger _orderId;
}
@property (nonatomic,weak) YNGoodsCartCollectionView * collectionView;

@property (nonatomic,weak) YNShowEmptyView * emptyView;

@property (nonatomic,weak) YNTipsPerfectInforView * inforView;

@property (nonatomic,assign) NSInteger section;

@end

@implementation YNOrderViewController

#pragma mark - 视图生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.collectionView.mj_header beginRefreshing];
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
-(void)startNetWorkingRequestWithUserOrderList{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"orderStatus":[NSNumber numberWithInteger:_orderStatus],
                             @"pageIndex":[NSNumber numberWithInteger:_pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:_pageSize],
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers getUserOrderListWithParams:params success:^(id response) {
        [self handleEndMJRefresh];
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self handleMJRefreshComplateWithResponse:response[@"orderArray"]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
    }];
}
-(void)startNetWorkingRequestWithCancelUserOrder{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId]};
    [YNHttpManagers cancelUserOrderWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            //[self startNetWorkingRequestWithUserOrderList];
            [_collectionView.dataArrayM removeObjectAtIndex:self.section];
            [_collectionView reloadData];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithPromptShipment{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId]};
    [YNHttpManagers promptShipmentWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithConfirmShipment{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId]};
    [YNHttpManagers confirmShipmentWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
            pushVC.type = 3;
            [self.navigationController pushViewController:pushVC animated:NO];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithAnotherOrder{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId],
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers anotherOrderWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self startNetWorkingRequestWithUserOrderList];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNTipsPerfectInforView *)inforView{
    if (!_inforView) {
        CGRect frame = CGRectMake((SCREEN_WIDTH-W_RATIO(536))/2.0, (SCREEN_HEIGHT-W_RATIO(506))/2.0, W_RATIO(536), W_RATIO(504));
        YNTipsPerfectInforView *inforView = [[YNTipsPerfectInforView alloc] initWithFrame:frame img:[UIImage imageNamed:@"daigoudingdantu"] title:@"代购订单说明" tips:@"代购订单需要确定邮费及关税后才能付款，处理需要1到3个工作日" btnTitle:@"知道了"];
        _inforView = inforView;
        [self.view addSubview:inforView];
        inforView.isTapGesture = YES;
    }
    return _inforView;
}
-(YNGoodsCartCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(84));
        YNGoodsCartCollectionView *collectionView = [[YNGoodsCartCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        [collectionView setDidFooterViewQuestionButtonBlock:^{
            [self.inforView showPopView:YES];
        }];
        [collectionView setDidFooterViewLeftButtonBlock:^(NSInteger index,NSInteger orderId,NSInteger section,NSString *postage,NSInteger shopIndex) {
            _orderId = orderId;
            self.section = section;
            if (index == 100 + 1) {//取消订单
                [self startNetWorkingRequestWithCancelUserOrder];
            }else if (index == 100 + 2){//取消订单
                [self startNetWorkingRequestWithCancelUserOrder];
            }else if (index == 100 + 3){
            }else if (index == 100 + 4){
            }else if (index == 100 + 5){//查看物流
                YNLogisticalMsgViewController *pushVC = [[YNLogisticalMsgViewController alloc] init];
                pushVC.orderId =orderId;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if (index == 100 + 6){//再来一单
                [self startNetWorkingRequestWithAnotherOrder];
            }
        }];
        [collectionView setDidFooterViewRightButtonBlock:^(NSInteger index,NSInteger orderId,NSInteger section,NSString *postage,NSInteger shopIndex) {
            _orderId = orderId;
            self.section = section;
            if (index == 200 + 1) {//马上付款
                YNPayMoneyViewController *pushVC = [[YNPayMoneyViewController alloc] init];
                pushVC.orderId = [NSString stringWithFormat:@"%ld",(long)orderId];
                pushVC.postage = postage;
                pushVC.shopIndex = shopIndex == 2?1:2;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if (index == 200 + 2){//马上付款(点击不了)
            }else if (index == 200 + 3){//马上付款
                YNPayMoneyViewController *pushVC = [[YNPayMoneyViewController alloc] init];
                pushVC.orderId = [NSString stringWithFormat:@"%ld",(long)orderId];
                pushVC.postage = postage;
                pushVC.shopIndex = shopIndex == 2?1:2;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if (index == 200 + 4){//提醒发货
                [self startNetWorkingRequestWithPromptShipment];
            }else if (index == 200 + 5){//确认收货
                [self startNetWorkingRequestWithConfirmShipment];
            }else if (index == 200 + 6){//查看物流
                YNLogisticalMsgViewController *pushVC = [[YNLogisticalMsgViewController alloc] init];
                pushVC.orderId =orderId;
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
        [collectionView setDidSelectOrderGoodsCell:^(NSInteger orderId,NSInteger index,NSString *postage) {
            YNOrderDetailsViewController *pushVC = [[YNOrderDetailsViewController alloc] init];
            pushVC.orderId = orderId;
            pushVC.postage = postage;
            pushVC.myOrderListModel = _collectionView.dataArrayM[index];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        
        collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageIndex = 1;
            [collectionView.mj_footer endRefreshing];
            [self startNetWorkingRequestWithUserOrderList];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        collectionView.mj_header.automaticallyChangeAlpha = YES;
        collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageIndex += 1;
            [collectionView.mj_header endRefreshing];
            [self startNetWorkingRequestWithUserOrderList];
        }];
    }
    return _collectionView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, W_RATIO(2), SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(84)-W_RATIO(2));
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wudingdan"];
        emptyView.tips = LocalNoOrderTisp;
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleMJRefreshComplateWithResponse:(NSArray*)response{
    NSMutableArray *tempArrayM = [MyOrderListModel arrayOfModelsFromDictionaries:response error:nil];
    if (_pageIndex == 1) {
        _collectionView.dataArrayM = [NSMutableArray arrayWithArray:tempArrayM];
        self.emptyView.hidden = _collectionView.dataArrayM.count;
    }else{
        [_collectionView.dataArrayM addObjectsFromArray:tempArrayM];
    }
    [_collectionView reloadData];
    if (response.count == 0) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}
-(void)handleEndMJRefresh{
    if (_pageIndex == 1) {
        [self.collectionView.mj_header endRefreshing];
    }else{
        [self.collectionView.mj_footer endRefreshing];
    }
}
-(void)makeData{
    _orderStatus = _index;
    _pageIndex = 1;
    _pageSize = 10;
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    
}
-(void)makeUI{
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
