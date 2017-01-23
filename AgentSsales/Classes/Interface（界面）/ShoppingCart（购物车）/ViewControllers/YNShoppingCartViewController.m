//
//  ShoppingCartViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#import "YNShoppingCartViewController.h"
#import "YNPrefectInforViewController.h"
#import "YNFirmOrderViewController.h"
#import "YNGoodsViewController.h"
#import "YNGoodsSubmitView.h"
#import "YNTipsPerfectInforView.h"

@interface YNShoppingCartViewController ()<TYPagerControllerDataSource>

@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@property (nonatomic, strong) YNGoodsSubmitView *submitView;

@property (nonatomic, strong) YNTipsPerfectInforView *inforView;

@property (nonatomic, assign) NSInteger index;

@end


@implementation YNShoppingCartViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pagerController reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求

#pragma mark - 视图加载
-(TYTabButtonPagerController *)pagerController{
    if (!_pagerController) {
        TYTabButtonPagerController *pagerController = [[TYTabButtonPagerController alloc] init];
        _pagerController = pagerController;
        pagerController.dataSource = self;
        pagerController.cellSpacing = W_RATIO(100);
        pagerController.cellWidth = pagerController.cellSpacing*1.5;
        pagerController.collectionLayoutEdging = (SCREEN_WIDTH-pagerController.cellSpacing-pagerController.cellWidth*2)/2.0;
        pagerController.normalTextColor = COLOR_666666;
        pagerController.selectedTextColor = COLOR_DF463E;
        pagerController.normalTextFont = FONT(30);
        pagerController.selectedTextFont = FONT(36);
        pagerController.contentTopEdging = W_RATIO(90);
        pagerController.barStyle = TYPagerBarStyleProgressBounceView;
        pagerController.view.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.submitView));
        [self addChildViewController:pagerController];
        [self.view addSubview:pagerController.view];
        [pagerController setDidScrollToTabPageIndexHandle:^(NSInteger index) {
            self.index = index;
        }];
        
    }
    return _pagerController;
}
-(YNGoodsSubmitView *)submitView{
    if (!_submitView) {
        CGRect frame = CGRectMake(0,SCREEN_HEIGHT-kUITabBarH-W_RATIO(90), SCREEN_WIDTH, W_RATIO(90));
        YNGoodsSubmitView *submitView = [[YNGoodsSubmitView alloc] initWithFrame:frame];
        _submitView = submitView;
        [self.view addSubview:submitView];
        [submitView setHandleSubmitButtonBlock:^{
            if (self.index == 0 && self.isPrefect == NO) {
                [self.inforView showPopView:YES];
            }else if (self.isPrefect == YES){
                YNFirmOrderViewController *pushCV = [[YNFirmOrderViewController alloc] init];
                pushCV.index = self.index;
                [self.navigationController pushViewController:pushCV animated:NO];
            }
            
        }];
    }
    return _submitView;
}
-(YNTipsPerfectInforView *)inforView{
    if (!_inforView) {
        CGRect frame = CGRectMake((SCREEN_WIDTH-W_RATIO(536))/2.0, (SCREEN_HEIGHT-W_RATIO(506))/2.0, W_RATIO(536), W_RATIO(504));
        YNTipsPerfectInforView *inforView = [[YNTipsPerfectInforView alloc] initWithFrame:frame img:[UIImage imageNamed:@"wanshanziliao_tubiao"] title:@"完善个人资料" tips:@"需要完善个人资料才能购买哦~" btnTitle:@"去完善"];
        _inforView = inforView;
//        inforView.isTapGesture = YES;
        [inforView setDidSelectSubmitButtonBlock:^{
            YNPrefectInforViewController *pushCV = [[YNPrefectInforViewController alloc] init];
            [self.navigationController pushViewController:pushCV animated:NO];
        }];
    }
    return _inforView;
}
#pragma mark - 代理实现
#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController
{
    return 2;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    NSArray * titles = @[@"代购商品",@"平台商品"];
    return titles[index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    YNGoodsViewController *goodsVC = [[YNGoodsViewController alloc] init];
    return goodsVC;
}

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.submitView.dict = @{@"allPrice":@"500.32",@"allNum":@"2"};
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    [self addNavigationBarBtnWithTitle:@"全选" selectTitle:@"取消" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isShow) {
    }];
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"shanchu_gouwuche"] selectImg:[UIImage imageNamed:@"shanchu_gouwuche"] isOnRight:NO btnClickBlock:^(BOOL isShow) {
    }];
    self.titleLabel.text = @"购物车";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.submitView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end

