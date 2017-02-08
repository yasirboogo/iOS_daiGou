//
//  YNShowMoreClassViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/28.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNShowMoreClassViewController.h"
#import "YNMoreClassViewController.h"
#import "YNShowAllGoodsClassView.h"


@interface YNShowMoreClassViewController ()<TYPagerControllerDataSource>

@property (nonatomic, weak) UIView *tipsView;

@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@property (nonatomic, weak) UIButton *showBtn;

@property (nonatomic, strong) YNShowAllGoodsClassView *showAllGoodsClassView;

@end

@interface YNShowMoreClassViewController ()


@end

@implementation YNShowMoreClassViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.titleLabel.text = NSLocalizedString(@"分类",@"");
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
-(TYTabButtonPagerController *)pagerController{
    if (!_pagerController) {
        TYTabButtonPagerController *pagerController = [[TYTabButtonPagerController alloc] init];
        _pagerController = pagerController;
        pagerController.dataSource = self;
        pagerController.normalTextColor = COLOR_2B363C;
        pagerController.selectedTextColor = COLOR_DF463E;
        pagerController.normalTextFont = FONT(30);
        pagerController.selectedTextFont = FONT(36);
        pagerController.contentTopEdging = W_RATIO(90);
        pagerController.contentRightEdging = WIDTHF(self.showBtn)+W_RATIO(2);
        pagerController.barStyle = TYPagerBarStyleProgressBounceView;
        pagerController.pagerBarColor = COLOR_EDEDED;
        pagerController.collectionViewBarColor = COLOR_FFFFFF;
        pagerController.view.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight);
        [self addChildViewController:pagerController];
        [self.view addSubview:pagerController.view];
        
    }
    return _pagerController;
}
-(UIView *)tipsView{
    if (!_tipsView) {
        UIView *tipsView = [[UIView alloc] init];
        _tipsView = tipsView;
        [self.view addSubview:tipsView];
        tipsView.hidden = YES;
        tipsView.backgroundColor = COLOR_FFFFFF;
        tipsView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH-WIDTHF(_showBtn)-W_RATIO(2), HEIGHTF(_showBtn));
        
        UILabel * tipsLabel = [[UILabel alloc] init];
        [tipsView addSubview:tipsLabel];
        tipsLabel.frame = CGRectMake(kMidSpace, 0, WIDTHF(tipsView)-2*kMidSpace, HEIGHTF(tipsView));
        tipsLabel.text = @"所有分类";
        tipsLabel.font = FONT(28);
        tipsLabel.textColor = COLOR_666666;
    }
    return _tipsView;
}
-(UIButton *)showBtn{
    if (!_showBtn) {
        UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn = showBtn;
        [self.pagerController.view addSubview:showBtn];
        showBtn.backgroundColor = COLOR_FFFFFF;
        [showBtn setImage:[UIImage imageNamed:@"mianbaoxie_kui_xia"] forState:UIControlStateNormal];
        [showBtn setImage:[UIImage imageNamed:@"mianbaoxie_kui_shang"] forState:UIControlStateSelected];
        [showBtn addTarget:self action:@selector(handleShowButton:) forControlEvents:UIControlEventTouchUpInside];
        showBtn.frame = CGRectMake(SCREEN_WIDTH-W_RATIO(86), 0, W_RATIO(86), W_RATIO(90));
    }
    return _showBtn;
}
-(YNShowAllGoodsClassView *)showAllGoodsClassView{
    if (!_showAllGoodsClassView) {
        CGRect frame = CGRectMake(0,kUINavHeight+HEIGHTF(_showBtn)+W_RATIO(2), SCREEN_WIDTH,SCREEN_HEIGHT-MaxYF(_showBtn)-W_RATIO(2));
        YNShowAllGoodsClassView *showAllGoodsClassView = [[YNShowAllGoodsClassView alloc] initWithFrame:frame];
        _showAllGoodsClassView = showAllGoodsClassView;
        [self.view addSubview:showAllGoodsClassView];
        showAllGoodsClassView.hidden = YES;
    }
    return _showAllGoodsClassView;
}
#pragma mark - 代理实现
#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController
{
    NSArray * titles = @[@"为你推荐",@"女装",@"财经频道",@"时尚新天地",@"本地",@"儿童",@"政治新闻",@"娱乐",@"财经频道",@"时尚新天地",@"本地",@"儿童",@"政治新闻",@"娱乐",@"财经频道",@"时尚新天地",@"本地",@"儿童"];
    return titles.count;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    NSArray * titles = @[@"政治新闻",@"娱乐",@"财经频道",@"时尚新天地",@"本地",@"儿童",@"政治新闻",@"娱乐",@"财经频道",@"时尚新天地",@"本地",@"儿童",@"政治新闻",@"娱乐",@"财经频道",@"时尚新天地",@"本地",@"儿童"];
    return titles[index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    YNMoreClassViewController *listVC = [[YNMoreClassViewController alloc] init];
    return listVC;
}

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    [self.pagerController reloadData];
    self.showAllGoodsClassView.dataArray = @[@"为你推荐",@"女装",@"财经频道",@"时尚新天地",@"本地",@"儿童",@"政治新闻",@"娱乐",@"财经频道",@"时尚新天地",@"本地",@"儿童",@"政治新闻",@"娱乐",@"财经频道",@"时尚新天地",@"本地",@"儿童"];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
}
-(void)makeUI{
    [super makeUI];
}
-(void)handleShowButton:(UIButton*)btn{
    self.showAllGoodsClassView.hidden  = btn.selected;
    self.tipsView.hidden = btn.selected;
    btn.selected = !btn.selected;
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
