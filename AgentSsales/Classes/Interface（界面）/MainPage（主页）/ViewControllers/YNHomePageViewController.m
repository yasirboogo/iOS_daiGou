//
//  HomePageViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#import "YNHomePageViewController.h"
#import "YNSelectLanguageView.h"
#import "YNHomePageCollectionView.h"
#import "YNYNCameraScanCodeViewController.h"
#import "YNShowMoreGoodsViewController.h"
#import "YNShowMoreClassViewController.h"
#import "YNAgentGoodsViewController.h"
#import "YNTerraceGoodsViewController.h"
#import "YNSearchViewController.h"
#import "YNWebViewController.h"

@interface YNHomePageViewController ()<UITextFieldDelegate>{
    NSInteger _type;
}
@property (nonatomic,weak) YNHomePageCollectionView* collectionView;

@property (nonatomic,weak) YNSelectLanguageView* selectLanguageView;

@end

@implementation YNHomePageViewController


#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLOR_EDEDED;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithGetAdvertise];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetAdvertise{
    NSDictionary *params = @{@"status":[NSNumber numberWithInteger:1]};
    [YNHttpManagers getAdvertiseWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.collectionView.adArray = response[@"adArray"];
            [self startNetWorkingRequestWithGetHotClass];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
    }];
}
-(void)startNetWorkingRequestWithExchangeRate{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:1]};
    [YNHttpManagers getExchangeRateWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.collectionView.rateArray = response[@"parArray"];
            [self startNetWorkingRequestWithGetSpecialPurchase];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
    }];
}
-(void)startNetWorkingRequestWithGetHotClass{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type],
                             @"status":[NSNumber numberWithInteger:1]};
    [YNHttpManagers getHotClassWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.collectionView.hotArray = response[@"imgArray"];
            [self startNetWorkingRequestWithExchangeRate];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
    }];
}
-(void)startNetWorkingRequestWithGetSpecialPurchase{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type],
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize]};
    [YNHttpManagers getSpecialPurchaseWithParams:params success:^(id response) {
        [self handleEndMJRefresh];
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [self handleMJRefreshComplateWithResponse:response[@"goodsArray"]];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
        [self handleEndMJRefresh];
    }];
}
#pragma mark - 视图加载
-(YNSelectLanguageView *)selectLanguageView{
    if (!_selectLanguageView) {
        CGRect frame = CGRectMake(kMinSpace, kUINavHeight,W_RATIO(250),W_RATIO(270));
        YNSelectLanguageView *selectLanguageView = [[YNSelectLanguageView alloc] initWithFrame:frame];
        _selectLanguageView = selectLanguageView;
        selectLanguageView.hidden = YES;
        selectLanguageView.index = [LanguageManager currentLanguageIndex];
        [selectLanguageView setDidSelectLanguageCellBlock:^(NSInteger index) {
            _selectLanguageView.hidden = YES;
            [SVProgressHUD showWithStatus:LocalLoading];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                [kLanguageManager setUserlanguage:index type:0];
            }];
        }];
    }
    return _selectLanguageView;
}
-(YNHomePageCollectionView *)collectionView{
    if (!_collectionView) {
        YNHomePageCollectionView *collectionView =[[YNHomePageCollectionView alloc] init];
        _collectionView = collectionView;
        [collectionView setDidSelectPlatImgClickBlock:^(NSInteger index) {
            YNAgentGoodsViewController *pushVC = [[YNAgentGoodsViewController alloc] init];
            NSArray *urlStrArr = @[@"https://www.taobao.com/",
                                   @"http://www.vip.com/",
                                   @"https://www.jd.com/"];
            pushVC.urlStr = urlStrArr[index];
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        [collectionView setDidSelectPlayerImgClickBlock:^(NSString *url,NSString *type) {
            if ([type integerValue] == 1) {
                YNTerraceGoodsViewController *pushVC = [[YNTerraceGoodsViewController alloc] init];
                pushVC.goodsId = url;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([type integerValue] == 2){
                YNWebViewController *pushVC = [[YNWebViewController alloc] init];
                pushVC.url = url;
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
        [collectionView setDidSelectHotClassImgClickBlock:^(NSString *classId,NSInteger index) {
            YNShowMoreClassViewController *pushVC = [[YNShowMoreClassViewController alloc] init];
            pushVC.classId = classId;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        [collectionView setDidSelectGoodImgClickBlock:^(NSString *goodsId) {
            YNTerraceGoodsViewController *pushVC = [[YNTerraceGoodsViewController alloc] init];
            pushVC.goodsId = goodsId;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
        [collectionView setDidSelectMoreBtnClickBlock:^(NSInteger index) {
            if (index == 3) {
                YNShowMoreClassViewController *pushVC = [[YNShowMoreClassViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if (index == 4){
                YNShowMoreGoodsViewController *pushVC = [[YNShowMoreGoodsViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
        
        collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageIndex = 1;
            [collectionView.mj_footer endRefreshing];
            [self startNetWorkingRequestWithGetAdvertise];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        collectionView.mj_header.automaticallyChangeAlpha = YES;
        collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex += 1;
            [collectionView.mj_header endRefreshing];
            [self startNetWorkingRequestWithGetSpecialPurchase];
        }];
    }
    return _collectionView;
}
#pragma mark - 代理实现
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    YNSearchViewController *pushVC = [[YNSearchViewController alloc] init];
    [self.navigationController pushViewController:pushVC animated:NO];
    return NO;
}
#pragma mark - 函数、消息
-(void)handleMJRefreshComplateWithResponse:(NSArray*)response{
    if (self.pageIndex == 1) {
        _collectionView.dataArrayM = [NSMutableArray arrayWithArray:response];
    }else{
        [_collectionView.dataArrayM addObjectsFromArray:response];
    }
    [_collectionView reloadData];
    if (response.count == 0) {
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}
-(void)handleEndMJRefresh{
    if (self.pageIndex == 1) {
        [self.collectionView.mj_header endRefreshing];
    }else{
        [self.collectionView.mj_footer endRefreshing];
    }
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];

    self.selectLanguageView.dataArray = @[LocalChinese,LocalMalay,LocalEnglish];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    UIButton *leftLanguageBtn = [self addNavigationBarBtnWithTitle:LocalLanguage selectTitle:LocalLanguage font:FONT_15 img:[UIImage imageNamed:@"xiala_shouye"] selectImg:[UIImage imageNamed:@"xiala_shouye"] imgWidth:W_RATIO(20) isOnRight:NO btnClickBlock:^(BOOL isShow) {
        weakSelf.selectLanguageView.hidden = NO;
        
    }];
    // 右边扫一扫按钮
    UIButton *rightScanBtn = [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"saoyisao_shouye"] selectImg:[UIImage imageNamed:@"saoyisao_shouye"] isOnRight:YES btnClickBlock:^(BOOL isShow) {
        YNYNCameraScanCodeViewController *scanVC = [[YNYNCameraScanCodeViewController alloc] init];
        [weakSelf presentViewController:scanVC animated:NO completion:nil];
    }];
     //搜索条
    UITextField *searchBar = [[UITextField alloc] init];
    [self.navView addSubview:searchBar];
    searchBar.frame = CGRectMake(MaxXF(leftLanguageBtn)+kUINavBtnHorSpace,
                                 MinYF(leftLanguageBtn),
                                 MinXF(rightScanBtn)- MaxXF(leftLanguageBtn)-kUINavBtnHorSpace*2,
                                 kUINavBtnWidth);
    searchBar.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LocalSearchContent
        attributes:@{NSFontAttributeName:FONT_11,
                     NSForegroundColorAttributeName:COLOR_999999}];
    searchBar.font = FONT_11;
    searchBar.delegate = self;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.layer.backgroundColor = COLOR_FFFFFF.CGColor;
    searchBar.layer.cornerRadius = kViewRadius;
    searchBar.layer.masksToBounds = YES;
    {
        // 搜索按钮按钮
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.frame = CGRectMake(0, 0, kUINavBtnWidth, kUINavBtnWidth);
        [searchBtn setImage:[UIImage imageNamed:@"sousuo_shouye"]
                   forState:UIControlStateNormal];
        searchBar.leftView = searchBtn;
        searchBar.leftViewMode = UITextFieldViewModeAlways;
    }

}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.selectLanguageView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
