//
//  YNLoginViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNLoginViewController.h"
#import "YNSelectLanguageView.h"
#import "YNTabBarController.h"
#import "YNLoginTableView.h"
#import "YNRegisterViewController.h"
#import "YNInputPhoneViewController.h"
#import "AppDelegate.h"

@interface YNLoginViewController ()

@property (nonatomic,weak) YNLoginTableView * tableView ;

@property (nonatomic,weak) UIButton *rememberBtn;

@property (nonatomic,weak) UIButton *forgetBtn;

@property (nonatomic,weak) UIButton *submitBtn;

@property (nonatomic,weak) UIButton *visitorBtn;

@property (nonatomic,strong) YNUserRegisterInforModel *userRegisterInforModel;

@property (nonatomic,weak) YNSelectLanguageView *selectLanguageView;

@end

@implementation YNLoginViewController


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
-(void)startNetWorkingRequestWithLoginButtonClick{
    NSDictionary *params = @{@"loginphone":_tableView.loginphone,
                             @"password":_tableView.password};
    [YNHttpManagers userLoginInforWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKeychainService];
            if (keychain.allKeys) {
                [keychain removeItemForKey:keychain.allKeys.firstObject];
            }
            if (_rememberBtn.selected) {
                [keychain setString:_tableView.password forKey:_tableView.loginphone];
            }else{
                [keychain setString:@"" forKey:_tableView.loginphone];
            }
            [DEFAULTS setObject:(NSDictionary*)response forKey:kUserLoginInfors];
            [DEFAULTS synchronize];

            if (TARGET_IPHONE_SIMULATOR) {//模拟器不需要设置推送
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = [[YNTabBarController alloc]init];
            }else{
                [self startNetWorkingRequestPushToUserWithParams];
            }
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalUserNameIsError];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestPushToUserWithParams{
    NSDictionary *params = @{@"ispush":[JPUSHService registrationID],
                             @"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"]};
    [YNHttpManagers pushToUserWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[YNTabBarController alloc]init];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNSelectLanguageView *)selectLanguageView{
    if (!_selectLanguageView) {
        CGRect frame = CGRectMake(kMinSpace, kUINavHeight,W_RATIO(250),W_RATIO(270));
        YNSelectLanguageView *selectLanguageView = [[YNSelectLanguageView alloc] initWithFrame:frame];
        _selectLanguageView = selectLanguageView;
        selectLanguageView.hidden = YES;
        selectLanguageView.index = [LanguageManager currentLanguageIndex];
        [selectLanguageView setDidSelectLanguageCellBlock:^(NSInteger index) {
            _selectLanguageView.hidden = YES;
            [SVProgressHUD showWithStatus:LocalLanguageSeting];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                [kLanguageManager setUserlanguage:index type:1];
            }];
        }];
    }
    return _selectLanguageView;
}
-(YNLoginTableView *)tableView{
    if (!_tableView) {
        YNLoginTableView *tableView = [[YNLoginTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKeychainService];
        if (keychain.allKeys) {
            tableView.loginphone = keychain.allKeys.firstObject;
            tableView.password = [keychain stringForKey:tableView.loginphone];
        }
    }
    return _tableView;
}
-(UIButton *)rememberBtn{
    if (!_rememberBtn) {
        UIButton *rememberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rememberBtn = rememberBtn;
        [self.view addSubview:rememberBtn];
        rememberBtn.titleLabel.font = FONT(26);
        [rememberBtn setTitle:LocalRememberPwd forState:UIControlStateNormal];
        rememberBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -W_RATIO(20), 0, 0);
        [rememberBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        [rememberBtn setImage:[UIImage imageNamed:@"denglu_kuang"] forState:UIControlStateNormal];
        [rememberBtn setImage:[UIImage imageNamed:@"denglu_kuang_hover"] forState:UIControlStateSelected];
        [rememberBtn addTarget:self action:@selector(handleRememberButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize forgetBtnSize = [rememberBtn.titleLabel.text calculateHightWithFont:rememberBtn.titleLabel.font maxWidth:0];
        rememberBtn.frame = CGRectMake(W_RATIO(20) ,MaxYF(_tableView)+kMinSpace,forgetBtnSize.width+kMidSpace*2, W_RATIO(80));
        UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:kKeychainService];
        rememberBtn.selected = keychain.allKeys && [keychain stringForKey:keychain.allKeys.firstObject].length;
    }
    return _rememberBtn;
}
-(UIButton *)forgetBtn{
    if (!_forgetBtn) {
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetBtn = forgetBtn;
        [self.view addSubview:forgetBtn];
        forgetBtn.titleLabel.font = FONT(26);
        [forgetBtn setTitle:LocalFogetPwd forState:UIControlStateNormal];
        forgetBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -W_RATIO(20), 0, 0);
        [forgetBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        [forgetBtn setImage:[UIImage imageNamed:@"wenhao_hong"] forState:UIControlStateNormal];
        [forgetBtn addTarget:self action:@selector(handleForgetPwdButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize forgetBtnSize = [forgetBtn.titleLabel.text calculateHightWithFont:forgetBtn.titleLabel.font maxWidth:0];
        forgetBtn.frame = CGRectMake(SCREEN_WIDTH-(forgetBtnSize.width+kMidSpace*2) ,MaxYF(_tableView)+kMinSpace,forgetBtnSize.width+kMidSpace*2, W_RATIO(80));
    }
    return _forgetBtn;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(W_RATIO(20) ,MaxYF(_tableView)+W_RATIO(122), W_RATIO(710), W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = kViewRadius;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:LocalLogin forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleLoginSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
-(UIButton *)visitorBtn{
    if (!_visitorBtn) {
        UIButton *visitorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _visitorBtn = visitorBtn;
        [self.view addSubview:visitorBtn];
        visitorBtn.titleLabel.font = FONT(26);
        [visitorBtn setTitle:LocalVisterIn forState:UIControlStateNormal];
        [visitorBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        [visitorBtn addTarget:self action:@selector(handleVisitorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize visitorBtnSize = [visitorBtn.titleLabel.text calculateHightWithFont:visitorBtn.titleLabel.font maxWidth:0];
        visitorBtn.frame = CGRectMake(SCREEN_WIDTH-(visitorBtnSize.width+W_RATIO(20)) ,MaxYF(_submitBtn)+kMinSpace,visitorBtnSize.width, W_RATIO(80));
    }
    return _visitorBtn;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.selectLanguageView.dataArray = @[LocalChinese,LocalMalay,LocalEnglish];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    self.backButton.hidden = YES;
    [self addNavigationBarBtnWithTitle:LocalLanguage selectTitle:LocalLanguage font:FONT_15 img:[UIImage imageNamed:@"xiala_shouye"] selectImg:[UIImage imageNamed:@"xiala_shouye"] imgWidth:W_RATIO(20) isOnRight:NO btnClickBlock:^(BOOL isShow) {
        weakSelf.selectLanguageView.hidden = NO;
        
    }];
    [self addNavigationBarBtnWithTitle:LocalRegister selectTitle:LocalRegister font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isShow) {
        YNRegisterViewController *pushVC = [[YNRegisterViewController alloc] init];
        [weakSelf.navigationController pushViewController:pushVC animated:NO];
    }];
    self.backButton.hidden = YES;
    self.titleLabel.text = LocalLogin;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.rememberBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.visitorBtn];
    [self.view addSubview:self.selectLanguageView];
}
-(void)handleRememberButtonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
}
-(void)handleForgetPwdButtonClick:(UIButton*)btn{
    YNInputPhoneViewController *pushVC = [[YNInputPhoneViewController alloc] init];
    [self.navigationController pushViewController:pushVC animated:NO];
}
-(void)handleLoginSubmitButtonClick:(UIButton*)btn{
    if (_tableView.loginphone.length && _tableView.password.length) {
        [self startNetWorkingRequestWithLoginButtonClick];
    }else{
        [SVProgressHUD showImage:nil status:LocalInputIsEmpty];
        [SVProgressHUD dismissWithDelay:2.0f];
    }
}
-(void)handleVisitorButtonClick:(UIButton*)btn{
    [DEFAULTS setObject:nil forKey:kUserLoginInfors];
    [DEFAULTS synchronize];
    YNTabBarController *tab = [[YNTabBarController alloc] init];
    AppDelegate *appDelegate =
    (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = tab;
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
