//
//  YNUpdateInforViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/29.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNUpdateInforViewController.h"
#import "YNUpdateInforTableView.h"
#import "YNUpdatePhoneViewController.h"
#import "YNUpdatePswordViewController.h"

@interface YNUpdateInforViewController ()

@property (nonatomic,weak) YNUpdateInforTableView * tableView;

@end

@implementation YNUpdateInforViewController

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
-(YNUpdateInforTableView *)tableView{
    if (!_tableView) {
        YNUpdateInforTableView *tableView = [[YNUpdateInforTableView alloc] init];
        _tableView = tableView;
        [tableView setDidSelectUpdateInforClickBlock:^(NSString *str) {
            if ([str isEqualToString:@"手机号码"]) {
                YNUpdatePhoneViewController *pushVC = [[YNUpdatePhoneViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([str isEqualToString:@"账户安全"]){
                YNUpdatePswordViewController *pushVC = [[YNUpdatePswordViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
        [self.view addSubview:tableView];
    }
    return _tableView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    [self addNavigationBarBtnWithTitle:@"保存" selectTitle:@"取消保存" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        NSLog(@"保存");
    }];
    self.titleLabel.text = @"个人资料修改";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
