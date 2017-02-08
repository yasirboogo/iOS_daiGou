//
//  YNRegisterViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNRegisterViewController.h"
#import "YNRegisterTableView.h"

@interface YNRegisterViewController ()

@property (nonatomic,weak) YNRegisterTableView * tableView ;

@property (nonatomic,weak) UIButton *submitBtn;

@property (nonatomic,weak) UIButton *checkBtn;

@property (nonatomic,strong) YYLabel *procotolLabel;

@end

@implementation YNRegisterViewController


#pragma mark - 视图生命周期

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
-(YNRegisterTableView *)tableView{
    if (!_tableView) {
        YNRegisterTableView *tableView = [[YNRegisterTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(W_RATIO(20) ,MaxYF(_tableView)+kMaxSpace, W_RATIO(710), W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = kViewRadius;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:@"注册" forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleLoginSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
-(UIButton *)checkBtn{
    if (!_checkBtn) {
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkBtn = checkBtn;
        [self.view addSubview:checkBtn];
        [checkBtn setBackgroundImage:[UIImage imageNamed:@"gou_kui_gouwuche"] forState:UIControlStateNormal];
        [checkBtn setBackgroundImage:[UIImage imageNamed:@"gou_hong_gouwuche"] forState:UIControlStateSelected];
        [checkBtn addTarget:self action:@selector(handleCheckButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        checkBtn.frame = CGRectMake(W_RATIO(30),MaxYF(_submitBtn)+W_RATIO(20), kMidSpace, kMidSpace);
    }
    return _checkBtn;
}
-(YYLabel *)procotolLabel{
    if (!_procotolLabel) {
        NSString *str1 = @"I have read and agreed to";
        NSString *str2 = @" user agreement ";
        NSMutableAttributedString *attachText = [NSMutableAttributedString new];
        UIFont *font = FONT(32);
        NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:str1 attributes:@{NSForegroundColorAttributeName:COLOR_999999,NSFontAttributeName:font}];
        YYTextHighlight *highlight1 = [YYTextHighlight new];
        [attributedStr1 setTextHighlight:highlight1 range:attributedStr1.rangeOfAll];
        [attachText appendAttributedString:attributedStr1];
        highlight1.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            self.checkBtn.selected = !self.checkBtn.selected;
        };
        
        NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc] initWithString:str2 attributes:@{NSForegroundColorAttributeName:COLOR_DF463E,NSFontAttributeName:font}];
        YYTextHighlight *highlight2 = [YYTextHighlight new];
        [attributedStr2 setTextHighlight:highlight2 range:attributedStr2.rangeOfAll];
        [attachText appendAttributedString:attributedStr2];
        highlight2.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            NSLog(@"全部兑换");
        };
        YYLabel *procotolLabel = [[YYLabel alloc] init];
        _procotolLabel = procotolLabel;
        procotolLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        procotolLabel.userInteractionEnabled = YES;
        procotolLabel.numberOfLines = 0;
        procotolLabel.attributedText = attachText;

        NSString *text = [NSString stringWithFormat:@"%@%@",str1,str2];
        CGSize textSize = [text calculateHightWithWidth: SCREEN_WIDTH-MaxXF(self.checkBtn)-kMidSpace-kMinSpace font:font];
        procotolLabel.frame = CGRectMake(MaxXF(_checkBtn)+kMinSpace, YF(_checkBtn),textSize.width, textSize.height);
    }
    return _procotolLabel;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    [self addNavigationBarBtnWithTitle:@"登录" selectTitle:@"登录" font:FONT(30) isOnRight:YES btnClickBlock:^(BOOL isShow) {
        
    }];
    self.backButton.hidden = YES;
    self.titleLabel.text = @"注册";
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.checkBtn];
    [self.view addSubview:self.procotolLabel];
}
-(void)handleForgetPwdButtonClick:(UIButton*)btn{
    
}
-(void)handleLoginSubmitButtonClick:(UIButton*)btn{
    
}
-(void)handleCheckButtonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
