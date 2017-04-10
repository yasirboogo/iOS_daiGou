//
//  BaseViewController.m
//  YiQiGanDianSha
//
//  Created by mac on 15/10/5.
//  Copyright (c) 2015年 CH. All rights reserved.
//

#import "YNBaseViewController.h"

@interface YNBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *leftButtons;

@property (nonatomic, strong) NSMutableArray *rightButtons;

@property (nonatomic, assign) CGFloat leftBtnFrame;

@property (nonatomic, assign) CGFloat rightBtnFrame;

@end

@implementation YNBaseViewController

#pragma mark -- 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = COLOR_EDEDED;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationController.navigationBarHidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
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
        CGFloat startX = MAX(self.leftBtnFrame, self.rightBtnFrame);
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(startX, kUIStatusBar, SCREEN_WIDTH - 2*startX, kUINavHeight-kUIStatusBar)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT_17;
        _titleLabel.textColor = COLOR_FFFFFF;
        [_navView addSubview:_titleLabel];
    }
    return _titleLabel;
}

#pragma mark -- 数据加载
-(NSMutableArray *)leftButtons{
    if (!_leftButtons) {
        _leftButtons = [NSMutableArray array];
    }
    return _leftButtons;
}
-(NSMutableArray *)rightButtons{
    if (!_rightButtons) {
        _rightButtons = [NSMutableArray array];
    }
    return _rightButtons;
}

#pragma mark -- 函数
-(void)makeNavigationBar{
    [self.view addSubview:self.navView];

    [self.navView addSubview:self.backButton];
    [self.navView addSubview:self.titleLabel];
}
-(void)makeUI{
    
}
-(void)makeData{
    self.pageIndex = 1;
    self.pageSize = 10;
    
}
#pragma mark -- 消息响应
-(UIButton*)addNavigationBarBtnWithImg:(UIImage *)img selectImg:(UIImage *)selectImg isOnRight:(BOOL)isOnRight btnClickBlock:(void (^)(BOOL))btnClickBlock{

    YNNavigationBarButton *button = [YNNavigationBarButton buttonWithType:UIButtonTypeCustom];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:selectImg forState:UIControlStateSelected];
    
    [button setNavigationBarButtonClickBlock:^(BOOL isSelect) {
        btnClickBlock(isSelect);
    }];
    
    [button addTarget:self action:@selector(handleNavigationBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:button];
    
    if (isOnRight == YES) {
        self.rightBtnFrame += kUINavBtnWidth+kUINavBtnHorSpace;
        button.frame = CGRectMake(SCREEN_WIDTH-self.rightBtnFrame, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
    }else if(isOnRight == NO){
        if (self.backButton.hidden == YES) {
            button.frame = CGRectMake(kUINavBtnHorSpace+self.leftBtnFrame, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
            self.leftBtnFrame += kUINavBtnWidth+kUINavBtnHorSpace;
        }else{
            self.leftBtnFrame += kUINavBtnWidth+kUINavBtnHorSpace;
            button.frame = CGRectMake(kUINavBtnHorSpace+self.leftBtnFrame, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
        }
    }
    return button;
}
-(UIButton *)addNavigationBarBtnWithTitle:(NSString *)title selectTitle:(NSString *)selectTitle font:(UIFont *)font isOnRight:(BOOL)isOnRight btnClickBlock:(void (^)(BOOL))btnClickBlock{
    
    YNNavigationBarButton *button = [YNNavigationBarButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected];
    button.titleLabel.font = font;
    
    [button setNavigationBarButtonClickBlock:^(BOOL isSelect) {
        btnClickBlock(isSelect);
    }];
    
    [button addTarget:self action:@selector(handleNavigationBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:button];
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    CGSize selectTitleSize = [selectTitle sizeWithAttributes:@{NSFontAttributeName:font}];
    
    CGFloat btnWidth = (titleSize.width > selectTitleSize.width ? titleSize.width :selectTitleSize.width)+kUINavBtnHorSpace*2;
    
    if (isOnRight == YES) {
        self.rightBtnFrame += btnWidth+kUINavBtnHorSpace;
        button.frame = CGRectMake(SCREEN_WIDTH-self.rightBtnFrame, kUIStatusBar+kUINavBtnVerSpace, btnWidth, kUINavBtnWidth);
    }else if(isOnRight == NO){
        if (self.backButton.hidden == YES) {
            button.frame = CGRectMake(kUINavBtnHorSpace+self.leftBtnFrame, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
            self.leftBtnFrame += btnWidth+kUINavBtnHorSpace;
        }else{
            self.leftBtnFrame += btnWidth+kUINavBtnHorSpace;
            button.frame = CGRectMake(kUINavBtnHorSpace+self.leftBtnFrame, kUIStatusBar+kUINavBtnVerSpace, kUINavBtnWidth, kUINavBtnWidth);
        }
    }
    return button;
}

-(UIButton *)addNavigationBarBtnWithTitle:(NSString *)title selectTitle:(NSString *)selectTitle font:(UIFont *)font img:(UIImage *)img selectImg:(UIImage *)selectImg imgWidth:(CGFloat)imgWidth isOnRight:(BOOL)isOnRight btnClickBlock:(void (^)(BOOL))btnClickBlock{
    
    YNNavigationBarButton *button = [YNNavigationBarButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:selectImg forState:UIControlStateSelected];
    button.titleLabel.font = font;
    
    [button setNavigationBarButtonClickBlock:^(BOOL isSelect) {
        btnClickBlock(isSelect);
    }];

    [button addTarget:self action:@selector(handleNavigationBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:button];
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    CGSize selectTitleSize = [selectTitle sizeWithAttributes:@{NSFontAttributeName:font}];
    
    CGFloat btnWidth = imgWidth + (titleSize.width > selectTitleSize.width ? titleSize.width :selectTitleSize.width) + kUINavBtnHorSpace;
    
    if (isOnRight == YES) {
        self.rightBtnFrame += btnWidth+kUINavBtnHorSpace;
        button.frame = CGRectMake(SCREEN_WIDTH-self.rightBtnFrame, kUIStatusBar+kUINavBtnVerSpace, btnWidth, kUINavBtnWidth);
    }else if(isOnRight == NO){
        if (self.backButton.hidden == YES) {
            button.frame = CGRectMake(kUINavBtnHorSpace+self.leftBtnFrame, kUIStatusBar+kUINavBtnVerSpace, btnWidth, kUINavBtnWidth);
            self.leftBtnFrame += btnWidth+kUINavBtnHorSpace;
        }else{
            self.leftBtnFrame += btnWidth+kUINavBtnHorSpace;
            button.frame = CGRectMake(kUINavBtnHorSpace+self.leftBtnFrame, kUIStatusBar+kUINavBtnVerSpace, btnWidth, kUINavBtnWidth);
        }
    }
    return button;
}

-(void)handleNavigationBarButtonClick:(YNNavigationBarButton*)btn{
    btn.selected = !btn.selected;
    if (btn.navigationBarButtonClickBlock) {
        btn.navigationBarButtonClickBlock(btn.selected);
    }
}
- (void)backMethod{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
@implementation YNNavigationBarButton


@end
