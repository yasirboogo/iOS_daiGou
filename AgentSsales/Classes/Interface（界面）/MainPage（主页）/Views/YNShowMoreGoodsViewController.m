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
#import "YNTerraceGoodsViewController.h"


@interface YNShowMoreGoodsViewController ()
{
    NSInteger _type;
}
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
    [self startNetWorkingRequestWithGetSpecialPurchase];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetSpecialPurchase{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type],
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize]};
    [YNHttpManagers getSpecialPurchaseWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.collectionView.dataArray = response[@"goodsArray"];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNMoreGoodsCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0,
                                  kUINavHeight,
                                  SCREEN_WIDTH,
                                  SCREEN_HEIGHT-kUINavHeight);
        YNMoreGoodsCollectionView *collectionView = [[YNMoreGoodsCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        [collectionView setDidSelectMoreGoodsCellBlock:^(NSString *goodsId) {
            YNTerraceGoodsViewController *pushVC = [[YNTerraceGoodsViewController alloc] init];
            pushVC.goodsId = [NSString stringWithFormat:@"%@",goodsId];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _collectionView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"sousuo_bai"] selectImg:nil isOnRight:YES btnClickBlock:^(BOOL isSlect) {
        YNSearchViewController *pushVC = [[YNSearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
    self.titleLabel.text = LocalSpecialPurchase;
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
