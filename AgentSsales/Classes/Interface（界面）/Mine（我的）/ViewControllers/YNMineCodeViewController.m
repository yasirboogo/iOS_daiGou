//
//  YNMineCodeViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/11.
//  Copyright © 2017年 英诺. All rights reserved.
//
#import <CoreImage/CoreImage.h>
#import "YNMineCodeViewController.h"
#import "YNShareThirdSelectView.h"
#import "YNCodeImgView.h"
#import "YNCodeImageOperation.h"
@interface YNMineCodeViewController ()

@property (nonatomic,weak) YNCodeImgView * codeImgView;

@property (nonatomic,weak) YNShareThirdSelectView * selectShareView;

@end

@implementation YNMineCodeViewController

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
-(YNCodeImgView *)codeImgView{
    if (!_codeImgView) {
        YNCodeImgView *codeImgView = [[YNCodeImgView alloc] init];
        _codeImgView = codeImgView;
        [self.view addSubview:codeImgView];
        [codeImgView setDidSelectShareCodeImgButtonBlock:^{
            [self.selectShareView showPopView:YES];
        }];
    }
    return _codeImgView;
}

-(YNShareThirdSelectView *)selectShareView{
    if (!_selectShareView) {
        CGRect frame = CGRectMake(0,SCREEN_HEIGHT- W_RATIO(450), SCREEN_WIDTH,  W_RATIO(450));
        YNShareThirdSelectView *selectShareView = [[YNShareThirdSelectView alloc] initWithFrame:frame];
        _selectShareView = selectShareView;
        [selectShareView setDidSelectShareThirdSelectBlick:^(NSInteger index) {
            [self thirdShareWithIndex:index];
        }];
    }
    return _selectShareView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.codeImgView.codeImg = [YNCodeImageOperation getCodeImageWithContent:@"111" width:W_RATIO(400)];
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"fenxiang_wode"] selectImg:[UIImage imageNamed:@"fenxiang_wode"] isOnRight:YES btnClickBlock:^(BOOL isShow) {
        [weakSelf.selectShareView showPopView:YES];
    }];
    
    self.titleLabel.text = kLocalizedString(@"myTwoCode",@"我的二维码");
}
-(void)makeUI{
    [super makeUI];
}
-(void)thirdShareWithIndex:(NSInteger)index{
    
}
@end
