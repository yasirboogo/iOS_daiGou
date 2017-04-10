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
#import "YNShowEmptyView.h"

@interface YNMoreClassViewController ()
{
    NSInteger _type;
    NSInteger _pageIndex;
    NSInteger _pageSize;
}
@property (nonatomic,weak) YNHotGoodsClassesView * collectionView;

@property (nonatomic,weak) YNShowEmptyView * emptyView;

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
        [self handleEndMJRefresh];
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self handleMJRefreshComplateWithResponse:response[@"goodsArray"]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
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
            pushVC.goodsId = self.collectionView.dataArrayM[index][@"goodsId"];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        
        collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageIndex = 1;
            [collectionView.mj_footer endRefreshing];
            [self startNetWorkingRequestWithGoodsClassSearch];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        collectionView.mj_header.automaticallyChangeAlpha = YES;
        collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageIndex += 1;
            [collectionView.mj_header endRefreshing];
            [self startNetWorkingRequestWithGoodsClassSearch];
        }];
    }
    return _collectionView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, W_RATIO(2), SCREEN_WIDTH, SCREEN_HEIGHT-W_RATIO(90)-W_RATIO(2));
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wudizhi"];
        emptyView.tips = @"当前分类暂无内容";
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleMJRefreshComplateWithResponse:(NSArray*)response{
    if (_pageIndex == 1) {
        _collectionView.dataArrayM = [NSMutableArray arrayWithArray:response];
        self.emptyView.hidden = _collectionView.dataArrayM.count;
    }else{
        [_collectionView.dataArrayM addObjectsFromArray:response];
    }
    [_collectionView reloadData];
    if (response.count == 0) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}
-(void)handleEndMJRefresh{
    if (_pageIndex == 1) {
        [self.collectionView.mj_header endRefreshing];
    }else{
        [self.collectionView.mj_footer endRefreshing];
    }
}
-(void)makeData{
    _type = [LanguageManager currentLanguageIndex];
    _pageIndex = 1;
    _pageSize = 12;
}
-(void)makeUI{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
