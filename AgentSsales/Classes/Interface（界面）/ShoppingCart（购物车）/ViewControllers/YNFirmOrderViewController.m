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
@interface YNFirmOrderViewController ()

@property (nonatomic,weak) YNFireOrderCollectionView *collectionView;

@property (nonatomic,weak) UIButton *submitBtn;

@property (nonatomic,weak) YNFireOrderWayView *wayView;

@end

@implementation YNFirmOrderViewController

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

#pragma mark - 视图加载

-(YNFireOrderCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.submitBtn));
        YNFireOrderCollectionView *collectionView = [[YNFireOrderCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        collectionView.index = self.index;
        collectionView.postWay = self.wayView.dataArray[0][@"title"];
        [collectionView setDidSelectPostWayBlock:^{
            [self.wayView showPopView:YES];
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
//        wayView.isTapGesture = YES;
        wayView.dataArray = @[@{@"title":@"空运20元",@"subTitle":@"(预计约6天收货)"},
                                   @{@"title":@"海运10元",@"subTitle":@"(预计约10天收货)"},
                                   @{@"title":@"普通快递10元",@"subTitle":@"(预计约15天收货)"}];
        [wayView setDidSelectOrderWayCellBlock:^(NSString *way) {
            [_wayView dismissPopView:YES];
            self.collectionView.postWay = way;
        }];
    }
    return _wayView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleFirmOrderSubmitButtonClick:(UIButton*)btn{
    if (self.index == 0) {
            YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
            pushVC.titleStr = @"订单提交成功";
            [self.navigationController pushViewController:pushVC animated:NO];
        
    }else if (self.index == 1){
        YNPayMoneyViewController *pushVC = [[YNPayMoneyViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:NO];
    }
}
-(void)makeData{
    [super makeData];
    
    self.collectionView.dataArray = @[
                                      @{@"image":@"testGoods",@"title":@"书籍-设计师的自我修养",@"subTitle":@"2016年出版版本",@"price":@"501.21",@"amount":@"2"},
                                      @{@"image":@"testGoods",@"title":@"书籍-设计师的自我修养",@"subTitle":@"2016年出版版本",@"price":@"501.21",@"amount":@"2"}];
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
