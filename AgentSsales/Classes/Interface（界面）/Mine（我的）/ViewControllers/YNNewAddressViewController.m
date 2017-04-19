//
//  YNNewAddressViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewAddressViewController.h"
#import "YNNewAddressTableView.h"
#import "YNAreaSelectView.h"

#import "YNSelectAreaViewController.h"

@interface YNNewAddressViewController ()
{
    NSInteger _type;
}

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,copy) NSString * addressId;

@property(nonatomic,strong)YNNewAddressTableView *tableView;

@property(nonatomic,strong)YNAreaSelectView *areaSelectView;


@end

@implementation YNNewAddressViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddressName:) name:@"AddressName" object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        [self startNetWorkingRequestWithGetProvincesWithisPush:NO];
    });
    
}
-(void)handleAddressName:(NSNotification*)notification{
    self.address = notification.userInfo;
    _tableView.area = self.address[@"address"];
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
-(void)startNetWorkingRequestWithSaveNewAddress{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _tableView.name,@"name",
                                   _tableView.phone,@"phone",
                                   _address[@"countryid"],@"country",
                                   _address[@"provinceid"],@"province",
                                   _address[@"cityid"],@"city",
                                   _address[@"areaid"],@"area",
                                   _tableView.details,@"detailed",
                                   _tableView.email,@"email", nil];
    if (_viewType == 0) {
        [params setValue:_addressId forKey:@"id"];
    }else if (_viewType == 1){
        [params setValue:[DEFAULTS valueForKey:kUserLoginInfors][@"userId"] forKey:@"userid"];
    }
    [YNHttpManagers saveNewAddressWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showImage:nil status:LocalSaveSuccess];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                [self.navigationController popViewControllerAnimated:NO];
            }];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalSaveFailure];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNNewAddressTableView *)tableView{
    if (!_tableView) {
        YNNewAddressTableView *tableView = [[YNNewAddressTableView alloc] init];
        _tableView  = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectAddressCellBlock:^{
            if (self.dataArray) {
                YNSelectAreaViewController *pushVC = [[YNSelectAreaViewController alloc] init];
                pushVC.dataArray = self.dataArray;
                [self.navigationController pushViewController:pushVC animated:NO];
            }else{
                [self startNetWorkingRequestWithGetProvincesWithisPush:YES];
            }
        }];
    }
    return _tableView;
}
-(YNAreaSelectView *)areaSelectView{
    if (!_areaSelectView) {
        CGRect frame = CGRectMake(0,(SCREEN_HEIGHT-W_RATIO(100)*9)/2.0, SCREEN_WIDTH, W_RATIO(100)*9);
        YNAreaSelectView *areaSelectView = [[YNAreaSelectView alloc] initWithFrame:frame];
        _areaSelectView = areaSelectView;
        [areaSelectView setDidSelectAreaSelectResultBlock:^(NSString *area) {
            self.tableView.area = area;
        }];
    }
    return _areaSelectView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
    if (self.address) {
        self.tableView.addressM = [self.address mutableCopy];
        self.addressId = self.address[@"addressId"];
    }
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    [self addNavigationBarBtnWithTitle:LocalSave selectTitle:LocalSave font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isShow) {
        BOOL isNotEmpty = _tableView.name.length
        && _tableView.phone.length
        && _tableView.locality.length
        && _tableView.details.length
        && _tableView.email.length;
        if (isNotEmpty) {
            [weakSelf startNetWorkingRequestWithSaveNewAddress];
        }else{
            [SVProgressHUD showImage:nil status:LocalInputIsEmpty];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    }];
    if (self.viewType == 0) {
        self.titleLabel.text = LocalChangeAddress;
    }else if (self.viewType == 1){
        self.titleLabel.text = LocalNewAddress;
    }
}

-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.tableView];
}
#pragma mark - 数据懒加载

#pragma mark - 其他


@end
