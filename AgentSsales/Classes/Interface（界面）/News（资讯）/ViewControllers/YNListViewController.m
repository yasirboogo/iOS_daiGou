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
#import "YNTerraceGoodsViewController.h"
#import "YNWebViewController.h"

@interface YNListViewController ()
{
    NSInteger _type;
    NSInteger _pageIndex;
    NSInteger _pageSize;
}
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
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetAdvertise{
    NSDictionary *params = @{@"status":@2};
    [YNHttpManagers getAdvertiseWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            if (_pageIndex == 1) {
                _tableView.adArrayM = [NSMutableArray arrayWithObject:response];
            }else{
                [_tableView.adArrayM appendObject:response];
            }
            [_tableView reloadData];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithGetOneNewsList{
    NSString *infoId = [NSString stringWithFormat:@"%@",self.imgInfor[@"infoId"]];
    NSNumber *type = [NSNumber numberWithInteger:_type];
    NSNumber *pageIndex = [NSNumber numberWithInteger:_pageIndex];
    NSNumber *pageSize = [NSNumber numberWithInteger:_pageSize];
    
    NSDictionary *params = NSDictionaryOfVariableBindings(infoId,type,pageIndex,pageSize);
    [YNHttpManagers getOneNewsListWithParams:params success:^(id response) {
        [self handleEndMJRefresh];
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self handleMJRefreshComplateWithResponse:response[@"infoArray"]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
    }];
}
#pragma mark - 视图加载
-(YNNewsListTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUITabBarH-kUINavHeight-W_RATIO(84));
        YNNewsListTableView *tableView = [[YNNewsListTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectNewsListCellBlock:^(NSString *messageId) {
            YNNewsDetailViewController *pushVC = [[YNNewsDetailViewController alloc] init];
            pushVC.messageId = messageId;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        [tableView setDidSelectAdCellBlock:^(NSString *type, NSString *url) {
            if ([type integerValue] == 1) {
                YNTerraceGoodsViewController *pushVC = [[YNTerraceGoodsViewController alloc] init];
                pushVC.goodsId = url;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([type integerValue] == 2){
                YNWebViewController *pushVC = [[YNWebViewController alloc] init];
                pushVC.url = url;
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageIndex = 1;
            [tableView.mj_footer endRefreshing];
            [self startNetWorkingRequestWithGetOneNewsList];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _pageIndex += 1;
            [tableView.mj_header endRefreshing];
            [self startNetWorkingRequestWithGetOneNewsList];
        }];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    _type = [LanguageManager currentLanguageIndex];
    _pageIndex = 1;
    _pageSize = 3;
}
-(void)makeNavigationBar{
    
}
-(void)makeUI{
    
}
-(void)handleMJRefreshComplateWithResponse:(NSArray*)response{
    self.tableView.imgInfor = self.imgInfor;
    if (_pageIndex == 1) {
        _tableView.dataArrayM = [NSMutableArray arrayWithArray:response];
    }else{
        [_tableView.dataArrayM addObjectsFromArray:response];
    }
    if (response.count) {
        [self startNetWorkingRequestWithGetAdvertise];
    }else{
        
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}
-(void)handleEndMJRefresh{
    if (_pageIndex == 1) {
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
