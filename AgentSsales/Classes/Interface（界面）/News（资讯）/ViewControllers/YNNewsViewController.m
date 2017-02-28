//
//  NewsViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#import "YNNewsViewController.h"
#import "YNListViewController.h"

@interface YNNewsViewController ()<TYPagerControllerDataSource>
{
    NSInteger _type;
}
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@end

@interface YNNewsViewController ()


@end

@implementation YNNewsViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithAllNewsClass];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithAllNewsClass{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers getAllNewsClassWithParams:params success:^(id response) {
        self.dataArray = response;
        [self.pagerController reloadData];
    } failure:^(NSError *error) {
    }];
}
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
    return _dataArray.count;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    return _dataArray[index][@"name"];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    YNListViewController *newsVC = [[YNListViewController alloc] init];
    newsVC.imgInfor = _dataArray[index];
    return newsVC;
}

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = kLocalizedString(@"newsCenter",@"资讯中心");
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
