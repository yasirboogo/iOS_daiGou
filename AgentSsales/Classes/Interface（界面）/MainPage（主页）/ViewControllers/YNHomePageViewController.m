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
    [self startNetWorkingRequestWithGetHotClass];
    [self startNetWorkingRequestWithGetSpecialPurchase];
    
    [self.view bringSubviewToFront:self.selectLanguageView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetAdvertise{
    NSDictionary *params = @{@"status":@1};
    [YNHttpManagers getAdvertiseWithParams:params success:^(id response) {
        self.collectionView.adArray = response[@"adArray"];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithGetHotClass{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type],
                             @"status":@1};
    [YNHttpManagers getHotClassWithParams:params success:^(id response) {
        self.collectionView.hotArray = response;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithGetSpecialPurchase{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type],
                             @"pageIndex":[NSNumber numberWithInteger:self.pageIndex],
                             @"pageSize":[NSNumber numberWithInteger:self.pageSize]};
    [YNHttpManagers getSpecialPurchaseWithParams:params success:^(id response) {
        self.collectionView.featureArray = response;
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNSelectLanguageView *)selectLanguageView{
    if (!_selectLanguageView) {
        CGRect frame = CGRectMake(kMinSpace, kUINavHeight,W_RATIO(220),W_RATIO(270));
        YNSelectLanguageView *selectLanguageView = [[YNSelectLanguageView alloc] initWithFrame:frame];
        _selectLanguageView = selectLanguageView;
        selectLanguageView.hidden = YES;
        selectLanguageView.index = [LanguageManager currentLanguageIndex];
        [selectLanguageView setDidSelectLanguageCellBlock:^(NSInteger index) {
            [kLanguageManager setUserlanguage:index type:0];
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
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];

    self.selectLanguageView.dataArray = @[@"中文",@"马来语",@"英语"];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    UIButton *leftLanguageBtn = [self addNavigationBarBtnWithTitle:kLocalizedString(@"language", @"语言") selectTitle:kLocalizedString(@"language", @"语言") font:FONT_15 img:[UIImage imageNamed:@"xiala_shouye"] selectImg:[UIImage imageNamed:@"xiala_shouye"] imgWidth:W_RATIO(20) isOnRight:NO btnClickBlock:^(BOOL isShow) {
        weakSelf.selectLanguageView.hidden = !isShow;
        
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
    searchBar.attributedPlaceholder = [[NSAttributedString alloc] initWithString:kLocalizedString(@"searchContent",@"请输入搜索内容")
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
