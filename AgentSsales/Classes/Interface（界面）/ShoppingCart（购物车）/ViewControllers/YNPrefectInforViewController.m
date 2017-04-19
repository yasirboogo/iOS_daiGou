//
//  YNPrefectInforViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPrefectInforViewController.h"
#import "YNPrefectInforTableView.h"
#import "YNShoppingCartViewController.h"
#import "YNAreaSelectView.h"
#import "YNFirmOrderViewController.h"
#import "YNSelectAreaViewController.h"

@interface YNPrefectInforViewController ()
{
    NSInteger _type;
}
@property(nonatomic,strong)YNPrefectInforTableView *tableView;

@property(nonatomic,strong)NSDictionary *address;
//@property(nonatomic,strong)YNAreaSelectView *areaSelectView;

@property (nonatomic,weak) UIButton *submitBtn;

@property (nonatomic,strong) NSArray * dataArray;

@end

@implementation YNPrefectInforViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddressName:) name:@"AddressName" object:nil];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        [self startNetWorkingRequestWithGetProvincesWithisPush:NO];
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetProvincesWithisPush:(BOOL)isPush{
    if (isPush) {
        [SVProgressHUD showWithStatus:LocalLoading];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"0",@"code",
                                   [NSNumber numberWithInteger:_type],@"type", nil];
    [YNHttpManagers getProvincesWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD dismiss];
            self.dataArray = response[@"countryArray"];
            if (isPush) {
                YNSelectAreaViewController *pushVC = [[YNSelectAreaViewController alloc] init];
                pushVC.dataArray = _dataArray;
                [self.navigationController pushViewController:pushVC animated:NO];
            }
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalSaveFailure];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}

-(void)startNetWorkingRequestWithPrefectUserInfor{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [DEFAULTS valueForKey:kUserLoginInfors][@"userId"],@"userId",
                                   _tableView.name,@"username",
                                   _tableView.phone,@"phone",
                                   _tableView.details,@"detailed",
                                   _tableView.emial,@"emial",
                                   _address[@"countryid"],@"country",
                                   _address[@"provinceid"],@"province",
                                   _address[@"cityid"],@"city",
                                   _address[@"areaid"],@"area", nil];

    if (_tableView.numberID.length) {
        [params setValue:_tableView.numberID forKey:@"idCard"];
    }
    [YNHttpManagers prefectUserInforWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            YNFirmOrderViewController *pushCV = [[YNFirmOrderViewController alloc] init];
            pushCV.status = _index+1;
            pushCV.shoppingId = _shoppingId;
            pushCV.goodsId = _goodsId;
            pushCV.count = _count;
            [self.navigationController pushViewController:pushCV animated:NO];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
/*
-(YNAreaSelectView *)areaSelectView{
    if (!_areaSelectView) {
        CGRect frame = CGRectMake(0,(SCREEN_HEIGHT-W_RATIO(100)*9)/2.0, SCREEN_WIDTH, W_RATIO(100)*9);
        YNAreaSelectView *areaSelectView = [[YNAreaSelectView alloc] initWithFrame:frame];
        _areaSelectView = areaSelectView;
        [areaSelectView setDidSelectAreaSelectResultBlock:^(NSString *area) {
            self.tableView.locality = area;
        }];
    }
    return _areaSelectView;
}
 */
-(YNPrefectInforTableView *)tableView{
    if (!_tableView) {
        YNPrefectInforTableView *tableView = [[YNPrefectInforTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAddressCellBlock:^{
            YNSelectAreaViewController *pushVC = [[YNSelectAreaViewController alloc] init];
            pushVC.dataArray = self.dataArray;
            [self.navigationController pushViewController:pushVC animated:NO];
        }];
    }
    return _tableView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:LocalSave forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handlePrefectInforSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)handleAddressName:(NSNotification*)notification{
    self.address = notification.userInfo;

    _tableView.locality = _address[@"address"];
}
-(void)handlePrefectInforSubmitButtonClick:(UIButton*)btn{
    [self startNetWorkingRequestWithPrefectUserInfor];
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalPerfectInfor;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
