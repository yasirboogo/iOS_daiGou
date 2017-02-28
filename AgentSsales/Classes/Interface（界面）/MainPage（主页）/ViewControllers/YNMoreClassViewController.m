//
//  YNMoreClassViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMoreClassViewController.h"
#import "YNHotGoodsClassesView.h"
#import "YNTerraceGoodsViewController.h"

@interface YNMoreClassViewController ()
{
    NSInteger _type;
    NSInteger _pageIndex;
    NSInteger _pageSize;
}
@property (nonatomic,weak) YNHotGoodsClassesView * collectionView;

@end

@implementation YNMoreClassViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startNetWorkingRequestWithGoodsClassSearch];
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
-(void)startNetWorkingRequestWithGoodsClassSearch{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type],
                             @"pageIndex":[NSNumber numberWithInteger:_pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:_pageSize],
                             @"classId":_classId};
    [YNHttpManagers goodsClassSearchWithParams:params success:^(id response) {
        self.collectionView.dataArray = response;
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNHotGoodsClassesView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0,0 ,SCREEN_WIDTH,SCREEN_HEIGHT-W_RATIO(90));
        YNHotGoodsClassesView *collectionView = [[YNHotGoodsClassesView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        [collectionView setDidSelectHotGoodsClassesCellBlock:^(NSInteger index) {
            YNTerraceGoodsViewController *pushVC = [[YNTerraceGoodsViewController alloc] init];
            pushVC.goodsId = self.collectionView.dataArray[index][@"goodsId"];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _collectionView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    _type = [LanguageManager currentLanguageIndex];
    _pageIndex = 1;
    _pageSize = 10;
}
-(void)makeUI{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
