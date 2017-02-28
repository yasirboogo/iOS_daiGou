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

@property (nonatomic,assign) CGFloat allPrice;

@property (nonatomic,assign) NSInteger allCount;

@property (nonatomic,assign) NSInteger allSaveCount;

@property (nonatomic,assign) NSArray<NSString*> *goodsIdsArray;

@end


@implementation YNShoppingCartViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePriceBalance:) name:@"priceBalance" object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pagerController reloadData];

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark - 网路请求
-(void)startNetWorkingRequestWithStartSubmitOrder{
    NSMutableString *shoppingIds = [NSMutableString string];
    [self.goodsIdsArray enumerateObjectsUsingBlock:^(NSString * _Nonnull shoppingId, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![shoppingId isEqualToString:@"-99"]) {
            [shoppingIds appendFormat:@",%@",shoppingId];
        }
    }];
    if (shoppingIds.length) {
        [shoppingIds deleteCharactersInRange:NSMakeRange(0, 1)];
        NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                                 @"shoppingId":shoppingIds,
                                 @"type":[NSNumber numberWithInteger:_type],
                                 @"status":[NSNumber numberWithInteger:_index+1]};
        [YNHttpManagers startSubmitOrderWithParams:params success:^(id response) {
            YNFirmOrderViewController *pushCV = [[YNFirmOrderViewController alloc] init];
            pushCV.status = _index+1;
            pushCV.shoppingId = shoppingIds;
            [self.navigationController pushViewController:pushCV animated:NO];
        } failure:^(NSError *error) {
            [self.inforView showPopView:YES];
        }];
    }else{
        NSLog(@"请选择货物");
    }
}
#pragma mark - 视图加载
-(TYTabButtonPagerController *)pagerController{
    if (!_pagerController) {
        TYTabButtonPagerController *pagerController = [[TYTabButtonPagerController alloc] init];
        _pagerController = pagerController;
        pagerController.dataSource = self;
        pagerController.cellSpacing = W_RATIO(100);
        pagerController.cellWidth = pagerController.cellSpacing*1.5;
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
            self.index = index;
            YNGoodsViewController *goodsVC = [self.pagerController.childViewControllers lastObject];
            self.submitView.dict = @{
                                     @"allPrice":[NSString stringWithFormat:@"%.2f",goodsVC.tableView.allPrice],
                                     @"allNum":[NSString stringWithFormat:@"%ld",goodsVC.tableView.allCount]};
            
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
            if (!self.allSaveCount) {
                [self startNetWorkingRequestWithStartSubmitOrder];
            }else{
                NSLog(@"你刚完成编辑，还未保存");
            }
        }];
    }
    return _submitView;
}
-(YNTipsPerfectInforView *)inforView{
    if (!_inforView) {
        CGRect frame = CGRectMake((SCREEN_WIDTH-W_RATIO(536))/2.0, (SCREEN_HEIGHT-W_RATIO(506))/2.0, W_RATIO(536), W_RATIO(504));
        YNTipsPerfectInforView *inforView = [[YNTipsPerfectInforView alloc] initWithFrame:frame img:[UIImage imageNamed:@"wanshanziliao_tubiao"] title:@"完善个人资料" tips:@"需要完善个人资料才能购买哦~" btnTitle:@"去完善"];
        _inforView = inforView;
        inforView.isTapGesture = YES;
        [inforView setDidSelectSubmitButtonBlock:^{
            YNPrefectInforViewController *pushCV = [[YNPrefectInforViewController alloc] init];
            pushCV.index = self.index;
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
    NSArray * titles = @[@"代购商品",@"平台商品"];
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
    _selectBtn = [self addNavigationBarBtnWithTitle:@"全选" selectTitle:@"全选" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isShow) {
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"allSelect" object:nil userInfo:@{@"index":[NSNumber numberWithInteger:weakSelf.index],@"status":[NSNumber numberWithBool:@YES]}]];
    }];
    [self addNavigationBarBtnWithImg:[UIImage imageNamed:@"shanchu_gouwuche"] selectImg:[UIImage imageNamed:@"shanchu_gouwuche"] isOnRight:NO btnClickBlock:^(BOOL isShow) {
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"delectGoods" object:nil userInfo:@{@"index":[NSNumber numberWithInteger:weakSelf.index]}]];
    }];
    self.titleLabel.text = kLocalizedString(@"shopCart", @"购物车");
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.submitView];
}
- (void)handlePriceBalance:(NSNotification*)notification
{
    self.allPrice = [notification.userInfo[@"allPrice"] floatValue];
    self.allCount = [notification.userInfo[@"allCount"] integerValue];
    self.allSaveCount = [notification.userInfo[@"allSaveCount"] integerValue];
    self.goodsIdsArray = notification.userInfo[@"goodsIdsArrayM"];
    self.submitView.dict = @{
                             @"allPrice":[NSString stringWithFormat:@"%.2f",self.allPrice],
                             @"allNum":[NSString stringWithFormat:@"%ld",self.allCount]};
    
}
- (void)dealloc
{
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - 数据懒加载

#pragma mark - 其他


@end

