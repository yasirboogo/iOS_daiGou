//
//  YNMoreClassViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMoreClassViewController.h"
#import "YNHotGoodsClassesView.h"

@interface YNMoreClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) YNHotGoodsClassesView * collectionView;

@end

@implementation YNMoreClassViewController

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
    [self makeUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求

#pragma mark - 视图加载
-(YNHotGoodsClassesView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0,0 ,SCREEN_WIDTH,SCREEN_HEIGHT-W_RATIO(90));
        YNHotGoodsClassesView *collectionView = [[YNHotGoodsClassesView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
    }
    return _collectionView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    self.collectionView.dataArray = @[
                                      @{@"image":@"testGoods",@"name":@"休闲鞋"},
                                      @{@"image":@"testGoods",@"name":@"休闲鞋"},
                                      @{@"image":@"testGoods",@"name":@"休闲鞋"},
                                      @{@"image":@"testGoods",@"name":@"休闲鞋"},
                                      @{@"image":@"testGoods",@"name":@"休闲鞋"},
                                      @{@"image":@"testGoods",@"name":@"休闲鞋"}];
}
-(void)makeUI{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
