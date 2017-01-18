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
    NSMutableDictionary *dictM1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"subTitle",
                                   @NO,@"isSelect",
                                   @"1",@"num",
                                   @"500.14",@"price", nil];
    NSMutableDictionary *dictM2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"subTitle",
                                   @NO,@"isSelect",
                                   @"1",@"num",
                                   @"500.14",@"price", nil];
    NSMutableDictionary *dictM3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"subTitle",
                                   @NO,@"isSelect",
                                   @"1",@"num",
                                   @"500.14",@"price", nil];
    NSMutableDictionary *dictM4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"subTitle",
                                   @NO,@"isSelect",
                                   @"1",@"num",
                                   @"500.14",@"price", nil];
    NSMutableDictionary *dictM5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"subTitle",
                                   @NO,@"isSelect",
                                   @"1",@"num",
                                   @"500.14",@"price", nil];
    
    self.tableView.dataArrayM = [NSMutableArray arrayWithObjects:dictM1,dictM2,dictM3,dictM4,dictM5, nil];
    
}
-(void)makeNavigationBar{
    
}
-(void)makeUI{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
