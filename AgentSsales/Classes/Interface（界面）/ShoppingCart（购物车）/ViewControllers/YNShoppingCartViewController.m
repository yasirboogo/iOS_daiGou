//
//  ShoppingCartViewController.m
//  AgentSsales
//
//  Created by innofive on 16/12/15.
//  Copyright © 2016年 inno. All rights reserved.
//

#import "YNShoppingCartViewController.h"
#import "YNPrefectInforViewController.h"
#import "YNFirmOrderViewController.h"
#import "YNGoodsViewController.h"
#import "YNGoodsSubmitView.h"
#import "YNTipsPerfectInforView.h"
#import "YNGoodsCartTableView.h"

@interface YNShoppingCartViewController ()<TYPagerControllerDataSource>
{
    UIButton *_selectBtn;
    NSInteger _type;
}
@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@property (nonatomic, strong) YNGoodsSubmitView *submitView;

@property (nonatomic, strong) YNTipsPerfectInforView *inforView;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic,assign) BOOL isEditing;

@property (nonatomic,assign) BOOL isUnAble;

@property (nonatomic,copy) NSMutableString *shoppingIds;

@end


@implementation YNShoppingCartViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pagerController reloadData];
    [_pagerController moveToControllerAtIndex:1 animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePriceBalance:) name:@"priceAndCount" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark - 网路请求
-(void)startNetWorkingRequestWithStartSubmitOrder{

    if (!_shoppingIds.length) {
        [SVProgressHUD showImage:nil status:LocalSelectGoods];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else{
        NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                                 @"shoppingId":_shoppingIds,
                                 @"type":[NSNumber numberWithInteger:_type],
                                 @"status":[NSNumber numberWithInteger:_index+1]};
        [YNHttpManagers startSubmitOrderWithParams:params success:^(id response) {
            if ([response[@"code"] isEqualToString:@"success"]) {
                //do success things
                YNFirmOrderViewController *pushCV = [[YNFirmOrderViewController alloc] init];
                pushCV.status = _index+1;
                pushCV.shoppingId = _shoppingIds;
                [self.navigationController pushViewController:pushCV animated:NO];
            }else{
                //do failure things
                [self.inforView showPopView:YES];
            }
        } failure:^(NSError *error) {
            //do error things
        }];
    }
}
#pragma mark - 视图加载
-(TYTabButtonPagerController *)pagerController{
    if (!_pagerController) {
        TYTabButtonPagerController *pagerController = [[TYTabButtonPagerController alloc] init];
        _pagerController = pagerController;
        pagerController.dataSource = self;
        pagerController.cellSpacing = W_RATIO(100);
        pagerController.cellWidth = pagerController.cellSpacing*2;
        pagerController.collectionLayoutEdging = (SCREEN_WIDTH-pagerController.cellSpacing-pagerController.cellWidth*2)/2.0;
        pagerController.normalTextColor = COLOR_666666;
        pagerController.selectedTextColor = COLOR_DF463E;
        pagerController.normalTextFont = FONT(30);
        pagerController.selectedTextFont = FONT(36);
        pagerController.contentTopEdging = W_RATIO(90);
        pagerController.barStyle = TYPagerBarStyleProgressBounceView;
        pagerController.view.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-HEIGHTF(self.submitView));
        [self addChildViewController:pagerController];
        [self.view addSubview:pagerController.view];
        [pagerController setDidScrollToTabPageIndexHandle:^(NSInteger index) {
            _selectBtn.selected = NO;
            self.index = index;
            YNGoodsViewController *goodsVC = [self.pagerController.childViewControllers lastObject];
            if ([DEFAULTS valueForKey:kUserLoginInfors]) {
                [goodsVC startNetWorkingRequestWithGetShoppingCartList];
            }
            [goodsVC sendNotificationCenterPriceAndCountWithStatus:NO];
            
        }];
    }
    return _pagerController;
}

-(YNGoodsSubmitView *)submitView{
    if (!_submitView) {
        CGRect frame = CGRectMake(0,SCREEN_HEIGHT-kUITabBarH-W_RATIO(90), SCREEN_WIDTH, W_RATIO(90));
        YNGoodsSubmitView *submitView = [[YNGoodsSubmitView alloc] initWithFrame:frame];
        _submitView = submitView;
        [self.view addSubview:submitView];
        [submitView setHandleSubmitButtonBlock:^{
            if (self.isUnAble) {
                [SVProgressHUD showImage:nil status:LocalLowStocks];
                [SVProgressHUD dismissWithDelay:2.0f];
            }else{
                if (!self.isEditing) {
                    [self startNetWorkingRequestWithStartSubmitOrder];
                }else{
                    [SVProgressHUD showImage:nil status:LocalSaveFirst];
                    [SVProgressHUD dismissWithDelay:2.0f];
                }
            }
        }];
    }
    return _submitView;
}
-(YNTipsPerfectInforView *)inforView{
    if (!_inforView) {
        CGRect frame = CGRectMake((SCREEN_WIDTH-W_RATIO(536))/2.0, (SCREEN_HEIGHT-W_RATIO(506))/2.0, W_RATIO(536), W_RATIO(504));
        YNTipsPerfectInforView *inforView = [[YNTipsPerfectInforView alloc] initWithFrame:frame img:[UIImage imageNamed:@"wanshanziliao_tubiao"] title:LocalPerfectInfor tips:LocalPerfectTips btnTitle:LocalGoPerfect];
        _inforView = inforView;
        inforView.isTapGesture = YES;
        [inforView setDidSelectSubmitButtonBlock:^{
            YNPrefectInforViewController *pushCV = [[YNPrefectInforViewController alloc] init];
            pushCV.index = self.index;
            pushCV.shoppingId = _shoppingIds;
            [self.navigationController pushViewController:pushCV animated:NO];
        }];
    }
    return _inforView;
}
#pragma mark - 代理实现
#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController
{
    return 2;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    NSArray * titles = @[LocalPurGoods,LocalPlaGoods];
    return titles[index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    YNGoodsViewController *goodsVC = [[YNGoodsViewController alloc] init];
    goodsVC.index = index;
    return goodsVC;
}

#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    __weak typeof(self) weakSelf = self;
    _selectBtn = [self addNavigationBarBtnWithTitle:LocalAllSelect selectTitle:LocalCancel font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isShow) {
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"allSelect" object:nil userInfo:@{@"index":[NSNumber numberWithInteger:weakSelf.index],@"status":[NSNumber numberWithBool:isShow]}]];
    }];
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"shanchu_gouwuche"] selectImg:[UIImage imageNamed:@"shanchu_gouwuche"] isOnRight:NO btnClickBlock:^(BOOL isShow) {
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"delectGoods" object:nil userInfo:@{@"index":[NSNumber numberWithInteger:weakSelf.index]}]];
    }];
    self.titleLabel.text = LocalShopCart;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.submitView];
}
- (void)handlePriceBalance:(NSNotification*)notification{
    self.isEditing = [notification.userInfo[@"isEditing"] boolValue];
    self.isUnAble = [notification.userInfo[@"isUnAble"] boolValue];
    self.shoppingIds = [NSMutableString stringWithFormat:@"%@",notification.userInfo[@"shoppingIds"]];
    self.submitView.dict =
        @{@"allPrice":[NSString stringWithFormat:@"%.2f",[notification.userInfo[@"allPrice"] floatValue]],
          @"allNum":[NSString stringWithFormat:@"%ld",[notification.userInfo[@"allCount"] integerValue]]};
}
- (void)dealloc
{
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - 数据懒加载

#pragma mark - 其他


@end

