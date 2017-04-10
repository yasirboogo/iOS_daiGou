//
//  YNMineCollectTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineCollectTableView.h"

@interface YNMineCollectTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNMineCollectTableView

-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    [self reloadData];
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.rowHeight = W_RATIO(280);
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,kMinSpace)];
    }
    return self;
}
-(void)setSelectArrayM:(NSMutableArray<NSNumber *> *)selectArrayM{
    _selectArrayM = selectArrayM;
    for (NSDictionary *dict in _dataArrayM) {
        [_selectArrayM addObject:@NO];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArrayM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNMineCollectCell * collectCell = [tableView dequeueReusableCellWithIdentifier:@"collectCell"];
    if (collectCell == nil) {
        collectCell = [[YNMineCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collectCell"];
        collectCell.selectionStyle =UITableViewCellSelectionStyleNone;
        collectCell.backgroundColor = COLOR_CLEAR;
    }
    collectCell.isEdit = self.isEdit;
    collectCell.cellDict = _dataArrayM[indexPath.row];
    collectCell.isSelected = [self.selectArrayM[indexPath.row] boolValue];
    [collectCell setDidSelectedButtonClickBlock:^(BOOL isSelect) {
        [_selectArrayM replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:isSelect]];
        [self reloadData];
    }];
    return collectCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.didSelectMineCollectCellBlock) {
        self.didSelectMineCollectCellBlock([NSString stringWithFormat:@"%@",_dataArrayM[indexPath.row][@"id"]]);
    }
}
@end

@interface YNMineCollectCell ()
/** 背景图 */
@property (nonatomic,strong) UIView *bgView;
/** 失效提示 */
@property (nonatomic,strong) UILabel *invalidLabel;
/** 勾选按钮 */
@property (nonatomic,strong) UIButton *selectBtn;
/** ￥符号 */
@property (nonatomic,weak) UILabel *markLabel;

@end

@implementation YNMineCollectCell
-(void)setCellDict:(NSDictionary *)cellDict{
    _cellDict = cellDict;
    [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:cellDict[@"img"]] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    self.titleLabel.text = cellDict[@"name"];
    self.versionLabel.text = cellDict[@"note"];
    self.invalidLabel.text = LocalInvalid;
    self.markLabel.text = LocalMoneyMark;
    self.priceLabel.text = [NSString decimalNumberWithDouble:cellDict[@"salesprice"]];
    self.invalidLabel.hidden = ![cellDict[@"isdelete"] integerValue] && [cellDict[@"stock"] integerValue] > 0;
}
-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.selectBtn.selected = isSelected;
}
-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    //设置模式（编辑/完成）
    if (isEdit) {
        self.bgView.frame = CGRectMake(W_RATIO(80), W_RATIO(20), W_RATIO(650), W_RATIO(260));
        self.bgView.layer.cornerRadius = W_RATIO(20);
        self.selectBtn.frame = CGRectMake((XF(_bgView)-W_RATIO(60))/2.0, YF(_bgView)+(HEIGHTF(_bgView)-W_RATIO(60))/2.0, W_RATIO(60), W_RATIO(60));
    }else{
        self.bgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), W_RATIO(710), W_RATIO(260));
        self.bgView.layer.cornerRadius = W_RATIO(20);
        self.selectBtn.frame = CGRectZero;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //不同模式控件布局
    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:WIDTHF(_bgView)-MaxXF(_leftImgView)-W_RATIO(20)*2 font:_titleLabel.font line:_titleLabel.numberOfLines];
    _titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(20), W_RATIO(20)*2, titleSize.width,titleSize.height);
    
    CGSize versionSize = [_versionLabel.text calculateHightWithWidth:WIDTHF(_titleLabel) font:_versionLabel.font line:_versionLabel.numberOfLines];
    _versionLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_titleLabel)+kMinSpace, versionSize.width,versionSize.height);
    
    CGSize size = [_invalidLabel.text calculateHightWithFont:_invalidLabel.font maxWidth:0];
    _invalidLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(20),HEIGHTF(_bgView)-kMidSpace-W_RATIO(33),size.width+kMinSpace, W_RATIO(33));
    _invalidLabel.layer.cornerRadius = W_RATIO(10);
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
    _priceLabel.frame = CGRectMake(WIDTHF(_bgView)-kMidSpace-priceSize.width,YF(_invalidLabel), priceSize.width,HEIGHTF(_invalidLabel));
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_priceLabel)-markSize.width,MaxYF(_priceLabel)-markSize.height, markSize.width,markSize.height);
    
}
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn = selectBtn;
        [self.contentView addSubview:selectBtn];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_kui_gouwuche"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_hong_gouwuche"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(handleCellSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
-(void)handleCellSelectButtonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (self.didSelectedButtonClickBlock) {
        self.didSelectedButtonClickBlock(btn.selected);
    }
    
}
-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView= bgView;
        [self.contentView addSubview:bgView];
        bgView.backgroundColor = COLOR_FFFFFF;
    }
    return _bgView;
}
-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView * leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        [self.bgView addSubview:leftImgView];
        leftImgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), W_RATIO(220), W_RATIO(220));
    }
    return _leftImgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel * titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.bgView addSubview:titleLabel];
        titleLabel.font = FONT(32);
        titleLabel.numberOfLines = 1;
        titleLabel.textColor = COLOR_333333;
    }
    return _titleLabel;
}
-(UILabel *)versionLabel{
    if (!_versionLabel) {
        UILabel * versionLabel = [[UILabel alloc] init];
        _versionLabel = versionLabel;
        [self.bgView addSubview:versionLabel];
        versionLabel.font = FONT(26);
        versionLabel.textColor = COLOR_999999;
        versionLabel.numberOfLines = 2;
    }
    return _versionLabel;
}
-(UILabel *)invalidLabel{
    if (!_invalidLabel) {
        UILabel * invalidLabel = [[UILabel alloc] init];
        _invalidLabel = invalidLabel;
        [self.bgView addSubview:invalidLabel];
        invalidLabel.font = FONT(22);
        invalidLabel.textAlignment = NSTextAlignmentCenter;
        invalidLabel.hidden = YES;
        invalidLabel.textColor = COLOR_FFFFFF;
        invalidLabel.backgroundColor = COLOR_B7B7B7;
        invalidLabel.layer.masksToBounds = YES;
    }
    return _invalidLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel * priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.bgView addSubview:priceLabel];
        priceLabel.font = FONT(38);
        priceLabel.textColor = COLOR_666666;
    }
    return _priceLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.bgView addSubview:markLabel];
        markLabel.font = FONT(26);
        markLabel.textColor = COLOR_666666;
    }
    return _markLabel;
}
@end
