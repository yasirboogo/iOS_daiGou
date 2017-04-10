//
//  YNOrderDetailsViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/16.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNOrderDetailsViewController.h"
#import "YNOrderDetailsCollectionView.h"
#import "YNTipsSuccessBtnsView.h"
#import "YNLogisticalMsgViewController.h"
#import "YNPaySuccessViewController.h"
#import "YNPayMoneyViewController.h"

@interface YNOrderDetailsViewController ()
{
    NSInteger _type;
}
@property (nonatomic,weak) YNOrderDetailsCollectionView * collectionView;

@property (nonatomic,weak) YNTipsSuccessBtnsView *btnsView;

@end

@implementation YNOrderDetailsViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startNetWorkingRequestWithGetOrderDetail];
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
-(void)startNetWorkingRequestWithGetOrderDetail{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId],
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers getOrderDetailWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.collectionView.myOrderListModel = _myOrderListModel;
            self.collectionView.detailDict = response;
            [self setBtnsViewBtnTitlesWithStatus:[response[@"orderstatus"] integerValue]];
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
-(void)startNetWorkingRequestWithCancelUserOrder{
    NSDictionary *params = @{@"orderId":[NSNumber numberWithInteger:_orderId]};
    [YNHttpManagers cancelUserOrderWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self.navigationController popViewControllerAnimated:NO];
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
            [self.navigationController popViewControllerAnimated:NO];
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
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNOrderDetailsCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH,SCREEN_HEIGHT-kUINavHeight);
        YNOrderDetailsCollectionView *collectionView = [[YNOrderDetailsCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        [collectionView setViewScrollBlock:^(CGFloat alpha) {
            self.btnsView.alpha = alpha;
            if (alpha > 0.9f) {
                self.btnsView.userInteractionEnabled = YES;
            }else{
                self.btnsView.userInteractionEnabled = NO;
            }
        }];
    }
    return _collectionView;
}
-(YNTipsSuccessBtnsView *)btnsView{
    if (!_btnsView) {
        YNTipsSuccessBtnsView *btnsView = [[YNTipsSuccessBtnsView alloc] init];
        _btnsView = btnsView;
        [self.view addSubview:btnsView];
        btnsView.alpha = 0;
        btnsView.btnStyle = UIButtonStyle2;
        [btnsView setDidSelectBottomButtonClickBlock:^(NSString *str) {
            if ([str isEqualToString:LocalPayment]) {
                YNPayMoneyViewController *pushVC = [[YNPayMoneyViewController alloc] init];
                pushVC.postage = self.postage;
                pushVC.orderId = [NSString stringWithFormat:@"%ld",(long)_orderId];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([str isEqualToString:LocalCancelOrder]){
                [self startNetWorkingRequestWithCancelUserOrder];
            }else if ([str isEqualToString:LocalPrompt]){
                [self startNetWorkingRequestWithPromptShipment];
            }else if ([str isEqualToString:LocalConReceipt]) {
                [self startNetWorkingRequestWithConfirmShipment];
            }else if ([str isEqualToString:LocalViewLogistics]){
                YNLogisticalMsgViewController *pushVC = [[YNLogisticalMsgViewController alloc] init];
                pushVC.orderId = _orderId;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([str isEqualToString:LocalAnotherOne]){
                [self startNetWorkingRequestWithAnotherOrder];

            }
        }];
    }
    return _btnsView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)setBtnsViewBtnTitlesWithStatus:(NSInteger)status{
    if (status == 1) {
        self.btnsView.btnTitles = @[LocalPayment,LocalCancelOrder];
    }else if (status == 2){
        self.btnsView.btnTitles = @[LocalCancelOrder];
    }else if (status == 3){
        self.btnsView.btnTitles = @[LocalPayment,LocalCancelOrder];
    }else if (status == 4){
        self.btnsView.btnTitles = @[LocalPrompt];
    }else if (status == 5){
        self.btnsView.btnTitles = @[LocalConReceipt,LocalViewLogistics];
    }else if (status == 6){
        self.btnsView.btnTitles = @[LocalViewLogistics,LocalAnotherOne];
    }
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalOrderDetails;
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
