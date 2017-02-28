//
//  YNSendSuggestViewController.m
//  AgentSsales1
//
//  Created by innofive on 17/2/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSendSuggestViewController.h"

@interface YNSendSuggestViewController ()<UITextViewDelegate>

@property (nonatomic,strong) UIButton * submitBtn;

@property (nonatomic,strong) UITextView * textView;

@end

@implementation YNSendSuggestViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textView resignFirstResponder];
    
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithSendSuggest{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"content":_textView.text};
    [YNHttpManagers sendSuggestWithParams:params success:^(id response) {
        [self.navigationController popViewControllerAnimated:NO];
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(UITextView *)textView{
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] init];
        _textView = textView;
        [self.view addSubview:textView];
        textView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, W_RATIO(720));
        textView.font = FONT(30);
        textView.delegate = self;
        textView.textColor = COLOR_999999;
        textView.placeholder = @"有意见或建议都可以写一下哦~";
        textView.placeholderFont = textView.font;
    }
    return _textView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = @"意见反馈";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.submitBtn];
}

-(void)handleSubmitButtonClick:(UIButton*)btn{
    [self startNetWorkingRequestWithSendSuggest];
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
