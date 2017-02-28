//
//  YNSearchViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/28.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNSearchViewController.h"
#import "YNMoreGoodsCollectionView.h"
#import "YSearchHistoryView.h"

@interface YNSearchViewController ()<UITextFieldDelegate>
{
    NSInteger _type;
}

@property (nonatomic,copy) UITextField * searchTField;

@property (nonatomic,copy) YSearchHistoryView * searchHistoryView;

@property (nonatomic,weak) YNMoreGoodsCollectionView* collectionView;

@property (nonatomic,weak) YNShowEmptyView *emptyView;

@end

@implementation YNSearchViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:COLOR_DF463E];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:COLOR_CLEAR];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark - 网路请求
-(void)startNetWorkingRequestWithSearchGoods{
    NSDictionary *params = @{@"searchName":_searchTField.text,
                             @"type":[NSNumber numberWithInteger:_type],
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize]
                             };
    [YNHttpManagers searchGoodsWithParams:params success:^(id response) {
        self.collectionView.dataArray = response;
        self.collectionView.hidden = !self.collectionView.dataArray.count;
        self.emptyView.hidden = !self.collectionView.hidden;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithSaveSearchKeys{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"content":_searchTField.text
                             };
    [YNHttpManagers saveSearchKeysWithParams:params success:^(id response) {
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(UITextField *)searchTField{
    if (!_searchTField) {
        UITextField *searchTField = [[UITextField alloc] init];
        _searchTField = searchTField;
        [self.navView addSubview:searchTField];
        searchTField.delegate = self;
        searchTField.placeholder = kLocalizedString(@"searchContent",@"请输入搜索内容");
        searchTField.font = FONT(28);
        searchTField.textColor = COLOR_999999;
        searchTField.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _searchTField;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, kUINavHeight+W_RATIO(2), SCREEN_WIDTH, SCREEN_HEIGHT - kUINavHeight-W_RATIO(2));
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"zhaobudaoi_sousuo"];
        emptyView.tips = @"找不到搜索内容";
    }
    return _emptyView;
}
-(YNMoreGoodsCollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0,
                                  kUINavHeight,
                                  SCREEN_WIDTH,
                                  SCREEN_HEIGHT-kUINavHeight-kUITabBarH);
        YNMoreGoodsCollectionView *collectionView = [[YNMoreGoodsCollectionView alloc] initWithFrame:frame];
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
    }
    return _collectionView;
}
-(YSearchHistoryView *)searchHistoryView{
    if (!_searchHistoryView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        YSearchHistoryView *searchHistoryView = [[YSearchHistoryView alloc] initWithFrame:frame];
        _searchHistoryView = searchHistoryView;
        [self.view addSubview:searchHistoryView];
        searchHistoryView.hidden = YES;
        [searchHistoryView setDidSelectSearchHistoryCellBlock:^(NSString *searchHistory) {
            self.searchTField.text = searchHistory;
        }];
    }
    return _searchHistoryView;
}
#pragma mark - 代理实现
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.emptyView.hidden = YES;
    self.searchHistoryView.hidden = NO;
    self.collectionView.hidden = YES;
    return YES;
}
#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.navView.backgroundColor = COLOR_FFFFFF;
    __weak typeof(self) weakSelf = self;
    [self.backButton setImage:[UIImage imageNamed:@"fanhui_kui_fanhui"] forState:UIControlStateNormal];
    UIButton *searchBtn = [self addNavigationBarBtnWithTitle:@"搜索" selectTitle:@"搜索" font:FONT_14 isOnRight:YES btnClickBlock:^(BOOL isShow) {
        if (weakSelf.searchTField.text.length) {
            [weakSelf.view endEditing:YES];
            weakSelf.collectionView.hidden = NO;
            weakSelf.searchHistoryView.searchContent = weakSelf.searchTField.text;
            [weakSelf startNetWorkingRequestWithSearchGoods];
            [weakSelf startNetWorkingRequestWithSaveSearchKeys];
        }else{
            NSLog(@"输入为空");
        }
    }];
    searchBtn.backgroundColor = COLOR_DF463E;
    searchBtn.layer.masksToBounds = YES;
    
    searchBtn.layer.cornerRadius = kViewRadius;
    
    self.searchTField.frame = CGRectMake(MaxXF(self.backButton), YF(searchBtn), XF(searchBtn)-MaxXF(self.backButton)-kUINavBtnHorSpace, HEIGHTF(searchBtn));
    
    UIView *lineView = [[UIView alloc] init];
    [self.navView addSubview:lineView];
    lineView.backgroundColor = COLOR_DF463E;
    lineView.frame = CGRectMake(XF(_searchTField), MaxYF(_searchTField), WIDTHF(_searchTField), W_RATIO(2));
}
-(void)makeUI{
    [super makeUI];
    self.searchHistoryView.hidden = NO;
}
/** 调用，状态栏背景颜色 */
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark - 数据懒加载

#pragma mark - 其他

@end
