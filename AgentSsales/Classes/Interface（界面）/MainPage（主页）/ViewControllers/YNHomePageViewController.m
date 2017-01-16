//
//  HomePageViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#import "YNHomePageViewController.h"
#import "PopoverView.h"
#import "YNHomePageCollectionView.h"
#import "YNYNCameraScanCodeViewController.h"
#import "YNShowMoreGoodsViewController.h"
#import "YNShowMoreClassViewController.h"

@interface YNHomePageViewController ()

@property (nonatomic,weak) YNHomePageCollectionView* collectionView;

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
    [self makeNavigationBar];
    [self makeUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求

#pragma mark - 视图加载
-(YNHomePageCollectionView *)collectionView{
    if (!_collectionView) {
        YNHomePageCollectionView *collectionView =[[YNHomePageCollectionView alloc] init];
        _collectionView = collectionView;

        [collectionView setDidSelectPlatImgClickBlock:^(NSString *str) {
            NSLog(@"%@",str);
        }];
        [collectionView setDidSelectPlayerImgClickBlock:^(NSString *str) {
            NSLog(@"%@",str);
        }];
        [collectionView setDidSelectHotClassImgClickBlock:^(NSString *str) {
            NSLog(@"%@",str);
        }];
        [collectionView setDidSelectGoodImgClickBlock:^(NSString *str) {
            NSLog(@"%@",str);
        }];
        [collectionView setDidSelectMoreBtnClickBlock:^(NSString *str) {
            if ([str isEqualToString:@"特色惠购"]) {
                YNBaseViewController *pushVC = [[YNShowMoreGoodsViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }else if ([str isEqualToString:@"热门分类"]){
                YNBaseViewController *pushVC = [[YNShowMoreClassViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }];
        [self.view addSubview:collectionView];
    }
    return _collectionView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeNavigationBar{
    [super makeNavigationBar];
    //左边选择语种按钮
    UIButton *leftLanguageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftLanguageBtn.frame = CGRectMake(kUINavBtnHorSpace,
                                       kUIStatusBar+kUINavBtnVerSpace,
                                       kUINavBtnWidth*2,
                                       kUINavBtnWidth);
    [leftLanguageBtn setTitle:@"语言" forState:UIControlStateNormal];
    leftLanguageBtn.titleLabel.font = FONT_14;
    [leftLanguageBtn setTitleColor:COLOR_FFFFFF
                          forState:UIControlStateNormal];
    [leftLanguageBtn setImage:[UIImage imageNamed:@"xiala_shouye"]
                     forState:UIControlStateNormal];
    leftLanguageBtn.tag = 0;
    [leftLanguageBtn addTarget:self
                        action:@selector(handleNavigationBarButtonsClick:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftLanguageBtn];
    
    // 右边扫一扫按钮
    UIButton *rightScanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightScanBtn.frame = CGRectMake(SCREEN_WIDTH-kUINavBtnHorSpace-kUINavBtnWidth,
                                    kUIStatusBar+kUINavBtnVerSpace,
                                    kUINavBtnWidth,
                                    kUINavBtnWidth);
    [rightScanBtn setImage:[UIImage imageNamed:@"saoyisao_shouye"]
                  forState:UIControlStateNormal];
    rightScanBtn.tag = 1;
    [rightScanBtn addTarget:self
                     action:@selector(handleNavigationBarButtonsClick:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightScanBtn];
    
    //搜索条
    UITextField *searchBar = [[UITextField alloc] init];
    searchBar.frame = CGRectMake(MaxXF(leftLanguageBtn)+kUINavBtnHorSpace,
                                 MinYF(leftLanguageBtn),
                                 MinXF(rightScanBtn)- MaxXF(leftLanguageBtn)-kUINavBtnHorSpace*2,
                                 kUINavBtnWidth);
    searchBar.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLS(@"searchContent",@"请输入搜索内容")
        attributes:@{NSFontAttributeName:FONT_11,
                     NSForegroundColorAttributeName:COLOR_999999}];
    searchBar.font = FONT_11;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.layer.backgroundColor = COLOR_FFFFFF.CGColor;
    searchBar.layer.cornerRadius = kViewRadius;
    
    // 搜索按钮按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, kUINavBtnWidth, kUINavBtnWidth);
    [searchBtn setImage:[UIImage imageNamed:@"sousuo_shouye"]
               forState:UIControlStateNormal];
    searchBar.leftView = searchBtn;
    searchBar.leftViewMode = UITextFieldViewModeAlways;

    searchBar.layer.masksToBounds = YES;
    [self.navView addSubview:searchBar];
    
}
-(void)handleNavigationBarButtonsClick:(UIButton*)btn{
    if (btn.tag == 0) {
        NSLog(@"切换语言");
        // 不带图片
        PopoverAction *action1 = [PopoverAction actionWithTitle:@"中文" handler:^(PopoverAction *action) {
        }];
        PopoverAction *action2 = [PopoverAction actionWithTitle:@"英语" handler:^(PopoverAction *action) {
        }];
        PopoverAction *action3 = [PopoverAction actionWithTitle:@"马来语" handler:^(PopoverAction *action) {
        }];
        
        PopoverView *popoverView = [PopoverView popoverView];
        popoverView.style = PopoverViewStyleDark;
        popoverView.hideAfterTouchOutside = YES; // 点击外部时不允许隐藏
        [popoverView showToView:btn withActions:@[action1, action2, action3]];
        
        
    }else if (btn.tag == 1){
        NSLog(@"扫一扫");
        YNYNCameraScanCodeViewController *scanVC = [[YNYNCameraScanCodeViewController alloc] init];
        [self presentViewController:scanVC animated:NO completion:nil];
        
    }
}
-(void)makeUI{
    [super makeUI];
    NSArray *dataArray = @[
  @{@"image":@"testGoods",@"name":@"米勒洗衣机",@"version":@"产品型号J-GRY4",@"price":@"500.14",@"mark":@"￥"},
  @{@"image":@"testGoods",@"name":@"米勒洗衣机",@"version":@"产品型号J-GRY4",@"price":@"500.14",@"mark":@"￥"}];

    self.collectionView.dataArray = dataArray;
}
#pragma mark - 数据懒加载

#pragma mark - 其他



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
