//
//  YNCouponTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/18.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNCouponTableView.h"

@interface YNCouponTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNCouponTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.rowHeight = W_RATIO(240);
        self.bounces = NO;
        self.backgroundColor = COLOR_CLEAR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = COLOR_EDEDED;
        footerView.frame = CGRectMake(0, 0, WIDTHF(self),kMinSpace);
        
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
    YNCouponCell * couponCell = [tableView dequeueReusableCellWithIdentifier:@"couponCell"];
    if (couponCell == nil) {
        couponCell = [[YNCouponCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"couponCell"];
        couponCell.selectionStyle = UITableViewCellSelectionStyleNone;
        couponCell.backgroundColor = COLOR_EDEDED;
    }
    if ([self.allPrice floatValue] >= [_dataArray[indexPath.row][@"manzu"] floatValue]) {
        couponCell.isShowUse = YES;
    }else{
        couponCell.isShowUse = NO;
    }
    [couponCell setDidSelectUseButtonBlock:^{
        if (self.didSelectUseButtonBlock) {
            self.didSelectUseButtonBlock(_dataArray[indexPath.row][@"money"],_dataArray[indexPath.row][@"id"]);
        }
    }];
    if (self.isInvalid == NO) {
        if (indexPath.row % 2) {
            couponCell.cellType = RedType;
        }else{
            couponCell.cellType = BlueType;
        }
    }else{
        couponCell.cellType = GrayType;
    }
    couponCell.dict = _dataArray[indexPath.row];
    return couponCell;
}
@end
@interface YNCouponCell ()

@property (nonatomic,weak) UIImageView * bgImgView;

@property (nonatomic,weak) UIImageView * invalidImgView;

@property (nonatomic,weak) UILabel * markLabel;

@property (nonatomic,weak) UILabel * priceLabel;

@property (nonatomic,weak) UILabel * tipsLabel;

@property (nonatomic,weak) UILabel * timeLabel;

@property (nonatomic,weak) UIButton * useBtn;

@end
@implementation YNCouponCell

-(void)setIsShowUse:(BOOL)isShowUse{
    _isShowUse = isShowUse;
    self.useBtn.hidden = !isShowUse;
}
-(void)setCellType:(YNCouponCellType)cellType{
    _cellType = cellType;
    if (cellType == RedType) {
        self.bgImgView.image = [UIImage imageNamed:@"youhuiquan_hong"];
        self.markLabel.textColor = COLOR_DF463E;
        [self.useBtn setTitleColor:COLOR_69B6FF forState:UIControlStateNormal];
    }else if (cellType == BlueType){
        self.bgImgView.image = [UIImage imageNamed:@"youhuiquan_lan"];
        self.markLabel.textColor = COLOR_69B6FF;
        [self.useBtn setTitleColor:COLOR_DF463E forState:UIControlStateNormal];
    }else if (cellType == GrayType){
        self.bgImgView.image = [UIImage imageNamed:@"youhuiquan_kui"];
        self.markLabel.textColor = COLOR_BFBFBF;
        self.timeLabel.textColor = _markLabel.textColor;
    }
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.markLabel.text = @"￥";
    self.priceLabel.text = [NSString stringWithFormat:@"%@",dict[@"money"]];
    self.tipsLabel.text = [NSString stringWithFormat:@"满%@元使用",dict[@"manzu"]];
    self.timeLabel.text = [NSString stringWithFormat:@"有效期至%@",dict[@"createtime"]];
    if (self.cellType == GrayType) {
        if ([dict[@"status"] integerValue] == 2) {
            self.invalidImgView.image = [UIImage imageNamed:@"yiguoqi_quan"];
        }else if ([dict[@"status"] integerValue] == 3){
            self.invalidImgView.image = [UIImage imageNamed:@"yishiyong_quan"];
        }
    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(kMidSpace, kMidSpace, markSize.width, markSize.height);
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:WIDTHF(_bgImgView)/3.0];
    self.priceLabel.frame = CGRectMake(MaxXF(_markLabel), YF(_markLabel), priceSize.width, priceSize.height);
    
    CGSize tipsSize = [_tipsLabel.text calculateHightWithFont:_tipsLabel.font maxWidth:WIDTHF(_bgImgView)-MaxXF(_priceLabel)-W_RATIO(20)*2];
    self.tipsLabel.frame = CGRectMake(WIDTHF(_bgImgView)-tipsSize.width-W_RATIO(20), YF(_priceLabel), tipsSize.width, tipsSize.height);
    
    CGSize timeSize = [_timeLabel.text calculateHightWithFont:_timeLabel.font maxWidth:WIDTHF(_bgImgView)-MaxXF(_priceLabel)-W_RATIO(20)*2];
    self.timeLabel.frame = CGRectMake(WIDTHF(_bgImgView)-timeSize.width-W_RATIO(20),MaxYF(_tipsLabel)+W_RATIO(20), timeSize.width, timeSize.height);
    CGSize useSize = [_useBtn.titleLabel.text calculateHightWithFont:_useBtn.titleLabel.font maxWidth:0];
    self.useBtn.frame = CGRectMake(MaxXF(_timeLabel)-useSize.width, MaxYF(_timeLabel)+W_RATIO(30), useSize.width, useSize.height);
}

-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        UIImageView *bgImgView = [[UIImageView alloc] init];
        _bgImgView = bgImgView;
        bgImgView.userInteractionEnabled = YES;
        [self.contentView addSubview:bgImgView];
        bgImgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), WIDTHF(self.contentView)-W_RATIO(20)*2, W_RATIO(240)-W_RATIO(20));
    }
    return _bgImgView;
}
-(UIImageView *)invalidImgView{
    if (!_invalidImgView) {
        UIImageView *invalidImgView = [[UIImageView alloc] init];
        _invalidImgView = invalidImgView;
        [self.bgImgView addSubview:invalidImgView];
        invalidImgView.frame = CGRectMake((WIDTHF(_bgImgView)-W_RATIO(200))/2.0, 0,W_RATIO(200), W_RATIO(100));
    }
    return _invalidImgView;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.bgImgView addSubview:markLabel];
        markLabel.font = FONT(40);
    }
    return _markLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.bgImgView addSubview:priceLabel];
        priceLabel.textColor = _markLabel.textColor;
        priceLabel.font = FONT(110);
        priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self.bgImgView addSubview:tipsLabel];
        tipsLabel.textColor = _markLabel.textColor;
        tipsLabel.font = FONT(36);
        tipsLabel.textAlignment = NSTextAlignmentRight;
        tipsLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _tipsLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc] init];
        _timeLabel = timeLabel;
        [self.bgImgView addSubview:timeLabel];
        timeLabel.font = FONT(28);
        timeLabel.textColor = COLOR_999999;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLabel;
}
-(UIButton *)useBtn{
    if (!_useBtn) {
        UIButton *useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _useBtn = useBtn;
        [self.bgImgView addSubview:useBtn];
        [useBtn setTitle:@"立即使用" forState:UIControlStateNormal];
        useBtn.titleLabel.font = FONT(30);
        [useBtn addTarget:self action:@selector(handleUseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _useBtn;
}
-(void)handleUseButtonClick:(UIButton*)btn{
    if (self.didSelectUseButtonBlock) {
        self.didSelectUseButtonBlock();
    }
}
@end




