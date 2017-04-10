//
//  YNTerraceGoodsViewController.m
//  AgentSsales
//
//  Created by innofive on 17/2/4.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNTerraceGoodsViewController.h"
#import "YNGoodsDetailsView.h"
#import "YNGoodsDetailBtnsView.h"
#import "YNSelectParaView.h"
#import "YNShareThirdSelectView.h"
#import "YNShoppingCartViewController.h"
#import "YNTipsPerfectInforView.h"
#import "YNFirmOrderViewController.h"
#import "YNPrefectInforViewController.h"
#import "YNTabBarController.h"
#import "Appdelegate.h"
#import "YNLoginViewController.h"

@interface YNTerraceGoodsViewController ()
{
    NSInteger _type;
    UIButton *_collectBtn;
}
@property (nonatomic,strong) YNGoodsDetailsView * detailView;

@property (nonatomic,strong) YNGoodsDetailBtnsView * bottomBtnsView;

@property (nonatomic,strong) YNSelectParaView * selectParaView;

@property (nonatomic,strong) YNShareThirdSelectView * selectShareView;

@property (nonatomic,strong) YNTipsPerfectInforView * inforView;

@property (nonatomic,strong) NSString * style;

@property (nonatomic,strong) NSString * count;

@property (nonatomic, assign) NSInteger selectBuyType;

@end

@implementation YNTerraceGoodsViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([DEFAULTS valueForKey:kUserLoginInfors]) {
        [self startNetWorkingRequestWithGetGoodsDetails];
    }else{
        [self tipsUserNotLogin];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"closeVideo" object:nil]];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetGoodsDetails{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"goodsId":_goodsId,
                             @"type":[NSNumber numberWithInteger:_type]};
    [YNHttpManagers getGoodsDetailsWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.detailView.dataDict = response;
            self.bottomBtnsView.dict = response;
            _collectBtn.selected = [response[@"iscollection"] boolValue];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithCollectGoods{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"goodsId":_goodsId};
    [YNHttpManagers collectGoodsWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithSelectGoodsType{
    NSDictionary *params = @{@"type":[NSNumber numberWithInteger:_type],
                             @"goodsId":_goodsId};
    [YNHttpManagers selectGoodsTypeWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            self.selectParaView.dataArray = response[@"styArray"];
            [self.selectParaView showPopView:YES];
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithJoinToShoppingCart{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [DEFAULTS valueForKey:kUserLoginInfors][@"userId"],@"userId",
                                   _goodsId,@"goodsId",
                                   _count,@"count",
                                   [NSNumber numberWithInteger:_type],@"type",
                                   nil];
    if (_style != nil) {
        [params setValue:_style forKey:@"styleId"];
    }
    [YNHttpManagers joinToShoppingCartWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showImage:nil status:LocalAddSuccess];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                [self startNetWorkingRequestWithGetGoodsDetails];
            }];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalAddFailure];
            [SVProgressHUD dismissWithDelay:2.0f ];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithShareToThird{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"wayId":[NSNumber numberWithInteger:1]};
    [YNHttpManagers shareToThirdWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithBuyNowToSubmit{

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [DEFAULTS valueForKey:kUserLoginInfors][@"userId"],@"userId",
                                   _goodsId,@"goodsId",
                                   _count,@"count",
                                   [NSNumber numberWithInteger:_type],@"type",
                                   nil];
    if (![_style isEqualToString:@""]) {
        [params setValue:_style forKey:@"styleId"];
    }
    [YNHttpManagers buyNowToSubmitWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            YNFirmOrderViewController *pushCV = [[YNFirmOrderViewController alloc] init];
            pushCV.status = 2;
            pushCV.count = _count;
            pushCV.goodsId = _goodsId;
            pushCV.style = _style;
            [self.navigationController pushViewController:pushCV animated:NO];
        }else{
            //do failure things
            [self.inforView showPopView:YES];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
#pragma mark - 视图加载
-(YNTipsPerfectInforView *)inforView{
    if (!_inforView) {
        CGRect frame = CGRectMake((SCREEN_WIDTH-W_RATIO(536))/2.0, (SCREEN_HEIGHT-W_RATIO(506))/2.0, W_RATIO(536), W_RATIO(504));
        YNTipsPerfectInforView *inforView = [[YNTipsPerfectInforView alloc] initWithFrame:frame img:[UIImage imageNamed:@"wanshanziliao_tubiao"] title:LocalPerfectInfor tips:LocalPerfectTips btnTitle:LocalGoPerfect];
        _inforView = inforView;
        inforView.isTapGesture = YES;
        [inforView setDidSelectSubmitButtonBlock:^{
            YNPrefectInforViewController *pushCV = [[YNPrefectInforViewController alloc] init];
            pushCV.index = 1;
            pushCV.goodsId = _goodsId;
            pushCV.count = _count;
            pushCV.style = _style;
            [self.navigationController pushViewController:pushCV animated:NO];
        }];
    }
    return _inforView;
}
-(YNGoodsDetailsView *)detailView{
    if (!_detailView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.bottomBtnsView)-W_RATIO(2));
        YNGoodsDetailsView *detailView = [[YNGoodsDetailsView alloc] initWithFrame:frame];
        _detailView = detailView;
        [self.view addSubview:detailView];
        [detailView setDidSelectShareButtonClickBlock:^{
            [self.selectShareView showPopView:YES];
        }];
    }
    return _detailView;
}
-(YNGoodsDetailBtnsView *)bottomBtnsView{
    if (!_bottomBtnsView) {
        YNGoodsDetailBtnsView *bottomBtnsView = [[YNGoodsDetailBtnsView alloc] init];
        _bottomBtnsView = bottomBtnsView;
        [self.view addSubview:bottomBtnsView];
        bottomBtnsView.backgroundColor = COLOR_FFFFFF;
        bottomBtnsView.frame = CGRectMake(0, SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        [bottomBtnsView setDidSelectAddCartButtonClickBlock:^{
            
            self.selectBuyType = 1;//加入购物车
            [self startNetWorkingRequestWithSelectGoodsType];
        }];
        [bottomBtnsView setDidSelectBuyButtonClickBlock:^{
            
            self.selectBuyType = 2;//立即购买
            [self startNetWorkingRequestWithSelectGoodsType];
        }];
    }
    return _bottomBtnsView;
}
-(YNSelectParaView *)selectParaView{
    if (!_selectParaView) {
        CGRect frame = CGRectMake(0, SCREEN_HEIGHT-SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_WIDTH);
        YNSelectParaView *selectParaView = [[YNSelectParaView alloc] initWithFrame:frame];
        _selectParaView = selectParaView;
        selectParaView.maxNum = [_detailView.dataDict[@"stock"] integerValue];
        [selectParaView setDidSelectSubmitButtonBlock:^(NSString *style, NSString *count,CGFloat price) {
            self.style = style;
            self.count = count;
            self.bottomBtnsView.price = [NSString stringWithFormat:@"%.2f",([_bottomBtnsView.price floatValue]+price)*[count integerValue]];
            if (self.selectBuyType == 1) {
                [self startNetWorkingRequestWithJoinToShoppingCart];
            }else if (self.selectBuyType == 2){
                [self startNetWorkingRequestWithBuyNowToSubmit];
            }
        }];
    }
    return _selectParaView;
}
-(YNShareThirdSelectView *)selectShareView{
    if (!_selectShareView) {
        CGRect frame = CGRectMake(0,SCREEN_HEIGHT- W_RATIO(450), SCREEN_WIDTH,  W_RATIO(450));
        YNShareThirdSelectView *selectShareView = [[YNShareThirdSelectView alloc] initWithFrame:frame];
        _selectShareView = selectShareView;
        [selectShareView setDidSelectShareThirdSelectBlick:^(NSInteger index) {
            [self thirdShareWithIndex:index];
        }];
    }
    return _selectShareView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)tipsUserNotLogin{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先登录" message:@"未登录用户请先登录" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:LocalDone style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        YNLoginViewController *pushVC= [[YNLoginViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:LocalCancel style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)makeData{
    [super makeData];
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    _collectBtn = [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"shoucang_bai"] selectImg:[UIImage imageNamed:@"shoucang_huang"] isOnRight:YES btnClickBlock:^(BOOL isShow) {
        [weakSelf startNetWorkingRequestWithCollectGoods];
    }];
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"jinrugouwuche"] selectImg:nil isOnRight:YES btnClickBlock:^(BOOL isShow) {
        YNTabBarController *tab = [[YNTabBarController alloc] init];
        tab.selectedIndex = 2;
        AppDelegate *appDelegate =
        (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.window.rootViewController = tab;
    }];
    self.titleLabel.text = LocalGoodsDetail;
}
-(void)makeUI{
    [super makeUI];
}
-(void)thirdShareWithIndex:(NSInteger)index{
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
