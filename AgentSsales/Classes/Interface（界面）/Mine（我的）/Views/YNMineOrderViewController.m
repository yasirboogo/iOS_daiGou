//
//  YNMineOrderViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineOrderViewController.h"
#import "YNOrderViewController.h"

@interface YNMineOrderViewController ()<TYPagerControllerDataSource>

@property (nonatomic, strong) NSArray *btnTitles;

@property (nonatomic, weak) TYTabButtonPagerController *pagerController;

@end

@implementation YNMineOrderViewController
#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.titleLabel.text = LocalMyOrder;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pagerController reloadData];
    [self.pagerController moveToControllerAtIndex:self.index animated:NO];
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
        pagerController.normalTextColor = COLOR_2B363C;
        pagerController.selectedTextColor = COLOR_DF463E;
        pagerController.normalTextFont = FONT(30);
        pagerController.selectedTextFont = FONT(36);
        pagerController.contentTopEdging = W_RATIO(84);
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
    return self.btnTitles.count;
}
- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    return _btnTitles[index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    YNOrderViewController *orderVC = [[YNOrderViewController alloc] init];
    orderVC.index = index;
    return orderVC;
}
#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载
-(NSArray *)btnTitles{
    if (!_btnTitles) {
        _btnTitles = @[LocalAllOrder,LocalWaitPay,LocalWaitHandle,LocalWaitPPay,LocalWaitSend,LocalWaitReceive,LocalCompleted];
    }
    return _btnTitles;
}
#pragma mark - 其他


@end
