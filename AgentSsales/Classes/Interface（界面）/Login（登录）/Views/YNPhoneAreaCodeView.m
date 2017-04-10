//
//  YNPhoneAreaCodeView.m
//  AgentSsales1
//
//  Created by innofive on 17/2/9.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPhoneAreaCodeView.h"

@interface YNPhoneAreaCodeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YNPhoneAreaCodeView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(kMidSpace, (SCREEN_HEIGHT-(W_RATIO(100)*6))/2.0, SCREEN_WIDTH-kMidSpace*2, W_RATIO(100)*6);
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self showPopView:YES];
    [self.tableView reloadData];
}
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        _tableView = tableView;
        [self addSubview:tableView];
        tableView.frame = self.bounds;
        tableView.rowHeight = W_RATIO(100);
        tableView.backgroundColor = COLOR_CLEAR;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        UILabel *headLabel = [[UILabel alloc] init];
        headLabel.frame = CGRectMake(0, 0, WIDTHF(tableView), W_RATIO(100));
        headLabel.backgroundColor = COLOR_FFFFFF;
        headLabel.font = FONT(36);
        headLabel.text = LocalSelectYouCountry;
        headLabel.textColor = COLOR_DF463E;
        headLabel.textAlignment = NSTextAlignmentCenter;
        tableView.tableHeaderView = headLabel;
        
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNPhoneAreaCodeCell * codeCell = [tableView dequeueReusableCellWithIdentifier:@"codeCell"];
    if (codeCell == nil) {
        codeCell = [[YNPhoneAreaCodeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"codeCell"];
        codeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 0, WIDTHF(self), W_RATIO(2));
        lineView.backgroundColor = COLOR_EDEDED;
        [codeCell.contentView addSubview:lineView];
    }
    codeCell.isSelect = ([indexPath compare:self.indexPath] == NSOrderedSame) ? YES : NO;
    codeCell.country = self.dataArray[indexPath.row];
    return codeCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.indexPath = indexPath;
    if (self.didSelectCodeCellBlock) {
        self.didSelectCodeCellBlock(indexPath.row);
    }
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    [self.tableView reloadData];
    [self dismissPopView:YES];
}
- (void)showPopView:(BOOL)animated
{
    [self.baseView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.baseView];
    
    if (!animated) {
        return;
    }
    //self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.alpha = 0.f;
    [UIView animateWithDuration:0.25f delay:.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //self.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}
- (void)dismissPopView:(BOOL)animated
{
    if (!animated) {
        [self.baseView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        //self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.baseView removeFromSuperview];
    }];
}
-(UIView *)baseView{
    if (!_baseView) {
        UIView *baseView = [[UIView alloc] init];
        _baseView = baseView;
        [baseView setFrame:[UIScreen mainScreen].bounds];
        [baseView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [baseView setUserInteractionEnabled:YES];
        
    }
    return _baseView;
}
-(void)setIsTapGesture:(BOOL)isTapGesture{
    _isTapGesture = isTapGesture;
    if (isTapGesture) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureClick:)];
        [self.baseView addGestureRecognizer:tapGesture];
    }
}

- (void)handleTapGestureClick:(UITapGestureRecognizer *)tap
{
    [self dismissPopView:YES];
}

@end
@interface YNPhoneAreaCodeCell()

@property (nonatomic,weak) UIImageView * flagImgView;

@property (nonatomic,weak) UILabel * titleLabel;

@property (nonatomic,weak) UIButton * selectBtn;

@end
@implementation YNPhoneAreaCodeCell

-(void)setCountry:(NSString *)country{
    _country = country;
    self.titleLabel.text = country;
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    self.selectBtn.selected = isSelect;
}
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn = selectBtn;
        [self.contentView addSubview:selectBtn];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_kui_gouwuche"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_hong_gouwuche"] forState:UIControlStateSelected];

        selectBtn.frame = CGRectMake(W_RATIO(660)-kMidSpace-kMaxSpace, (W_RATIO(100)-kMidSpace)/2.0, kMidSpace, kMidSpace);
    }
    return _selectBtn;
}
-(UIImageView *)flagImgView{
    if (!_flagImgView) {
        UIImageView *flagImgView = [[UIImageView alloc] init];
        _flagImgView = flagImgView;
        [self.contentView addSubview:flagImgView];
        flagImgView.frame = CGRectMake(kMidSpace,(W_RATIO(100)-W_RATIO(60))/2.0, W_RATIO(60), W_RATIO(60));
    }
    return _flagImgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        titleLabel.font = FONT(32);
        titleLabel.textColor = COLOR_333333;
        titleLabel.frame = CGRectMake(MaxXF(_flagImgView)+W_RATIO(20), (W_RATIO(100)-W_RATIO(40))/2.0, XF(_selectBtn)-MaxXF(_flagImgView)-W_RATIO(20)*2, W_RATIO(40));
    }
    return _titleLabel;
}

@end
