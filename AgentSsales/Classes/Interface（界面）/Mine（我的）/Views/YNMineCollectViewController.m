//
//  YNMineCollectViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineCollectViewController.h"
#import "YNMineCollectTableView.h"
#import "YNTerraceGoodsViewController.h"

@interface YNMineCollectViewController ()
{
    NSInteger _type;
    NSMutableString *_collectionId;
}
@property (nonatomic,strong)UIButton *editBtn;

@property (nonatomic,assign)BOOL isEdit;

@property (nonatomic,weak)YNMineCollectTableView *tableView;

@property (nonatomic,weak)UIView *btnsView;

@property (nonatomic,weak)YNShowEmptyView *emptyView;

@end

@implementation YNMineCollectViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetUserCollection{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize],
                             @"type":[NSNumber numberWithInteger:_type]};
    
    [YNHttpManagers getUserCollectionWithParams:params success:^(id response) {
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
-(void)startNetWorkingRequestWithEditUserCollection{
    NSDictionary *params = @{@"collectionId":_collectionId};
    [YNHttpManagers editUserCollectionWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self startNetWorkingRequestWithGetUserCollection];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNMineCollectTableView *)tableView{
    if (!_tableView) {
        YNMineCollectTableView *tableView = [[YNMineCollectTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectMineCollectCellBlock:^(NSString *goodsId) {
            YNTerraceGoodsViewController *pushVC = [[YNTerraceGoodsViewController alloc] init];
            pushVC.goodsId = goodsId;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageIndex = 1;
            [tableView.mj_footer endRefreshing];
            [self startNetWorkingRequestWithGetUserCollection];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            [tableView.mj_header endRefreshing];
            [self startNetWorkingRequestWithGetUserCollection];
        }];
    }
    return _tableView;
}
-(UIView *)btnsView{
    if (!_btnsView) {
        UIView *btnsView = [[UIView alloc] init];
        _btnsView = btnsView;
        [self.view addSubview:btnsView];
        btnsView.size = CGSizeMake(SCREEN_WIDTH, W_RATIO(100));
        
        NSArray<NSString*> *btnTitles = @[LocalSelectAll,LocalDelete];
        [btnTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnsView addSubview:bottomBtn];
            bottomBtn.frame = CGRectMake(idx*SCREEN_WIDTH/btnTitles.count, 0, WIDTHF(btnsView)/btnTitles.count,HEIGHTF(btnsView));
            [bottomBtn setTitle:title forState:UIControlStateNormal];
            [bottomBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
            bottomBtn.titleLabel.font = FONT(36);
            bottomBtn.tag = idx;
            [bottomBtn addTarget:self action:@selector(handleBottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (idx == 0) {//全选按钮
                bottomBtn.backgroundColor = COLOR_5A5A5A;
            }else if (idx == 1){//删除按钮
                bottomBtn.backgroundColor = COLOR_DF463E;
            }
        }];
        
    }
    return _btnsView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, kUINavHeight+W_RATIO(2), SCREEN_WIDTH, SCREEN_HEIGHT - kUINavHeight-W_RATIO(2));
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wushoucang"];
        emptyView.tips = @"暂无收藏商品";
    }
    return _emptyView;
}
#pragma mark - 代理实现
-(void)handleBottomButtonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.tag == 0) {//全选按钮
        [_tableView.selectArrayM enumerateObjectsUsingBlock:^(NSNumber * _Nonnull isSelect, NSUInteger idx, BOOL * _Nonnull stop) {
            [_tableView.selectArrayM replaceObjectAtIndex:idx withObject:@YES];
        }];
        [_tableView reloadData];
    }else if (btn.tag == 1){//删除按钮
        _collectionId = [NSMutableString string];
        [_tableView.selectArrayM enumerateObjectsUsingBlock:^(NSNumber * _Nonnull isSelect, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([isSelect boolValue]) {
                [_collectionId appendFormat:@",%@",_tableView.dataArrayM[idx][@"collectionId"]];
            }
        }];
        if (_collectionId.length) {
            [_collectionId deleteCharactersInRange:NSMakeRange(0, 1)];
            [self startNetWorkingRequestWithEditUserCollection];
        }else{
            HDAlertView *alertView = [[HDAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"未选择删除商品，无法删除"];
            [alertView addButtonWithTitle:@"重新选择" type:HDAlertViewButtonTypeDestructive handler:^(HDAlertView *alertView) {
                [alertView dismissAnimated:YES cleanup:YES];
            }];
            [alertView addButtonWithTitle:@"取消编辑" type:HDAlertViewButtonTypeDestructive handler:^(HDAlertView *alertView) {
                _editBtn.selected = NO;
                self.isEdit = NO;
                self.tableView.isEdit = NO;
            }];
            [alertView show];
        }
    }
}
#pragma mark - 函数、消息
-(void)handleMJRefreshComplateWithResponse:(NSArray*)response{
    if (self.pageIndex == 1) {
        _tableView.dataArrayM = [NSMutableArray arrayWithArray:response];
        self.emptyView.hidden = _tableView.dataArrayM.count;
        self.editBtn.hidden = !self.emptyView.hidden;
    }else{
        [_tableView.dataArrayM addObjectsFromArray:response];
    }
    _tableView.selectArrayM = [NSMutableArray array];
    [_tableView reloadData];
    if (response.count == 0) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}
-(void)handleEndMJRefresh{
    if (self.pageIndex == 1) {
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
    self.isEdit = NO;
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];

    __weak typeof(self) weakSelf = self;
    _editBtn = [self addNavigationBarBtnWithTitle:LocalEdit selectTitle:LocalDone font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        weakSelf.isEdit = isSelect;
        weakSelf.tableView.isEdit = isSelect;
        weakSelf.editBtn.hidden = !weakSelf.tableView.dataArrayM.count;
        weakSelf.emptyView.hidden = weakSelf.tableView.dataArrayM.count;

    }];
    self.titleLabel.text = LocalMyCollection;
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    
    self.btnsView.frame = CGRectMake(0,SCREEN_HEIGHT-W_RATIO(100)*isEdit, SCREEN_WIDTH, W_RATIO(100)*isEdit);
    self.tableView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, YF(_btnsView)-kUINavHeight);

}
#pragma mark - 其他

@end
