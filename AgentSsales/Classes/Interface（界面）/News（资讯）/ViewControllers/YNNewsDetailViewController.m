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
#import "YNLoginViewController.h"

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enable = NO;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //监听键盘的通知
    [self observeKeyboardStatus];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([DEFAULTS valueForKey:kUserLoginInfors]) {
        [self startNetWorkingRequestWithGetCommentNewsList];
    }else{
        [self tipsUserNotLogin];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
    
    [IQKeyboardManager sharedManager].enable = YES;
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
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.headerView.dict = response;
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithStartLikeNews{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"messageId":_messageId,
                             @"type":[NSNumber numberWithInteger:_type]
                             };
    [YNHttpManagers startLikeNewsWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showSuccessWithStatus:LocalLikeSuccess];
            [SVProgressHUD dismissWithDelay:0.5f completion:^{
                [self startNetWorkingRequestWithGetCommentNewsList];
            }];
        }else{
            //do failure things
            [SVProgressHUD showSuccessWithStatus:LocalLikeFailure];
            [SVProgressHUD dismissWithDelay:2.0f ];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithGetCommentNewsList{
    NSDictionary *params = @{@"messageId":_messageId,
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize],
                             @"type":[NSNumber numberWithInteger:_type]
                             };
    [YNHttpManagers getCommentNewsListWithParams:params success:^(id response) {
        [self handleEndMJRefresh];
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.headerView.commentNum = [NSString stringWithFormat:@"%@",response[@"count"]];
            [self handleMJRefreshComplateWithResponse:response[@"comArray"]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
    }];
}
-(void)startNetWorkingRequestWithSaveUserCommentWithContent:(NSString*)content{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"infoId":_messageId,
                             @"content":[content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                             };
    [YNHttpManagers saveUserCommentWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showImage:nil status:LocalCommentSuccess];
            [SVProgressHUD dismissWithDelay:1.0f completion:^{
                [self startNetWorkingRequestWithGetCommentNewsList];
            }];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalCommentFailure];
            [SVProgressHUD dismissWithDelay:1.0f completion:^{
                [self startNetWorkingRequestWithGetCommentNewsList];
            }];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNNewsDetailHeaderView *)headerView{
    if (!_headerView) {
        YNNewsDetailHeaderView *headerView = [[YNNewsDetailHeaderView alloc] init];
        _headerView = headerView;
        _tableView.tableHeaderView = headerView;
        //headerView.commentNum = [NSString stringWithFormat:@"%ld",self.tableView.dataArrayM.count];
        [headerView setHtmlDidLoadFinish:^{
            _tableView.tableHeaderView = _headerView;
        }];
        [headerView setDidSelectLikeButtonBlock:^(BOOL isLike) {
            if (!isLike) {
                [self startNetWorkingRequestWithStartLikeNews];
            }else{
                [SVProgressHUD showErrorWithStatus:@"你已经点过赞了"];
                [SVProgressHUD dismissWithDelay:1.0f];
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
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageIndex = 1;
            [tableView.mj_footer endRefreshing];
            [self startNetWorkingRequestWithGetCommentNewsList];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            [tableView.mj_header endRefreshing];
            [self startNetWorkingRequestWithGetCommentNewsList];
        }];
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
-(void)handleMJRefreshComplateWithResponse:(NSArray*)response{
    
    NSMutableArray *tempArrayM = [YNNewsCommentCellFrame initWithFromDictionaries:response];
    
    if (self.pageIndex == 1) {
        _tableView.dataArrayM = [NSMutableArray arrayWithArray:tempArrayM];
        [self startNetWorkingRequestWithOneNewsDetail];
    }else{
        [_tableView.dataArrayM addObjectsFromArray:tempArrayM];
    }
    [_tableView reloadData];
    if (response.count == 0) {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}
-(void)handleEndMJRefresh{
    if (self.pageIndex == 1) {
        [self.tableView.mj_header endRefreshing];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];

}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalNewsDetail;

}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载

#pragma mark - 其他
-(void)observeKeyboardStatus{
    // 键盘即将展开
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}// 监听键盘
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.sendView.frame = CGRectMake(0,SCREEN_HEIGHT-W_RATIO(90),SCREEN_WIDTH, W_RATIO(90));
        self.tableView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(90));
    }];
}
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 取出键盘高度
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardF.size.height;
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.sendView.frame = CGRectMake(0,SCREEN_HEIGHT-W_RATIO(90)-keyboardH,SCREEN_WIDTH,W_RATIO(90));
        self.tableView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(90)-keyboardH);
    }];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
