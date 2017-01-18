//
//  YNMineCouponViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/11.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineCouponViewController.h"
#import "YNCouponListViewController.h"

@interface YNMineCouponViewController ()<TYPagerControllerDataSource>

@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@end


@implementation YNMineCouponViewController

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
        pagerController.view.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        [self addChildViewController:pagerController];
        [self.view addSubview:pagerController.view];
        
    }
    return _pagerController;
}
#pragma mark - 代理实现
#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController
{
    return 2;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    NSArray * titles = @[@"可使用",@"已失效"];
    return titles[index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    YNCouponListViewController *couponVC = [[YNCouponListViewController alloc] init];
    if (index == 0) {
        couponVC.isInvalid = NO;
    }else if (index == 1){
        couponVC.isInvalid = YES;
    }
    return couponVC;
}

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];

    self.titleLabel.text = @"我的优惠券";
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end


