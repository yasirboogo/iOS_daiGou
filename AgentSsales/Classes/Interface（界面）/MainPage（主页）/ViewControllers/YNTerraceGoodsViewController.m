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

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface YNTerraceGoodsViewController ()

@property (nonatomic,strong) YNGoodsDetailsView * detailView;

@property (nonatomic,strong) YNGoodsDetailBtnsView * bottomBtnsView;

@property (nonatomic,strong) YNSelectParaView * selectParaView;

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
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求

#pragma mark - 视图加载
-(YNGoodsDetailsView *)detailView{
    if (!_detailView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.bottomBtnsView)-W_RATIO(2));
        YNGoodsDetailsView *detailView = [[YNGoodsDetailsView alloc] initWithFrame:frame];
        _detailView = detailView;
        [self.view addSubview:detailView];
        [detailView setDidSelectShareButtonClickBlock:^{
            [self thirdShare];
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
            [self.selectParaView showPopView:YES];
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
    }
    return _selectParaView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.detailView.dict = @[];
    self.bottomBtnsView.price = @"520.14";
    self.selectParaView.dict = @[];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"shoucang_bai"] selectImg:[UIImage imageNamed:@"shoucang_huang"] isOnRight:YES btnClickBlock:^(BOOL isShow) {
    }];
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"jinrugouwuche"] selectImg:nil isOnRight:YES btnClickBlock:^(BOOL isShow) {
    }];
    self.titleLabel.text = @"商品详情";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.detailView];
}
-(void)thirdShare{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
