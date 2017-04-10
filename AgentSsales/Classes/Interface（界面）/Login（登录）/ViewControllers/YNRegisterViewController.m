//
//  YNRegisterViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNRegisterViewController.h"
#import "YNRegisterTableView.h"
#import "YNPhoneAreaCodeView.h"
#import "YNInputPhoneViewController.h"
#import "YNLoginViewController.h"
#import "YNDocumentExplainViewController.h"

@interface YNRegisterViewController ()
{
    NSString *_checkCode;
    NSInteger _type;
}
@property (nonatomic,strong) YNPhoneAreaCodeView *areaCodeView;

@property (nonatomic,assign) NSInteger index;

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
-(void)startNetWorkingRequestWithGetCountryCode{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type]
                             };
    [YNHttpManagers getCountryCodeWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.areaCodeView.dataArray = response[@"countryArray"];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithPhoneCode{
    NSDictionary *params = @{@"loginphone":_tableView.loginphone,
                             @"type":[NSNumber numberWithInteger:_index+1]};
    [YNHttpManagers getMsgCodeWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            _checkCode = [NSString stringWithFormat:@"%@",response[@"yzm"]];
            DLog(@"phone = %@,yzm = %@",_tableView.loginphone,_checkCode);
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithSubmitButtonClick{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:_tableView.loginphone,@"loginphone",_tableView.password,@"password",_areaCodeView.dataArray[_index],@"country", nil];
    if (self.parentId != nil) {
        [params setValue:_parentId forKey:@"parentId"];
    }
    [YNHttpManagers userRegisterInforWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKeychainService];
            if (keychain.allKeys) {
                [keychain removeItemForKey:keychain.allKeys.firstObject];
            }
            [keychain setString:@"" forKey:_tableView.loginphone];
            [DEFAULTS setObject:(NSDictionary*)response forKey:kUserLoginInfors];
            [DEFAULTS synchronize];
            [SVProgressHUD showImage:nil status:LocalRegisterSuccess];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                YNLoginViewController *pushVC = [[YNLoginViewController alloc] init];
                [self.navigationController pushViewController:pushVC animated:NO];
            }];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalRegisterFailure];
            [SVProgressHUD dismissWithDelay:2.0f ];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNPhoneAreaCodeView *)areaCodeView{
    if (!_areaCodeView) {
        YNPhoneAreaCodeView *areaCodeView = [[YNPhoneAreaCodeView alloc] init];
        _areaCodeView = areaCodeView;
        [areaCodeView setDidSelectCodeCellBlock:^(NSInteger index) {
            self.index = index;
            self.tableView.country = self.areaCodeView.dataArray[_index];
        }];
    }
    return _areaCodeView;
}
-(YNRegisterTableView *)tableView{
    if (!_tableView) {
        YNRegisterTableView *tableView = [[YNRegisterTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAreaCellBlock:^{
            [self startNetWorkingRequestWithGetCountryCode];
        }];
        [tableView setDidSelectSendPhoneCodeBlock:^{
            
            [self startNetWorkingRequestWithPhoneCode];
        }];
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
        [submitBtn setTitle:LocalRegister forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleRegisterSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
        checkBtn.selected = YES;
        [checkBtn addTarget:self action:@selector(handleCheckButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        checkBtn.frame = CGRectMake(W_RATIO(30),MaxYF(_submitBtn)+W_RATIO(20), kMidSpace, kMidSpace);
    }
    return _checkBtn;
}
-(YYLabel *)procotolLabel{
    if (!_procotolLabel) {
        NSString *str1 = LocalReadOK;
        NSString *str2 = [NSString stringWithFormat:@"《%@》",LocalAgreement];
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
            YNDocumentExplainViewController *pushVC = [[YNDocumentExplainViewController alloc] init];
            pushVC.status = 5;
            [self.navigationController pushViewController:pushVC animated:NO];
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
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:LocalLogin selectTitle:LocalLogin font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isShow) {
        YNLoginViewController *pushVC = [[YNLoginViewController alloc] init];
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
    self.backButton.hidden = YES;
    self.titleLabel.text = LocalRegister;
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
-(void)handleRegisterSubmitButtonClick:(UIButton*)btn{
    [self.view endEditing:YES];
    BOOL isEmpty = !_tableView.country.length||!_tableView.loginphone.length||!_tableView.checkCode.length||!_tableView.password.length;
    BOOL isCheckCode = [_tableView.checkCode isEqualToString:_checkCode];
    if (isEmpty) {
        [SVProgressHUD showImage:nil status:LocalInputIsEmpty];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else if (!isCheckCode) {
        [SVProgressHUD showImage:nil status:LocalCCodeError];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else{
        [self startNetWorkingRequestWithSubmitButtonClick];
    }
}
-(void)handleCheckButtonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _submitBtn.enabled = YES;
        _submitBtn.backgroundColor = COLOR_DF463E;
    }else{
        _submitBtn.enabled = NO;
        _submitBtn.backgroundColor = COLOR_999999;
    }
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
