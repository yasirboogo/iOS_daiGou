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
#import "YNChatServiceViewController.h"
#import "YNBaseNavViewController.h"

@interface YNSettingViewController ()

@property (nonatomic,weak) YNSettingTableView * tableView;

@property (nonatomic,weak) YNTipsSuccessBtnsView * btnsView;

@property (nonatomic,assign) BOOL isPushOn;

@end

@implementation YNSettingViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //融云客服界面导航栏处理
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
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
-(void)startNetWorkingRequestWithSetPushMsg{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],@"type":[NSNumber numberWithBool:_isPushOn]};
    [YNHttpManagers setPushMsgWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showImage:nil status:LocalSetSuccess];
            [SVProgressHUD dismissWithDelay:2.0f];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalSetFailure];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNSettingTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH,YF(self.btnsView)-kUINavHeight);
        YNSettingTableView *tableView = [[YNSettingTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectIsPushOnBlock:^(BOOL isPushOn) {
            if ([DEFAULTS valueForKey:kUserLoginInfors]) {
                self.isPushOn = isPushOn;
                [self startNetWorkingRequestWithSetPushMsg];
            }
        }];
        [tableView setDidSelectSettingCellBlock:^(NSInteger index) {
            if (index == 1) {
                if ([DEFAULTS valueForKey:kUserLoginInfors]) {
                    YNSendSuggestViewController *pushVC = [[YNSendSuggestViewController alloc] init];
                    [self.navigationController pushViewController:pushVC animated:NO];
                }else{
                    [self tipsUserNotLogin];
                }
            }else if (index == 2){
                YNDocumentExplainViewController *pushVC = [[YNDocumentExplainViewController alloc] init];
                pushVC.status = 1;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if (index == 3){
                YNChatServiceViewController *chatService = [[YNChatServiceViewController alloc] init];
                chatService.conversationType = ConversationType_CUSTOMERSERVICE;
                chatService.targetId = RCIM_SERVICE_ID;
                chatService.title = LocalContactSerVice;
                [self.navigationController pushViewController:chatService animated:NO];
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
            [DEFAULTS setObject:nil forKey:kUserLoginInfors];
            [DEFAULTS synchronize];
            UINavigationController *nVc = [[UINavigationController alloc] initWithRootViewController:[[YNLoginViewController alloc] init]];
            AppDelegate *appDelegate =
            (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.window.rootViewController = nVc;
        }];
    }
    return _btnsView;
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
    self.btnsView.btnTitles = @[LocalExit];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalSettings;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
}
/** 重写，状态栏字体颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
