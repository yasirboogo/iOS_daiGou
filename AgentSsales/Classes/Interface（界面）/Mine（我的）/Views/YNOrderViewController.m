//
//  YNOrderViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNOrderViewController.h"
#import "YNGoodsCartCollectionView.h"
#import "YNOrderDetailsViewController.h"

@interface YNOrderViewController ()

@property (nonatomic,weak) YNGoodsCartCollectionView * collectionView;

@end

@implementation YNOrderViewController

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
-(YNGoodsCartCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(84));
        YNGoodsCartCollectionView *collectionView = [[YNGoodsCartCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
        [collectionView setDidSelectOrderGoodsCell:^(NSString *str) {
            YNOrderDetailsViewController *pushVC = [[YNOrderDetailsViewController alloc] init];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _collectionView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    self.collectionView.dataArray = @[@"1",@"2"];
    
}
-(void)makeNavigationBar{
    
}
-(void)makeUI{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
