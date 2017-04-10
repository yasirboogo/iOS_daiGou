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
//@property (nonatomic,weak) YNWalletTableView * walletTableView;

@property (nonatomic,weak) YNChangeMoneyView * wayView;

//@property (nonatomic,assign) NSInteger index;

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
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.changeMoneyTableView.dataArray = response[@"parArray"];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
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
        changeMoneyTableView.money1 = @"0.00";
        [changeMoneyTableView setDidSelectMoneyTypeClickBlock:^() {
            [self.wayView showPopView:YES];
        }];
        [changeMoneyTableView setDidSelectMoneyNumClickBlock:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalInputMoney message:@"" delegate:self cancelButtonTitle:LocalCancel otherButtonTitles:LocalDone,nil];
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
-(YNChangeMoneyView *)wayView{
    if (!_wayView) {
        YNChangeMoneyView *wayView = [[YNChangeMoneyView alloc] initWithRowHeight:W_RATIO(120) width:W_RATIO(660) showNumber:3];
        _wayView = wayView;
        wayView.typeIndex = -1;
        wayView.dataArray = @[@{@"title":LocalChineseMoney,@"image":@"zhongguo_yuan"},
                              @{@"title":LocalMalayMoney,@"image":@"malaixiya_yuan"},
                              @{@"title":LocalAmericanMoney,@"image":@"meiguo_yuan"}];
        
        [wayView setDidSelectChangeWayCellBlock:^(NSInteger index) {
            [_wayView dismissPopView:YES];
            _changeMoneyTableView.type1 = index;
        }];
    }
    return _wayView;
}
#pragma mark - 代理实现
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:LocalDone]){
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
    
    //self.walletTableView.itemTitles = @[@"人民币(主)",@"买进",@"卖出"];
}

-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:LocalNote selectTitle:LocalNote font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        YNDocumentExplainViewController *pushVC = [[YNDocumentExplainViewController alloc] init];
        pushVC.status = 3;
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];

    self.titleLabel.text = LocalCurrencyExchange;
}
-(void)makeUI{
    [super makeUI];
}
#pragma mark - 数据懒加载
#pragma mark - 其他

@end
