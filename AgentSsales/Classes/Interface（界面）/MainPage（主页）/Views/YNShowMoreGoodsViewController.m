//
//  YNShowMoreGoodsViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/28.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNShowMoreGoodsViewController.h"
#import "YNSearchViewController.h"
#import "YNMoreGoodsCollectionView.h"

@interface YNShowMoreGoodsViewController ()

@property (nonatomic,weak) YNMoreGoodsCollectionView* collectionView;

@end

@implementation YNShowMoreGoodsViewController

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
-(YNMoreGoodsCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0,
                                  kUINavHeight,
                                  SCREEN_WIDTH,
                                  SCREEN_HEIGHT-kUINavHeight-kUITabBarH);
        YNMoreGoodsCollectionView *collectionView = [[YNMoreGoodsCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
    }
    return _collectionView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.collectionView.dataArray = @[
                           @{@"image":@"testGoods",@"name":@"米勒洗衣机",@"version":@"产品型号J-GRY4",@"price":@"500.14",@"mark":@"￥"},
                           @{@"image":@"testGoods",@"name":@"米勒洗衣机",@"version":@"产品型号J-GRY4",@"price":@"500.14",@"mark":@"￥"}];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"sousuo_bai"] selectImg:nil isOnRight:YES btnClickBlock:^(BOOL isSlect) {
        YNSearchViewController *pushVC = [[YNSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
    
    self.titleLabel.text = NSLS(@"特色惠购", @"特色惠购");
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
