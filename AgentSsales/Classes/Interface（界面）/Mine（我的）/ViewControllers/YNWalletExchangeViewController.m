//
//  YNWalletExchangeViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNWalletExchangeViewController.h"
#import "YNPaySuccessViewController.h"
#import "YNChangeMoneyTableView.h"
#import "YNWalletTableView.h"
#import "YNChangeMoneyView.h"
#import "YNDocumentExplainViewController.h"

@interface YNWalletExchangeViewController ()
{
    NSString *_rateId;
    NSString *_cId;
    NSString *_eId;
}
/** 持有/兑换货币 */
@property (nonatomic,weak) YNChangeMoneyTableView * changeMoneyTableView;
/** 汇率 */
@property (nonatomic,weak) YNWalletTableView * walletTableView;
/** 确认兑换按钮 */
@property (nonatomic,weak) UIButton * submitBtn;

@property (nonatomic,weak) YNChangeMoneyView * wayView;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) UITextField *textField;

@end

@implementation YNWalletExchangeViewController


#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkingRequestWithExchangeRate];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithExchangeRate{
    NSDictionary *params = @{@"type":@0
                             };
    [YNHttpManagers getExchangeRateWithParams:params success:^(id response) {
        self.walletTableView.dataArray = response;
        self.changeMoneyTableView.dataArray = response;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithStartExchange{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"rateId":_changeMoneyTableView.rateId,
                             @"cId":[NSNumber numberWithInteger:_changeMoneyTableView.type1+1],
                             @"eId":[NSNumber numberWithInteger:_changeMoneyTableView.type2+1],
                             @"money":_changeMoneyTableView.money1
                             };
    [YNHttpManagers startExchangeWithParams:params success:^(id response) {

        YNPaySuccessViewController *pushVC = [[YNPaySuccessViewController alloc] init];
        pushVC.titleStr = @"兑换成功";
        [self.navigationController pushViewController:pushVC animated:NO];
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 视图加载
-(YNChangeMoneyTableView *)changeMoneyTableView{
    if (!_changeMoneyTableView) {
        YNChangeMoneyTableView *changeMoneyTableView = [[YNChangeMoneyTableView alloc] init];
        _changeMoneyTableView = changeMoneyTableView;
        [self.view addSubview:changeMoneyTableView];
        changeMoneyTableView.allTypeMoneys = self.allTypeMoneys;
        changeMoneyTableView.type1 = 0;
        changeMoneyTableView.type2 = 0;
        changeMoneyTableView.money1 = @"0.00";
        changeMoneyTableView.money2 = @"0.00";
        [changeMoneyTableView setDidSelectMoneyTypeClickBlock:^(NSInteger index) {
            self.index = index;
            [self.wayView showPopView:YES];
        }];
        [changeMoneyTableView setDidSelectMoneyNumClickBlock:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入兑换金额" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            _textField = [alert textFieldAtIndex:0];
            _textField.keyboardType = UIKeyboardTypeDecimalPad;
            _textField.textAlignment = NSTextAlignmentCenter;
            _textField.placeholder = [NSString stringWithFormat:@"%.2f",[_changeMoneyTableView.money1 floatValue]];
            [alert show];
        }];
    }
    return _changeMoneyTableView;
}
-(YNWalletTableView *)walletTableView{
    if (!_walletTableView) {
        CGRect frame = CGRectMake(W_RATIO(20),MaxYF(_changeMoneyTableView), SCREEN_WIDTH-W_RATIO(20)*2, W_RATIO(100)*2+W_RATIO(84));
        YNWalletTableView *walletTableView = [[YNWalletTableView alloc] initWithFrame:frame];
        _walletTableView = walletTableView;
        [self.view addSubview:walletTableView];
        walletTableView.isHaveLine = NO;
        walletTableView.layer.masksToBounds = YES;
        walletTableView.layer.cornerRadius = W_RATIO(20);
        
    }
    return _walletTableView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:@"确认兑换" forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleConfirmSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
-(YNChangeMoneyView *)wayView{
    if (!_wayView) {
        YNChangeMoneyView *wayView = [[YNChangeMoneyView alloc] initWithRowHeight:W_RATIO(120) width:W_RATIO(660) showNumber:3];
        _wayView = wayView;
        wayView.dataArray = @[@{@"title":@"人民币",@"image":@"zhongguo_yuan"},
                              @{@"title":@"美元",@"image":@"meiguo_yuan"},
                              @{@"title":@"马来西亚币",@"image":@"malaixiya_yuan"}];
        
        [wayView setDidSelectChangeWayCellBlock:^(NSInteger index) {
            [_wayView dismissPopView:YES];

            if (_index == 0) {
                _changeMoneyTableView.type1 = index;
            }else if (_index == 1){
                _changeMoneyTableView.type2 = index;
            }
        }];
    }
    return _wayView;
}
#pragma mark - 代理实现
-(void)handleConfirmSubmitButtonClick:(UIButton*)btn{
    if (_changeMoneyTableView.type1 == _changeMoneyTableView.type2) {
        _changeMoneyTableView.didSelectMoneyTypeClickBlock(1);
    }else if ([_changeMoneyTableView.money1 floatValue] == 0.00){
        _changeMoneyTableView.didSelectMoneyNumClickBlock();
    }else{
        [self startNetWorkingRequestWithStartExchange];
    }
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"确定"]){
        _textField = [alertView textFieldAtIndex:0];//获得输入框
        if (_textField.text.length) {
            _changeMoneyTableView.money1 = [NSString stringWithFormat:@"%.2f",[_textField.text floatValue]];
        }
    }
}
#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    
    [self changeMoneyTableView];
    
    self.walletTableView.itemTitles = @[@"人民币(主)",@"买进",@"卖出"];
}

-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:@"兑换说明" selectTitle:@"兑换说明" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        YNDocumentExplainViewController *pushVC = [[YNDocumentExplainViewController alloc] init];
        pushVC.status = 3;
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];

    self.titleLabel.text = @"货币兑换";
}
-(void)makeUI{
    [super makeUI];

    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载
#pragma mark - 其他

@end
