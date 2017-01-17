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

@interface YNOrderDetailsViewController ()

@property (nonatomic,weak) YNOrderDetailsCollectionView * collectionView;

@property (nonatomic,weak) YNTipsSuccessBtnsView *btnsView;

@end

@implementation YNOrderDetailsViewController

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
-(YNOrderDetailsCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH,SCREEN_HEIGHT-kUINavHeight-HEIGHTF(_btnsView));
        YNOrderDetailsCollectionView *collectionView = [[YNOrderDetailsCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
    }
    return _collectionView;
}
-(YNTipsSuccessBtnsView *)btnsView{
    if (!_btnsView) {
        YNTipsSuccessBtnsView *btnsView = [[YNTipsSuccessBtnsView alloc] init];
        _btnsView = btnsView;
        [self.view addSubview:btnsView];
        btnsView.btnStyle = UIButtonStyle2;
        [btnsView setDidSelectBottomButtonClickBlock:^(NSString *str) {
            NSLog(@"%@",str);
        }];
    }
    return _btnsView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    
    self.btnsView.btnTitles = @[@"确认收货",@"查看物流"];
    
    self.collectionView.dict = @{@"manMsg":@{@"name":@"李小龙",
                                             @"phone":@"13631499887",
                                             @"address":@"广东省广州市天河区五山街华南农业大学华南区12栋312"},
                                 @"orderMsg":@{@"code":@"1234567890",
                                               @"buyTime":@"2016年6月21日 14：16",
                                               @"payTime":@"2016年6月22日 14：16",
                                               @"address":@"广西桂林",
                                               @"status":@"代收款",},
                                 @"goodsMsg":@[],
                                 };
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"订单详情";
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
