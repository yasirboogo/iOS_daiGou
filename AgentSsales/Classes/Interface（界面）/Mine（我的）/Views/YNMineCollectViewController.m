//
//  YNMineCollectViewController.m
//  AgentSsales
//
//  Created by innofive on 17/1/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineCollectViewController.h"
#import "YNMineCollectTableView.h"

@interface YNMineCollectViewController ()

@property (nonatomic,strong)UIButton *editBtn;

@property (nonatomic,assign)BOOL isEdit;

@property (nonatomic,weak)YNMineCollectTableView *tableView;

@property (nonatomic,weak)UIView *btnsView;

@property (nonatomic,weak)YNShowEmptyView *emptyView;

@end

@implementation YNMineCollectViewController

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

#pragma mark - 视图加载
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
-(YNMineCollectTableView *)tableView{
    if (!_tableView) {
        YNMineCollectTableView *tableView = [[YNMineCollectTableView alloc] init];
        _tableView = tableView;
        [self.view addSubview:tableView];
        [tableView setDidSelectMineCollectCellBlock:^(NSString *str) {
            NSLog(@"%@",str);
        }];
    }
    return _tableView;
}
-(UIView *)btnsView{
    if (!_btnsView) {
        UIView *btnsView = [[UIView alloc] init];
        _btnsView = btnsView;
        [self.view addSubview:btnsView];
        btnsView.size = CGSizeMake(SCREEN_WIDTH, W_RATIO(100));
        
        NSArray<NSString*> *btnTitles = @[@"全选",@"删除"];
        [btnTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnsView addSubview:bottomBtn];
            bottomBtn.frame = CGRectMake(idx*SCREEN_WIDTH/btnTitles.count, 0, WIDTHF(btnsView)/btnTitles.count,HEIGHTF(btnsView));
            [bottomBtn setTitle:title forState:UIControlStateNormal];
            [bottomBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
            bottomBtn.titleLabel.font = FONT(36);
            bottomBtn.tag = idx;
            [bottomBtn addTarget:self action:@selector(handleBottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (idx == 0) {//全选按钮
                bottomBtn.backgroundColor = COLOR_5A5A5A;
            }else if (idx == 1){//删除按钮
                bottomBtn.backgroundColor = COLOR_DF463E;
            }
        }];
        
    }
    return _btnsView;
}
-(YNShowEmptyView *)emptyView{
    if (!_emptyView) {
        CGRect frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kUINavHeight);
        YNShowEmptyView *emptyView = [[YNShowEmptyView alloc] initWithFrame:frame];
        _emptyView = emptyView;
        [self.view addSubview:emptyView];
        emptyView.tipImg = [UIImage imageNamed:@"wushoucang"];
        emptyView.tips = @"暂无收藏商品";
    }
    return _emptyView;
}
#pragma mark - 代理实现
-(void)handleBottomButtonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.tag == 0) {//全选按钮
        for (NSMutableDictionary *dictM in _tableView.dataArrayM) {
            [dictM setValue:[NSNumber numberWithBool:btn.selected] forKey:@"isSelect"];
        }
    }else if (btn.tag == 1){//删除按钮
        NSMutableArray<NSMutableDictionary*> *delectDicts = [NSMutableArray array];
        for (NSMutableDictionary *dictM in _tableView.dataArrayM) {
            if ([[dictM valueForKey:@"isSelect"] boolValue]) {
                [delectDicts addObject:dictM];
            }
        }
        [_tableView.dataArrayM removeObjectsInArray:delectDicts];
    }
    [_tableView reloadData];
}
#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.isEdit = NO;
    
    NSMutableDictionary *dictM1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"testGoods",@"image",
                                 @"书籍-设计师的自我修养",@"title",
                                 @"2016年出版版本",@"version",
                                 @YES,@"isInvalid",
                                 @NO,@"isSelect",
                                 @"500.14",@"price", nil];
    
    NSMutableDictionary *dictM2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"version",
                                   @YES,@"isInvalid",
                                   @NO,@"isSelect",
                                   @"500.14",@"price", nil];
    NSMutableDictionary *dictM3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"version",
                                   @YES,@"isInvalid",
                                   @NO,@"isSelect",
                                   @"500.14",@"price", nil];
    NSMutableDictionary *dictM4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"version",
                                   @YES,@"isInvalid",
                                   @NO,@"isSelect",
                                   @"500.14",@"price", nil];
    NSMutableDictionary *dictM5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"testGoods",@"image",
                                   @"书籍-设计师的自我修养",@"title",
                                   @"2016年出版版本",@"version",
                                   @YES,@"isInvalid",
                                   @NO,@"isSelect",
                                   @"500.14",@"price", nil];
    
    self.tableView.dataArrayM = [NSMutableArray arrayWithObjects:dictM1,dictM2,dictM3,dictM4,dictM5, nil];
    
    
}
-(void)makeNavigationBar{
    [super makeNavigationBar];

    __weak typeof(self) weakSelf = self;
    _editBtn = [self addNavigationBarBtnWithTitle:@"编辑" selectTitle:@"完成" font:FONT_15 isOnRight:YES btnClickBlock:^(BOOL isSelect) {
        weakSelf.isEdit = isSelect;
        weakSelf.tableView.isEdit = isSelect;
        weakSelf.editBtn.hidden = !weakSelf.tableView.dataArrayM.count;
        weakSelf.emptyView.hidden = weakSelf.tableView.dataArrayM.count;

    }];
    
    _editBtn.hidden = !_tableView.dataArrayM.count;
    self.titleLabel.text = @"我的收藏";
}
-(void)makeUI{
    [super makeUI];
    self.emptyView.hidden = _tableView.dataArrayM.count;
}
#pragma mark - 数据懒加载
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    
    self.btnsView.frame = CGRectMake(0,SCREEN_HEIGHT-W_RATIO(100)*isEdit, SCREEN_WIDTH, W_RATIO(100)*isEdit);
    self.tableView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, YF(_btnsView)-kUINavHeight);

}
#pragma mark - 其他

@end
