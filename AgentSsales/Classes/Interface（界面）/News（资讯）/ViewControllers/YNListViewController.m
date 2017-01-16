//
//  YNListViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/12.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNListViewController.h"
#import "YNNewsListTableView.h"
#import "YNNewsDetailViewController.h"

@interface YNListViewController ()

@property (nonatomic,weak) YNNewsListTableView * tableView;

@end

@implementation YNListViewController

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
-(YNNewsListTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUITabBarH-kUINavHeight-W_RATIO(84));
        YNNewsListTableView *tableView = [[YNNewsListTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectNewsListCellBlock:^(NSString *str) {
            YNNewsDetailViewController *pushVC = [[YNNewsDetailViewController alloc] init];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    self.tableView.dataArray = @[@{@"bigImg":@"testGoods",@"name":@"维吾尔族自治区第二届双赢摄影绘画书画展"},
                                 @{@"name":@"维吾尔族自治区第二届双赢摄影绘画书画展",@"time":@"2016-10-21",@"comment":@"123",@"image":@"testHotClass"},
                                 @{@"name":@"维吾尔族自治区第二届双赢摄影绘画书画展",@"time":@"2016-10-21",@"comment":@"123",@"image":@"testHotClass"},
                                 @{@"name":@"维吾尔族自治区第二届双赢摄影绘画书画展",@"time":@"2016-10-21",@"comment":@"123",@"image":@"testHotClass"},
                                 @{@"name":@"维吾尔族自治区第二届双赢摄影绘画书画展",@"time":@"2016-10-21",@"comment":@"123",@"image":@"testHotClass"},
                                 @{@"name":@"维吾尔族自治区第二届双赢摄影绘画书画展",@"time":@"2016-10-21",@"comment":@"123",@"image":@"testHotClass"},
                                 @{@"name":@"维吾尔族自治区第二届双赢摄影绘画书画展",@"time":@"2016-10-21",@"comment":@"123",@"image":@"testHotClass"}];
}
-(void)makeNavigationBar{
    
}
-(void)makeUI{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
