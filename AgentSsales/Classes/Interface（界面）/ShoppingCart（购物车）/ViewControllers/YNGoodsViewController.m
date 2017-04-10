//
//  YNGoodsViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsViewController.h"
#import "YNGoodsCartTableView.h"
#import "YNShoppingCartViewController.h"
#import "YNShowEmptyView.h"
#import "YNTerraceGoodsViewController.h"

@interface YNGoodsViewController ()
{
    NSInteger _type;
}
@property (nonatomic,weak) YNShowEmptyView *emptyView;
@end

@implementation YNGoodsViewController
#pragma mark - 视图生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationSelectButton:) name:@"allSelect" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationDelectGoodsButton:) name:@"delectGoods" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetShoppingCartList{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"type":[NSNumber numberWithInteger:_type],
                             @"status":[NSNumber numberWithInteger:_index+1]};
    [YNHttpManagers getShoppingCartListWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            YNShoppingCartListModel *shoppingCartListModel = [YNShoppingCartListModel modelWithDictionary:response];
            shoppingCartListModel.statusIndex = _index;
            self.tableView.shoppingCartListModel = shoppingCartListModel;
            self.emptyView.hidden = shoppingCartListModel.shoppingArray.count;
        }else{
            //do failure things
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithChangeGoodsNumWithIndex:(NSInteger)index{
    YNShoppingCartGoodsModel *shoppingCartGoodsModel = _tableView.shoppingCartListModel.shoppingArray[index];
    NSDictionary *params = @{@"shoppingId":[NSNumber numberWithInteger:shoppingCartGoodsModel.shoppingId],
                             @"count":[NSNumber numberWithInteger:shoppingCartGoodsModel.count]};
    [YNHttpManagers changeGoodsNumWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showImage:nil status:LocalChangeSuccess];
            [SVProgressHUD dismissWithDelay:2.0f];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalChangeFailure];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
}
-(void)startNetWorkingRequestWithStartDelectGoods{
    NSMutableString *shoppingIds = [NSMutableString string];
    for (NSInteger idx = 0; idx < self.tableView.shoppingCartListModel.shoppingArray.count; idx++) {
        YNShoppingCartGoodsModel *shoppingCartGoodsModel = _tableView.shoppingCartListModel.shoppingArray[idx];
        if (shoppingCartGoodsModel.selected) {
            [shoppingIds appendFormat:@",%ld",(long)shoppingCartGoodsModel.shoppingId];
        }
    }
    if (!shoppingIds.length) {
        //tipssomething
        [SVProgressHUD showImage:nil status:LocalSelectGoods];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else{
        [self sendNotificationCenterPriceAndCountWithStatus:NO];
        [shoppingIds deleteCharactersInRange:NSMakeRange(0, 1)];
        NSDictionary *params = @{@"shoppingId":shoppingIds};
        [YNHttpManagers startDelectGoodsWithParams:params success:^(id response) {
            if ([response[@"code"] isEqualToString:@"success"]) {
                //do success things
                [SVProgressHUD showImage:nil status:LocalDelectSuccess];
                [SVProgressHUD dismissWithDelay:0.5f completion:^{
                    [self startNetWorkingRequestWithGetShoppingCartList];
                }];
            }else{
                //do failure things
                [SVProgressHUD showImage:nil status:LocalDelectFailure];
                [SVProgressHUD dismissWithDelay:2.0f ];
            }
        } failure:^(NSError *error) {
            //do error things
        }];
    }
}
#pragma mark - 视图加载
-(YNGoodsCartTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-kUITabBarH-W_RATIO(90)-W_RATIO(90));
        YNGoodsCartTableView *tableView = [[YNGoodsCartTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setHandleCellEditButtonBlock:^(NSInteger index) {
            [self startNetWorkingRequestWithChangeGoodsNumWithIndex:index];
        }];
        [tableView setDidSelectCellBlock:^(NSInteger goodsId) {
            YNTerraceGoodsViewController *pushVC = [[YNTerraceGoodsViewController alloc] init];
            pushVC.goodsId = [NSString stringWithFormat:@"%ld",(long)goodsId];
            [self.navigationController pushViewController:pushVC animated:YES];
        }];
    }
    return _tableView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0,W_RATIO(2), SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-kUITabBarH-W_RATIO(90)-W_RATIO(90)-W_RATIO(2)*2);
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wuwuliu"];
        emptyView.tips = LocalCartNoGoods;
    }
    return _emptyView;
}
#pragma mark - 代理实现

#pragma mark - 函数、消息
-(void)sendNotificationCenterPriceAndCountWithStatus:(BOOL)status{
    NSMutableString *shoppingIds = [NSMutableString string];
    NSInteger isUnableCount = 0;
    for (YNShoppingCartGoodsModel *shoppingCartGoodsModel in self.tableView.shoppingCartListModel.shoppingArray) {
        CGFloat salesprice = [[NSString decimalNumberWithDouble:shoppingCartGoodsModel.salesprice] floatValue];
        if (status && !shoppingCartGoodsModel.selected) {//全选
            [shoppingIds appendFormat:@",%ld",shoppingCartGoodsModel.shoppingId];
            _tableView.shoppingCartListModel.allCount += shoppingCartGoodsModel.count;
            _tableView.shoppingCartListModel.allPrice += shoppingCartGoodsModel.count * salesprice;
            BOOL isUnAble = shoppingCartGoodsModel.isdelete || (shoppingCartGoodsModel.count>shoppingCartGoodsModel.stock&&shoppingCartGoodsModel.goodsId);
            if (isUnAble) {
                isUnableCount += 1;
            }
        }else if (!status && shoppingCartGoodsModel.selected){//取消
            shoppingIds = [NSMutableString stringWithFormat:@""];
            _tableView.shoppingCartListModel.allCount -= shoppingCartGoodsModel.count;
            _tableView.shoppingCartListModel.allPrice -= shoppingCartGoodsModel.count * salesprice;
        }
    }
    if (shoppingIds.length) {
        [shoppingIds deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"priceAndCount" object:nil userInfo:
     @{@"allPrice":[NSString stringWithFormat:@"%f",_tableView.shoppingCartListModel.allPrice],
       @"allCount":[NSString stringWithFormat:@"%ld",_tableView.shoppingCartListModel.allCount],
       @"isEditing":[NSNumber numberWithBool:_tableView.shoppingCartListModel.editingCount],
       @"isUnAble":[NSNumber numberWithInteger:isUnableCount],
       @"shoppingIds":shoppingIds}];
}
-(void)makeData{
    _type = [LanguageManager currentLanguageIndex];
}
-(void)makeNavigationBar{
    
}
-(void)makeUI{
    
}
- (void)handleNotificationSelectButton:(NSNotification *)notification{
    if (self.index == [notification.userInfo[@"index"] integerValue]) {
        self.status = [notification.userInfo[@"status"] boolValue];
        [self sendNotificationCenterPriceAndCountWithStatus:self.status];
        NSMutableArray<Optional,YNShoppingCartGoodsModel> *selectedArrayM = [_tableView.shoppingCartListModel.shoppingArray mutableCopy];
        [_tableView.shoppingCartListModel.shoppingArray enumerateObjectsUsingBlock:^(YNShoppingCartGoodsModel *shoppingCartGoodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
            shoppingCartGoodsModel.selected = self.status;
            [selectedArrayM replaceObjectAtIndex:idx withObject:shoppingCartGoodsModel];
        }];
        _tableView.shoppingCartListModel.shoppingArray = selectedArrayM;
        [_tableView reloadData];
    }
}
- (void)handleNotificationDelectGoodsButton:(NSNotification *)notification{
    if (self.index == [notification.userInfo[@"index"] integerValue] &&
        self.tableView.shoppingCartListModel.allCount) {
        [self startNetWorkingRequestWithStartDelectGoods];
    }
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
