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

@property (nonatomic,copy) NSString * realprice;

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
    if (self.shoppingId.length) {
        [self startNetWorkingRequestWithStartSubmitOrder];
    }else if (self.goodsId.length){
        [self startNetWorkingRequestWithBuyNowToSubmit];
    }
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
-(void)startNetWorkingRequestWithBuyNowToSubmit{
    NSString *userId = [DEFAULTS valueForKey:kUserLoginInfors][@"userId"];
    NSLog(@"%@",userId);
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"goodsId":_goodsId,
                             @"type":[NSNumber numberWithInteger:_type],
                             @"count":_count};
    [YNHttpManagers buyNowToSubmitWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.collectionView.dataDict = response;
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithStartSubmitOrder{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"shoppingId":_shoppingId,
                             @"type":[NSNumber numberWithInteger:_type],
                             @"status":[NSNumber numberWithInteger:_status]};
    [YNHttpManagers startSubmitOrderWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.collectionView.dataDict = response;
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithPayNowMoney{
    
    self.realprice = [NSString stringWithFormat:@"%.2f",[_collectionView.dataDict[@"totalprice"] floatValue] + [_youhui floatValue] - [_subMoney floatValue]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [DEFAULTS valueForKey:kUserLoginInfors][@"userId"],@"userId",
                                   [NSString stringWithFormat:@"%@",_collectionView.dataDict[@"totalprice"]],@"totalprice",
                                   [NSString stringWithFormat:@"%@",_collectionView.postMoney],@"postage",
                                   [NSString stringWithFormat:@"%@",self.youhui],@"youhui",
                                   _realprice,@"realprice",
                                   _collectionView.postWay,@"delivery",
                                   _collectionView.dataDict[@"name"],@"username",
                                   _collectionView.dataDict[@"phone"],@"userphone",
                                   [NSString stringWithFormat:@"%@%@",_collectionView.dataDict[@"region"],_collectionView.dataDict[@"detailed"]],@"address",
                                   self.goodsId,@"goodsId",
                                   //_style,@"style",
                                   _count,@"count",
                                   nil];
    if (![self.style isEqualToString:@""]) {
        [params setValue:_style forKey:@"style"];
    }
    [YNHttpManagers payNowMoneyWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            YNPayMoneyViewController *pushVC = [[YNPayMoneyViewController alloc] init];
            pushVC.orderId = response[@"orderId"];
            pushVC.postage = @"";
            [self.navigationController pushViewController:pushVC animated:NO];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithGetFreightWays{
    NSDictionary *params = @{@"goodsId":self.goodsId,
                             @"status":[NSNumber numberWithInteger:_status]};
    [YNHttpManagers getFreightWaysWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.wayView.dataArray = response[@"postage"];
            [self.wayView showPopView:YES];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithStartPayMoneyParameterWithType:(NSInteger)type{
    self.realprice = [NSString stringWithFormat:@"%.2f",[_collectionView.dataDict[@"totalprice"] floatValue] + [_youhui floatValue] - [_subMoney floatValue]];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [DEFAULTS valueForKey:kUserLoginInfors][@"userId"],@"userId",
                                   [NSString stringWithFormat:@"%@",_collectionView.dataDict[@"totalprice"]],@"totalprice",
                                   [NSString stringWithFormat:@"%@",_collectionView.postMoney],@"postage",
                                   //[NSString stringWithFormat:@"%@",self.youhui],@"youhui",
                                   _realprice,@"realprice",
                                   _collectionView.postWay,@"delivery",
                                   _shoppingId,@"shoppingId",
                                   _collectionView.dataDict[@"name"],@"username",
                                   _collectionView.dataDict[@"phone"],@"userphone",
                                   [NSString stringWithFormat:@"%@%@",_collectionView.dataDict[@"region"],_collectionView.dataDict[@"detailed"]],@"address",
                                   //self.goodsId,@"goodsId",
                                   [NSNumber numberWithInteger:_type+1],@"moneytype",
                                   nil];
    if (type == 1) {
        [params setValue:@"0.00" forKey:@"postage"];
        [params setValue:@0 forKey:@"youhui"];
        [YNHttpManagers startPayMoneyParameter1WithParams:params success:^(id response) {
            if ([response[@"code"] isEqualToString:@"success"]) {
                //do success things
                YNPayMoneyViewController *pushVC = [[YNPayMoneyViewController alloc] init];
                pushVC.orderId = response[@"orderId"];
                pushVC.postage = @"";
                pushVC.index = 1;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else{
                //do failure things
            }
        } failure:^(NSError *error) {
            //do error things
        }];
    }else if (type == 2){
        [params setValue:[NSString stringWithFormat:@"%@",_collectionView.postMoney] forKey:@"postage"];
        [params setValue:self.youhui forKey:@"youhui"];
        [params setValue:self.goodsId forKey:@"goodsId"];
        [YNHttpManagers startPayMoneyParameter2WithParams:params success:^(id response) {
            if ([response[@"code"] isEqualToString:@"success"]) {
                //do success things
                YNPayMoneyViewController *pushVC = [[YNPayMoneyViewController alloc] init];
                pushVC.orderId = response[@"orderId"];
                pushVC.postage = @"";
                pushVC.index = 2;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else{
                //do failure things
            }
        } failure:^(NSError *error) {
            //do error things
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
        collectionView.postWay = LocalPleaseSelect;
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
        [submitBtn setTitle:LocalSubmitOrder forState:UIControlStateNormal];
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
    if ([_collectionView.postWay isEqualToString:LocalPleaseSelect]) {
        [self startNetWorkingRequestWithGetFreightWays];
    }else{
        if (self.shoppingId.length) {
            [self startNetWorkingRequestWithStartPayMoneyParameterWithType:self.status];
        }else{
            [self startNetWorkingRequestWithPayNowMoney];
        }
    }
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalFirmOrder;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.collectionView];
}
#pragma mark - 数据懒加载
-(NSString *)youhui{
    if (!_youhui) {
        _youhui = @"0";
    }
    return _youhui;
}
-(NSString *)goodsId{
    if (!_goodsId) {
        NSMutableString *goodsId = [NSMutableString string];
        for (NSDictionary *dict in _collectionView.dataDict[@"goodsArray"]) {
            [goodsId appendFormat:@",%@",dict[@"goodsId"]];
        }
        [goodsId deleteCharactersInRange:NSMakeRange(0,1)];
        _goodsId = goodsId;
    }
    return _goodsId;
}
#pragma mark - 其他


@end
