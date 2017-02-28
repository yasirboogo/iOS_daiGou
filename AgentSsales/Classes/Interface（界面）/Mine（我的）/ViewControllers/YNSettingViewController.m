//
//  YNSettingViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSettingViewController.h"
#import "YNSettingTableView.h"
#import "YNTipsSuccessBtnsView.h"
#import "YNSendSuggestViewController.h"
#import "YNDocumentExplainViewController.h"
#import "YNLoginViewController.h"
#import "AppDelegate.h"

@interface YNSettingViewController ()

@property (nonatomic,weak) YNSettingTableView * tableView;

@property (nonatomic,weak) YNTipsSuccessBtnsView * btnsView;

@end

@implementation YNSettingViewController

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
-(void)startNetWorkingRequestWithSetIsPushMsg:(NSString*)isPushMsg{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"type":isPushMsg};
    [YNHttpManagers setPushMsgWithParams:params success:^(id response) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNSettingTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH,YF(self.btnsView)-kUINavHeight);
        YNSettingTableView *tableView = [[YNSettingTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectIsPushOnBlock:^(BOOL isOn) {
            [self startNetWorkingRequestWithSetIsPushMsg:[NSString stringWithFormat:@"%d",isOn]];
        }];
        [tableView setDidSelectSettingCellBlock:^(NSInteger index) {
            if (index == 1) {
                YNSendSuggestViewController *pushVC = [[YNSendSuggestViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if (index == 2){
                YNDocumentExplainViewController *pushVC = [[YNDocumentExplainViewController alloc] init];
                pushVC.status = 1;
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
    }
    return _tableView;
}
-(YNTipsSuccessBtnsView *)btnsView{
    if (!_btnsView) {
        YNTipsSuccessBtnsView *btnsView = [[YNTipsSuccessBtnsView alloc] init];
        _btnsView = btnsView;
        [self.view addSubview:btnsView];
        btnsView.btnStyle = UIButtonStyle1;
        [btnsView setDidSelectBottomButtonClickBlock:^(NSString *str) {
            UINavigationController *nVc = [[UINavigationController alloc] initWithRootViewController:[[YNLoginViewController alloc] init]];
            
            AppDelegate *appDelegate =
            (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = nVc;
        }];
    }
    return _btnsView;
}

#pragma mark - 代理实现
-(void)popActionSheet{

}
-(void)popActionSheetWithTitles:(NSArray<NSString*>*)titles{
}

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.btnsView.btnTitles = @[@"退出登录"];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = kLocalizedString(@"settings",@"设置");
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
