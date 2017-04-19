//
//  YNSelectAreaViewController.m
//  AgentSsales
//
//  Created by innofive on 17/4/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSelectAreaViewController.h"
#import "YNSelectAreaTableView.h"


@interface YNSelectAreaViewController ()
@property (nonatomic,weak) YNSelectAreaTableView * tableView;
@end

@implementation YNSelectAreaViewController

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

#pragma mark - 视图加载
-(YNSelectAreaTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        YNSelectAreaTableView *tableView = [[YNSelectAreaTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAddressName:^(NSString *address,NSString *countryid, NSString *shenid, NSString *shiid, NSString *quid) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddressName" object:nil userInfo:@{@"address":address,@"countryid":countryid,@"provinceid":shenid,@"cityid":shiid,@"areaid":quid}];
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }
    return _tableView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.tableView.dataArray = self.dataArray;
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"选择地区";
}

-(void)makeUI{
    [super makeUI];
}

#pragma mark - 数据懒加载

#pragma mark - 其他


@end
