//
//  YNChatServiceViewController.m
//  AgentSsales2
//
//  Created by innofive on 17/3/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNChatServiceViewController.h"

@interface YNChatServiceViewController ()

@end

@implementation YNChatServiceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = COLOR_EDEDED;

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enable = NO;
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    [self makeNavigationBar];
    [self makeUI];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
/** 重写，状态栏字体颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}
/** 调用，状态栏背景颜色 */
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
#pragma mark -- 视图加载
-(UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kUINavHeight)];
        _navView.backgroundColor = COLOR_DF463E;
        [self.view addSubview:_navView];
    }
    return _navView;
}
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(kUINavBtnHorSpace, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
        [_backButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MaxXF(self.backButton)+kUINavBtnHorSpace, kUIStatusBar, SCREEN_WIDTH-2*(MaxXF(_backButton)+kUINavBtnHorSpace), kUINavHeight-kUIStatusBar)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT_17;
        _titleLabel.textColor = COLOR_FFFFFF;
        [self.navView addSubview:_titleLabel];
    }
    return _titleLabel;
}
#pragma mark - 代理实现
#pragma mark - 函数、消息
- (void)backMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeData{
    
}
-(void)makeNavigationBar{
    self.titleLabel.text = LocalContactSerVice;
}
-(void)makeUI{
    [self.view addSubview:self.backButton];
}
#pragma mark - 数据懒加载

#pragma mark - 其他
@end
