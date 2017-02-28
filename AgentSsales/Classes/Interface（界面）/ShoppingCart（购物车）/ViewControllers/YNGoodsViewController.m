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

@interface YNGoodsViewController ()
{
    NSInteger _type;
}

@end

@implementation YNGoodsViewController
#pragma mark - 视图生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationSelectButton:) name:@"allSelect" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationDelectGoodsButton:) name:@"delectGoods" object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startNetWorkingRequestWithGetShoppingCartList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeData];
    [self makeUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithGetShoppingCartList{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"type":[NSNumber numberWithInteger:_type],
                             @"status":[NSNumber numberWithInteger:_index+1]};
    [YNHttpManagers getShoppingCartListWithParams:params success:^(id response) {
        self.tableView.dataArrayM = response;
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithChangeGoodsNumWithIndex:(NSInteger)index{
    NSDictionary *params = @{@"shoppingId":_tableView.dataArrayM[index][@"shoppingId"],
                             @"count":_tableView.numArrayM[index]};
    [YNHttpManagers changeGoodsNumWithParams:params success:^(id response) {
        [self startNetWorkingRequestWithGetShoppingCartList];
    } failure:^(NSError *error) {
    }];
}
-(void)startNetWorkingRequestWithStartDelectGoods{
    NSMutableString *shoppingIds = [NSMutableString string];
    [self.tableView.selectArrayM enumerateObjectsUsingBlock:^(NSNumber * _Nonnull isSelect, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([isSelect boolValue]) {
            [self.tableView.selectArrayM removeObjectAtIndex:idx];
            [shoppingIds appendFormat:@",%@",_tableView.dataArrayM[idx][@"shoppingId"]];
        }
    }];
    if (shoppingIds.length) {
        [shoppingIds deleteCharactersInRange:NSMakeRange(0, 1)];
        NSDictionary *params = @{@"shoppingId":shoppingIds};
        [YNHttpManagers startDelectGoodsWithParams:params success:^(id response) {
            [self startNetWorkingRequestWithGetShoppingCartList];
        } failure:^(NSError *error) {
        }];
    }else{
        NSLog(@"请选择货物");
    }
}
#pragma mark - 视图加载
-(YNGoodsCartTableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-kUITabBarH-W_RATIO(84)-W_RATIO(90));
        YNGoodsCartTableView *tableView = [[YNGoodsCartTableView alloc] initWithFrame:frame];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setHandleCellEditButtonBlock:^(BOOL isEdit,NSInteger index) {
            if (isEdit == YES) {
                [self startNetWorkingRequestWithChangeGoodsNumWithIndex:index];
            }
        }];
    }
    return _tableView;
}

#pragma mark - 代理实现

#pragma mark - 函数、消息
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
        self.tableView.allCount = 0;
        self.tableView.allPrice = 0;
        [self.tableView.selectArrayM enumerateObjectsUsingBlock:^(NSNumber * _Nonnull isSelect, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.tableView.selectArrayM replaceObjectAtIndex:idx withObject:notification.userInfo[@"status"]];
            if (self.status) {
                self.tableView.allCount += [self.tableView.numArrayM[idx] integerValue];
                self.tableView.allPrice += [self.tableView.numArrayM[idx] integerValue]*[self.tableView.dataArrayM[idx][@"salesprice"] floatValue];
            }
        }];
        [self.tableView reloadData];
    }
}
- (void)handleNotificationDelectGoodsButton:(NSNotification *)notification{
    if (self.index == [notification.userInfo[@"index"] integerValue]) {
        [self startNetWorkingRequestWithStartDelectGoods];
        [self.tableView reloadData];
    }
}
- (void)dealloc
{
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark - 数据懒加载

#pragma mark - 其他

@end
