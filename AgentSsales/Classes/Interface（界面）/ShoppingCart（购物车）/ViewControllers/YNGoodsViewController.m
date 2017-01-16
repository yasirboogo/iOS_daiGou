//
//  YNGoodsViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsViewController.h"
#import "YNGoodsCartTableView.h"

@interface YNGoodsViewController ()

@property (nonatomic,weak) YNGoodsCartTableView * tableView;

@end

@implementation YNGoodsViewController
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
-(YNGoodsCartTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-kUITabBarH-W_RATIO(84)-W_RATIO(90));
        YNGoodsCartTableView *tableView = [[YNGoodsCartTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    self.tableView.dataArray = @[@"1",@"2"];
    
}
-(void)makeNavigationBar{
    
}
-(void)makeUI{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
