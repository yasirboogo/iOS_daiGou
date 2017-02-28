//
//  YNNewsDetailViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewsDetailViewController.h"
#import "YNNewsDetailHeaderView.h"
#import "YNNewsCommentTableView.h"
#import "YNNewsCommentSendView.h"

@interface YNNewsDetailViewController ()
{
    NSInteger _type;
}
@property (nonatomic,weak) YNNewsDetailHeaderView * headerView;

@property (nonatomic,weak) YNNewsCommentTableView * tableView;

@property (nonatomic,weak) YNNewsCommentSendView * sendView;

@end

@implementation YNNewsDetailViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithGetCommentNewsList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithOneNewsDetail{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"messageId":_messageId,
                             @"type":[NSNumber numberWithInteger:_type]
                             };
    [YNHttpManagers getOneNewsDetailWithParams:params success:^(id response) {
        self.headerView.dict = response;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithStartLikeNews{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"messageId":_messageId,
                             @"type":[NSNumber numberWithInteger:_type]
                             };
    [YNHttpManagers startLikeNewsWithParams:params success:^(id response) {
        [self startNetWorkingRequestWithGetCommentNewsList];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithGetCommentNewsList{
    NSDictionary *params = @{@"messageId":_messageId,
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize]
                             };
    [YNHttpManagers getCommentNewsListWithParams:params success:^(id response) {
        self.tableView.dataArray = response;
        [self startNetWorkingRequestWithOneNewsDetail];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithSaveUserCommentWithContent:(NSString*)content{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"infoId":_messageId,
                             @"content":content
                             };
    [YNHttpManagers saveUserCommentWithParams:params success:^(id response) {
        [self startNetWorkingRequestWithGetCommentNewsList];
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNNewsDetailHeaderView *)headerView{
    if (!_headerView) {
        YNNewsDetailHeaderView *headerView = [[YNNewsDetailHeaderView alloc] init];
        _headerView = headerView;
        _tableView.tableHeaderView = headerView;
        headerView.commentNum = [NSString stringWithFormat:@"%ld",self.tableView.dataArray.count];
        [headerView setHtmlDidLoadFinish:^{
            _tableView.tableHeaderView = _headerView;
        }];
        [headerView setDidSelectLikeButtonBlock:^(BOOL isLike) {
            if (!isLike) {
                [self startNetWorkingRequestWithStartLikeNews];
            }else{
                NSLog(@"已经点过了，不能再点了");
            }
        }];
    }
    return _headerView;
}
-(YNNewsCommentTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.sendView));
        YNNewsCommentTableView *tableView = [[YNNewsCommentTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}
-(YNNewsCommentSendView *)sendView{
    if (!_sendView) {
        CGRect frame = CGRectMake(0, SCREEN_HEIGHT-W_RATIO(90), SCREEN_WIDTH, W_RATIO(90));
        YNNewsCommentSendView *sendView = [[YNNewsCommentSendView alloc] initWithFrame:frame];
        _sendView = sendView;
        [self.view addSubview:sendView];
        [sendView setDidSelectSendButtonClickBlock:^(NSString *str) {
            [self startNetWorkingRequestWithSaveUserCommentWithContent:str];
        }];
    }
    return _sendView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];

}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"资讯详情";

}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
