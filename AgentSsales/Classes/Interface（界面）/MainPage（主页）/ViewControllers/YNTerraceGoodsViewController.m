//
//  YNTerraceGoodsViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/4.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNTerraceGoodsViewController.h"
#import "YNGoodsDetailsView.h"
#import "YNGoodsDetailBtnsView.h"
#import "YNSelectParaView.h"
#import "YNShareThirdSelectView.h"
#import "YNShoppingCartViewController.h"

@interface YNTerraceGoodsViewController ()
{
    NSInteger _type;
    UIButton *_collectBtn;
}
@property (nonatomic,strong) YNGoodsDetailsView * detailView;

@property (nonatomic,strong) YNGoodsDetailBtnsView * bottomBtnsView;

@property (nonatomic,strong) YNSelectParaView * selectParaView;

@property (nonatomic,strong) YNShareThirdSelectView * selectShareView;

@end

@implementation YNTerraceGoodsViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithGetGoodsDetails];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetGoodsDetails{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"goodsId":_goodsId,
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers getGoodsDetailsWithParams:params success:^(id response) {
        self.detailView.dataDict = response;
        self.bottomBtnsView.price = response[@"salesprice"];
        _collectBtn.selected = [response[@"iscollection"] boolValue];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithCollectGoods{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"goodsId":_goodsId};
    [YNHttpManagers collectGoodsWithParams:params success:^(id response) {
        _collectBtn.selected = [response[@"iscollection"] boolValue];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithSelectGoodsType{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type],
                             @"goodsId":_goodsId};
    [YNHttpManagers selectGoodsTypeWithParams:params success:^(id response) {
        self.selectParaView.dataArray = response;
        [self.selectParaView showPopView:YES];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithJoinToShoppingCartWithStyle:(NSString*)style Count:(NSString*)count{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"goodsId":_goodsId,
                             @"count":count,
                             @"style":style};
    [YNHttpManagers joinToShoppingCartWithParams:params success:^(id response) {
        
        
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithShareToThird{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"wayId":[NSNumber numberWithInteger:1]};
    [YNHttpManagers shareToThirdWithParams:params success:^(id response) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNGoodsDetailsView *)detailView{
    if (!_detailView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.bottomBtnsView)-W_RATIO(2));
        YNGoodsDetailsView *detailView = [[YNGoodsDetailsView alloc] initWithFrame:frame];
        _detailView = detailView;
        [self.view addSubview:detailView];
        [detailView setDidSelectShareButtonClickBlock:^{
            [self.selectShareView showPopView:YES];
        }];
    }
    return _detailView;
}
-(YNGoodsDetailBtnsView *)bottomBtnsView{
    if (!_bottomBtnsView) {
        YNGoodsDetailBtnsView *bottomBtnsView = [[YNGoodsDetailBtnsView alloc] init];
        _bottomBtnsView = bottomBtnsView;
        [self.view addSubview:bottomBtnsView];
        bottomBtnsView.backgroundColor = COLOR_FFFFFF;
        bottomBtnsView.frame = CGRectMake(0, SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        [bottomBtnsView setDidSelectAddCartButtonClickBlock:^{
            [self startNetWorkingRequestWithSelectGoodsType];
        }];
        [bottomBtnsView setDidSelectBuyButtonClickBlock:^{
        }];
    }
    return _bottomBtnsView;
}
-(YNSelectParaView *)selectParaView{
    if (!_selectParaView) {
        CGRect frame = CGRectMake(0, SCREEN_HEIGHT-SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_WIDTH);
        YNSelectParaView *selectParaView = [[YNSelectParaView alloc] initWithFrame:frame];
        _selectParaView = selectParaView;
        [selectParaView setDidSelectSubmitButtonBlock:^(NSString *style, NSString *count) {
            [self startNetWorkingRequestWithJoinToShoppingCartWithStyle:style Count:count];
        }];
    }
    return _selectParaView;
}
-(YNShareThirdSelectView *)selectShareView{
    if (!_selectShareView) {
        CGRect frame = CGRectMake(0,SCREEN_HEIGHT- W_RATIO(450), SCREEN_WIDTH,  W_RATIO(450));
        YNShareThirdSelectView *selectShareView = [[YNShareThirdSelectView alloc] initWithFrame:frame];
        _selectShareView = selectShareView;
        [selectShareView setDidSelectShareThirdSelectBlick:^(NSInteger index) {
            [self thirdShareWithIndex:index];
        }];
    }
    return _selectShareView;
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
    _collectBtn = [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"shoucang_bai"] selectImg:[UIImage imageNamed:@"shoucang_huang"] isOnRight:YES btnClickBlock:^(BOOL isShow) {
        [weakSelf startNetWorkingRequestWithCollectGoods];
    }];
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"jinrugouwuche"] selectImg:nil isOnRight:YES btnClickBlock:^(BOOL isShow) {
        YNShoppingCartViewController *pushVC = [[YNShoppingCartViewController alloc] init];
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
    self.titleLabel.text = @"商品详情";
}
-(void)makeUI{
    [super makeUI];
}
-(void)thirdShareWithIndex:(NSInteger)index{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
