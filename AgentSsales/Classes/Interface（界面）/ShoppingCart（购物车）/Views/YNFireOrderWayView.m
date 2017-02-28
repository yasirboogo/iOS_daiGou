//
//  YNFireOrderWayView.m
//  AgentSsales
//
//  Created by innofive on 17/1/20.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNFireOrderWayView.h"

@interface YNFireOrderWayView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic,strong) NSIndexPath * indexPath;

@end

@implementation YNFireOrderWayView

-(instancetype)initWithRowHeight:(CGFloat)rowHeight width:(CGFloat)width showNumber:(NSInteger)showNumber{
    CGRect frame = CGRectMake((SCREEN_WIDTH-width)/2.0,(SCREEN_HEIGHT-(showNumber*rowHeight+kMidSpace*2))/2.0, width, (showNumber*rowHeight+kMidSpace*2));
    self = [super initWithFrame:frame];
    if (self) {
        self.rowHeight = rowHeight;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_FFFFFF;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = W_RATIO(20);
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = COLOR_FFFFFF;
        headerView.frame = CGRectMake(0, 0, WIDTHF(self),kMidSpace);
        self.tableHeaderView = headerView;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = COLOR_FFFFFF;
        footerView.frame = CGRectMake(0, 0, WIDTHF(self), kMidSpace);
        self.tableFooterView = footerView;
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNOrderWayCell * wayCell = [tableView dequeueReusableCellWithIdentifier:@"wayCell"];
    if (wayCell == nil) {
        wayCell = [[YNOrderWayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"wayCell"];
        wayCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    wayCell.isSelect = (self.indexPath == indexPath) ? YES : NO;
    wayCell.dict = _dataArray[indexPath.row];
    return wayCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.indexPath = indexPath;
    [self reloadData];
    if (self.didSelectOrderWayCellBlock) {
        self.didSelectOrderWayCellBlock([NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"name"]],[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"money"]]);
    }
}
- (void)showPopView:(BOOL)animated
{
    [self.baseView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.baseView];
    
    if (!animated) {
        return;
    }
    
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.alpha = 0.f;
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
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
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
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
@interface YNOrderWayCell ()

@property (nonatomic,weak) UILabel * titleLabel;

@property (nonatomic,weak) UILabel * subTitleLabel;

@property (nonatomic,weak) UIButton * selectBtn;

@end
@implementation YNOrderWayCell


-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    if (dict[@"money"] == NULL) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
    }else{
        self.titleLabel.text = [NSString stringWithFormat:@"%@%@元",dict[@"name"],dict[@"money"]];
    }
    self.subTitleLabel.text = dict[@"code"];
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
        selectBtn.frame = CGRectMake(W_RATIO(660)-kMidSpace-kMaxSpace, (W_RATIO(150)-kMidSpace)/2.0, kMidSpace, kMidSpace);
    }
    return _selectBtn;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        titleLabel.font = FONT(36);
        titleLabel.textColor = COLOR_333333;
        titleLabel.frame = CGRectMake(kMaxSpace, W_RATIO(30), XF(_selectBtn)-kMaxSpace-kMinSpace, W_RATIO(40));
    }
    return _titleLabel;
}
-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        UILabel *subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel = subTitleLabel;
        [self.contentView addSubview:subTitleLabel];
        subTitleLabel.font = FONT(32);
        subTitleLabel.textColor = COLOR_999999;
        subTitleLabel.frame = CGRectMake(XF(_titleLabel),MaxYF(_titleLabel)+kMinSpace,MaxXF(_titleLabel), W_RATIO(40));
    }
    return _subTitleLabel;
}
@end
