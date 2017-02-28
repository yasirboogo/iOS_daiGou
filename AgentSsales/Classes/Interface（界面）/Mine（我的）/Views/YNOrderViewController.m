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

@end

@implementation YNOrderViewController

#pragma mark - 视图生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    [self makeNavigationBar];
    [self makeUI];
    [self startNetWorkingRequestWithUserOrderList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithUserOrderList{
    NSDictionary *params = @{
                             @"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"orderStatus":[NSNumber numberWithInteger:_orderStatus],
                             @"pageIndex":[NSNumber numberWithInteger:_pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:_pageSize],
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers getUserOrderListWithParams:params success:^(id response) {
        self.collectionView.dataArray = [MyOrderListModel arrayOfModelsFromDictionaries:response error:nil];
        self.emptyView.hidden = self.collectionView.dataArray.count;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithCancelUserOrder{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId]};
    [YNHttpManagers cancelUserOrderWithParams:params success:^(id response) {
        [self startNetWorkingRequestWithUserOrderList];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithPromptShipment{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId]};
    [YNHttpManagers promptShipmentWithParams:params success:^(id response) {
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithConfirmShipment{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId]};
    [YNHttpManagers confirmShipmentWithParams:params success:^(id response) {
        [self startNetWorkingRequestWithUserOrderList];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithAnotherOrder{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId],
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers anotherOrderWithParams:params success:^(id response) {
        [self startNetWorkingRequestWithUserOrderList];
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNGoodsCartCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(84));
        YNGoodsCartCollectionView *collectionView = [[YNGoodsCartCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        [collectionView setDidFooterViewQuestionButtonBlock:^{
        }];
        [collectionView setDidFooterViewLeftButtonBlock:^(NSInteger index,NSInteger orderId) {
            _orderId = orderId;
            if (index == 100 + 1) {
                [self startNetWorkingRequestWithCancelUserOrder];
            }else if (index == 100 + 2){
                [self startNetWorkingRequestWithCancelUserOrder];
            }else if (index == 100 + 3){
            }else if (index == 100 + 4){
                YNLogisticalMsgViewController *pushVC = [[YNLogisticalMsgViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if (index == 100 + 5){
                [self startNetWorkingRequestWithAnotherOrder];
            }
        }];
        [collectionView setDidFooterViewRightButtonBlock:^(NSInteger index,NSInteger orderId) {
            _orderId = orderId;
            if (index == 200 + 1) {
            }else if (index == 200 + 2){
                
            }else if (index == 200 + 3){
                [self startNetWorkingRequestWithPromptShipment];
            }else if (index == 200 + 4){
                [self startNetWorkingRequestWithConfirmShipment];
            }else if (index == 200 + 5){
                YNLogisticalMsgViewController *pushVC = [[YNLogisticalMsgViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
        [collectionView setDidSelectOrderGoodsCell:^(NSString *str) {
            YNOrderDetailsViewController *pushVC = [[YNOrderDetailsViewController alloc] init];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _collectionView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(84));
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wudingdan"];
        emptyView.tips = @"当前没有订单信息";
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    _orderStatus = _index;
    _pageIndex = 1;
    _pageSize = 10;
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    
}
-(void)makeUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.emptyView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
