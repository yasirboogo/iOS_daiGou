//
//  YNFirmOrderViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNFirmOrderViewController.h"
#import "YNFireOrderCollectionView.h"
#import "YNPayMoneyViewController.h"
#import "YNPaySuccessViewController.h"
#import "YNFireOrderWayView.h"
#import "YNAddressViewController.h"
#import "YNMineCouponViewController.h"
@interface YNFirmOrderViewController ()
{
    NSInteger _type;
}
@property (nonatomic,weak) YNFireOrderCollectionView *collectionView;

@property (nonatomic,weak) UIButton *submitBtn;

@property (nonatomic,weak) YNFireOrderWayView *wayView;

@property (nonatomic,copy) NSString *youhui;

@property (nonatomic,copy) NSString *subMoney;

@end

@implementation YNFirmOrderViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [self setDidSelectCouponBlock:^(NSString *subMoney,NSString*youhui) {
        weakSelf.subMoney = subMoney;
        weakSelf.youhui = youhui;
        weakSelf.collectionView.subMoney = subMoney;
    }];
    [self startNetWorkingRequestWithStartSubmitOrder];
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
-(void)startNetWorkingRequestWithStartSubmitOrder{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"shoppingId":_shoppingId,
                             @"type":[NSNumber numberWithInteger:_type],
                             @"status":[NSNumber numberWithInteger:_status]};
    [YNHttpManagers startSubmitOrderWithParams:params success:^(id response) {
        self.collectionView.dataDict = response;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithGetFreightWays{
    NSDictionary *params = @{@"goodsId":_shoppingId,
                             @"status":[NSNumber numberWithInteger:_status]};
    [YNHttpManagers getFreightWaysWithParams:params success:^(id response) {
        self.wayView.dataArray = response;
        [self.wayView showPopView:YES];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithStartPayMoneyParameterWithType:(NSInteger)type{
    NSMutableString *goodsId = [NSMutableString string];
    for (NSDictionary *dict in _collectionView.dataDict[@"goodsArray"]) {
        [goodsId appendFormat:@",%@",dict[@"goodsId"]];
    }
    [goodsId deleteCharactersInRange:NSMakeRange(0,1)];
    NSString *realprice = [NSString stringWithFormat:@"%.2f",[_collectionView.dataDict[@"totalprice"] floatValue] + [_youhui floatValue] - [_subMoney floatValue]];
    if (type == 1) {
        NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                                 @"realprice":[NSString stringWithFormat:@"%@",_collectionView.dataDict[@"totalprice"]],
                                 @"delivery":_collectionView.postWay,
                                 @"shoppingId":_shoppingId,
                                 @"username":_collectionView.dataDict[@"name"],
                                 @"userphone":_collectionView.dataDict[@"phone"],
                                 @"address":
                                     [NSString stringWithFormat:@"%@%@",_collectionView.dataDict[@"region"],_collectionView.dataDict[@"detailed"]],
                                 @"goodsId":goodsId,
                                 @"type":[NSNumber numberWithInteger:-1]};
        [YNHttpManagers startPayMoneyParameter1WithParams:params success:^(id response) {
            YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
            pushVC.titleStr = @"订单提交成功";
            [self.navigationController pushViewController:pushVC animated:NO];
        } failure:^(NSError *error) {
        }];
    }else if (type == 2){
        NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                                 @"totalprice":[NSString stringWithFormat:@"%@",_collectionView.dataDict[@"totalprice"]],
                                 @"postage":[NSString stringWithFormat:@"%@",_collectionView.postMoney],
                                 @"youhui":[NSString stringWithFormat:@"%@",_youhui],
                                 @"realprice":[NSString stringWithFormat:@"%@",realprice],
                                 @"delivery":_collectionView.postWay,
                                 @"shoppingId":_shoppingId,
                                 @"username":_collectionView.dataDict[@"name"],
                                 @"userphone":_collectionView.dataDict[@"phone"],
                                 @"address":
                                     [NSString stringWithFormat:@"%@%@",_collectionView.dataDict[@"region"],_collectionView.dataDict[@"detailed"]],
                                 @"goodsId":goodsId,
                                 @"type":[NSNumber numberWithInteger:-1]};
        [YNHttpManagers startPayMoneyParameter2WithParams:params success:^(id response) {
            YNPayMoneyViewController *pushVC = [[YNPayMoneyViewController alloc] init];
            pushVC.orderDict = _collectionView.dataDict;
            [self.navigationController pushViewController:pushVC animated:NO];
        } failure:^(NSError *error) {
        }];
    }
}
#pragma mark - 视图加载
-(YNFireOrderCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.submitBtn));
        YNFireOrderCollectionView *collectionView = [[YNFireOrderCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        collectionView.status = self.status;
        collectionView.postWay = @"请选择";
        collectionView.postMoney = @"0.00";
        collectionView.subMoney = @"0.00";
        [collectionView setDidSelectPostWayBlock:^{
            [self startNetWorkingRequestWithGetFreightWays];
        }];
        [collectionView setDidSelectAddressBlock:^{
            YNAddressViewController *pushVC =[[YNAddressViewController alloc] init];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        [collectionView setDidSelectDiscountBlock:^(NSString *allPrice) {
            YNMineCouponViewController *pushVC =[[YNMineCouponViewController alloc] init];
            pushVC.allPrice = allPrice;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _collectionView;
}

-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleFirmOrderSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
-(YNFireOrderWayView *)wayView{
    if (!_wayView) {
        YNFireOrderWayView *wayView = [[YNFireOrderWayView alloc] initWithRowHeight:W_RATIO(150) width:W_RATIO(660) showNumber:3];
        _wayView = wayView;
        [wayView setDidSelectOrderWayCellBlock:^(NSString *way,NSString*money) {
            [_wayView dismissPopView:YES];
            self.collectionView.postMoney = money;
            self.collectionView.postWay = way;
        }];
    }
    return _wayView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleFirmOrderSubmitButtonClick:(UIButton*)btn{
    [self startNetWorkingRequestWithStartPayMoneyParameterWithType:self.status];
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"确认订单";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.collectionView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
