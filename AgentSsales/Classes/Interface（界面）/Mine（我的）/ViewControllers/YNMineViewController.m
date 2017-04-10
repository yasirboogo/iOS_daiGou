//
//  MineViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#import "YNMineViewController.h"
#import "YNUpdateInforViewController.h"
#import "YNMineTableView.h"
#import "YNMineHeaderView.h"
#import "YNMineOrderViewController.h"
#import "YNLoginViewController.h"

@interface YNMineViewController ()
{
    NSInteger _type;
}
@property (nonatomic,strong) YNMineHeaderView *headerView;

@property (nonatomic,weak) YNMineTableView *tableView;

@end

@implementation YNMineViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([DEFAULTS valueForKey:kUserLoginInfors]) {
        [self startNetWorkingRequestWithUserInfors];
    }
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
-(void)startNetWorkingRequestWithUserInfors{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"]};
    [YNHttpManagers getUserInforsWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            NSArray *moneyArray = @[@"rmb",@"myr",@"us"];
            self.headerView.headImg = response[@"headimg"];
            self.headerView.nickName = response[@"nickname"];
            
            self.headerView.restMoney = [NSString stringWithFormat:@"%.2f",[response[moneyArray[_type]] floatValue]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNMineHeaderView *)headerView{
    if (!_headerView) {
        YNMineHeaderView *headerView = [[YNMineHeaderView alloc] init];
        _headerView = headerView;
        [self.view addSubview:headerView];
        [self.view bringSubviewToFront:self.navView];
        [headerView setDidSelectScrollViewButtonClickBlock:^(NSInteger index) {
            if ([DEFAULTS valueForKey:kUserLoginInfors]) {
                YNMineOrderViewController *pushVC = [[YNMineOrderViewController alloc] init];
                pushVC.index = index;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else{
                [self tipsUserNotLogin];
            }
        }];
    }
    return _headerView;
}

-(YNMineTableView *)tableView{
    if (!_tableView) {
        YNMineTableView *tableView = [[YNMineTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];

        NSArray<NSString*> *viewControllers = @[@"YNMineCollectViewController",
                                                @"YNMineDistributionViewController",
                                                @"YNMineWalletViewController",
                                                @"YNMineCouponViewController",
                                                @"YNAddressViewController",
                                                @"YNMineCodeViewController",
                                                @"YNSettingViewController"];
        
        [tableView setDidSelectMineTableViewCellClickBlock:^(NSInteger idx) {
            
            if ([DEFAULTS valueForKey:kUserLoginInfors] || idx == 6) {
                YNBaseViewController *pushVC = [[NSClassFromString(viewControllers[idx]) alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else{
                [self tipsUserNotLogin];
            }
        }];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)tipsUserNotLogin{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先登录" message:@"未登录用户请先登录" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:LocalDone style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        YNLoginViewController *pushVC= [[YNLoginViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:LocalCancel style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
    
    NSArray *moneyArray = @[@"rmb",@"myr",@"us"];
    
    if ([DEFAULTS valueForKey:kUserLoginInfors]) {
        NSDictionary *userLoginInfors = [DEFAULTS valueForKey:kUserLoginInfors];
        
        self.headerView.headImg = userLoginInfors[@"headimg"];
        self.headerView.nickName = userLoginInfors[@"nickname"];
        
        self.headerView.restMoney = [NSString stringWithFormat:@"%.2f",[userLoginInfors[moneyArray[_type]] floatValue]];
    }else{
        self.headerView.headImg = nil;
        self.headerView.nickName = @"hello";
        
        self.headerView.restMoney = @"0.00";
    }
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.navView.backgroundColor = COLOR_CLEAR;
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"gerenziliao"] selectImg:nil isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        if ([DEFAULTS valueForKey:kUserLoginInfors]) {
            YNUpdateInforViewController *pushVC = [[YNUpdateInforViewController alloc] init];
            [weakSelf.navigationController pushViewController:pushVC animated:NO];
        }else{
            [weakSelf tipsUserNotLogin];
        }
    }];
}
-(void)makeUI{
    [super makeUI];
    
    [self.view addSubview:self.tableView];
}
#pragma mark - 数据懒加载
#pragma mark - 其他

@end
