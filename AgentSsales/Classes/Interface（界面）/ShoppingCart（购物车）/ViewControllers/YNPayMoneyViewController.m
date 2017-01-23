//
//  YNPayMoneyViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/20.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPayMoneyViewController.h"
#import "YNPayMoneyCollectionView.h"
#import "YNPaySuccessViewController.h"

@interface YNPayMoneyViewController ()

@property (nonatomic,weak) YNPayMoneyCollectionView *collectionView;

@property (nonatomic,weak) UIButton *rechargeBtn;

@property (nonatomic,weak) NSString *btnTitle;

@end

@implementation YNPayMoneyViewController

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

-(YNPayMoneyCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.rechargeBtn));
        YNPayMoneyCollectionView *collectionView = [[YNPayMoneyCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        [collectionView setDidSelectPayWayCellBlock:^(NSString *str) {
            [self handleRechargeButtonWithStasus:YES];
        }];
    }
    return _collectionView;
}
-(UIButton *)rechargeBtn{
    if (!_rechargeBtn) {
        
        UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rechargeBtn = rechargeBtn;
        [self.view addSubview:rechargeBtn];
        
        [self handleRechargeButtonWithStasus:NO];
        
        [rechargeBtn addTarget:self action:@selector(rechargeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        rechargeBtn.frame = CGRectMake(0, SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
    }
    return _rechargeBtn;
}
-(void)handleRechargeButtonWithStasus:(BOOL)enable{
    _rechargeBtn.enabled = enable;
    
    if (enable) {
        _rechargeBtn.backgroundColor = COLOR_DF463E;
        [_rechargeBtn setTitle:self.btnTitle forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
    }else{
        _rechargeBtn.backgroundColor = COLOR_B7B7B7;
        [_rechargeBtn setTitle:self.btnTitle forState:UIControlStateDisabled];
        [_rechargeBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateDisabled];
    }
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)rechargeButtonClick:(UIButton*)btn{
    YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
    pushVC.titleStr = @"支付成功";
    [self.navigationController pushViewController:pushVC animated:NO];
}
-(void)makeData{
    [super makeData];
    
    self.collectionView.inforArray = @[
                                  @{@"title":@"书籍-设计师的自我修养",@"subTitle":@"2016年出版版本",@"price":@"502.12",@"num":@"2"},
                                  @{@"title":@"书籍-设计师的自我修养",@"subTitle":@"2016年出版版本",@"price":@"502.12",@"num":@"2"}];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"付款";
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载
-(NSString *)btnTitle{
    return [NSString stringWithFormat:@"%@ %@ %@",@"完成付款",@"$",@"452.01"];
}
#pragma mark - 其他


@end
