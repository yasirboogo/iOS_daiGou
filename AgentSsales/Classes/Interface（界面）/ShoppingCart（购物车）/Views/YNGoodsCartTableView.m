//
//  YNGoodsCartTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsCartTableView.h"

@interface YNGoodsCartTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNGoodsCartTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.rowHeight = W_RATIO(280);
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = COLOR_EDEDED;
        footerView.frame = CGRectMake(0, 0, WIDTHF(self), kMinSpace);
        self.tableFooterView = footerView;
        
    }
    return self;
}

-(void)setDataArrayM:(NSMutableArray<NSMutableDictionary *> *)dataArrayM{
    _dataArrayM = dataArrayM;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNGoodsCartCell * cartCell = [tableView dequeueReusableCellWithIdentifier:@"cartCell"];
    if (cartCell == nil) {
        cartCell = [[YNGoodsCartCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cartCell"];
        cartCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cartCell.backgroundColor = COLOR_EDEDED;
    }
    cartCell.dict = _dataArrayM[indexPath.row];
    [cartCell setDidSelectedButtonClickBlock:^(BOOL isSelect) {
        [_dataArrayM[indexPath.row] setValue:[NSNumber numberWithBool:isSelect] forKey:@"isSelect"];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    }];
    
    cartCell.isEnabled = [_dataArrayM[indexPath.row][@"num"] integerValue] > 1 ? YES:NO;
    
    [cartCell setHandleCellAddButtonBlock:^(NSInteger idx) {
        NSInteger num = [_dataArrayM[indexPath.row][@"num"] integerValue];
        if (idx == 0) {
            num -= 1;
        }else if (idx == 1){
            num += 1;
        }
        [_dataArrayM[indexPath.row] setObject:[NSString stringWithFormat:@"%ld",(long)num] forKey:@"num"];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    }];
    return cartCell;
}
@end
@interface YNGoodsCartCell ()
/** 勾选按钮 */
@property (nonatomic,weak) UIButton * selectBtn;
/** 背景 */
@property (nonatomic,weak) UIView * bgView;
/** 左边图片 */
@property (nonatomic,weak) UIImageView * leftImgView;
/** 标题 */
@property (nonatomic,weak) UILabel * titleLabel;
/** 副标题 */
@property (nonatomic,weak) UILabel * subTitleLabel;
/** ￥符号 */
@property (nonatomic,weak) UILabel * markLabel;
/** 价钱 */
@property (nonatomic,weak) UILabel * priceLabel;
/** 数量 */
@property (nonatomic,weak) UILabel * amountLabel;
/** 减按钮 */
@property (nonatomic,weak) UIButton * subBtn;
/** 加按钮 */
@property (nonatomic,weak) UIButton * addBtn;
@end
@implementation YNGoodsCartCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.leftImgView.image = [UIImage imageNamed:dict[@"image"]];
    
    self.titleLabel.text = dict[@"title"];
    
    self.subTitleLabel.text = dict[@"subTitle"];
    
    self.markLabel.text = NSLS(@"moneySymbol", @"货币符号");
    
    self.priceLabel.text = dict[@"price"];
    
    self.amountLabel.text = dict[@"num"];
    
    self.isSelected = [dict[@"isSelect"] boolValue];
}
-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.selectBtn.selected = isSelected;
}
-(void)setIsEnabled:(BOOL)isEnabled{
    _isEnabled = isEnabled;
    self.subBtn.enabled = isEnabled;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    不同模式控件布局
    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:WIDTHF(_bgView)-MaxXF(_leftImgView)-W_RATIO(20)*2 font:_titleLabel.font line:_titleLabel.numberOfLines];
    self.titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(20), W_RATIO(20)*2, titleSize.width,titleSize.height);

    CGSize subTitleSize = [_subTitleLabel.text calculateHightWithWidth:WIDTHF(_titleLabel) font:_subTitleLabel.font line:_subTitleLabel.numberOfLines];
    self.subTitleLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_titleLabel)+kMinSpace, subTitleSize.width,subTitleSize.height);

    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_subTitleLabel),MaxYF(_leftImgView)-markSize.height-W_RATIO(20), markSize.width,markSize.height);
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
    self.priceLabel.frame = CGRectMake(MaxXF(_markLabel),MaxYF(_markLabel)-priceSize.height,WIDTHF(_subTitleLabel)*2/5.0,priceSize.height);
    
    self.subBtn.frame = CGRectMake(MaxXF(_priceLabel)+kMinSpace,YF(_priceLabel), HEIGHTF(_priceLabel),  HEIGHTF(_priceLabel));
    
    self.addBtn.frame = CGRectMake(WIDTHF(_bgView)-W_RATIO(20)-HEIGHTF(_subBtn),YF(_subBtn),HEIGHTF(_subBtn),HEIGHTF(_subBtn));
    
    self.amountLabel.frame = CGRectMake(MaxXF(_subBtn)+kMinSpace, YF(_subBtn), XF(_addBtn)-MaxXF(_subBtn)-kMinSpace*2, HEIGHTF(_subBtn));
    
}
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn = selectBtn;
        [self.contentView addSubview:selectBtn];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_kui_gouwuche"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_hong_gouwuche"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(handleCellSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        selectBtn.frame = CGRectMake((W_RATIO(80)-W_RATIO(60))/2.0, W_RATIO(20)+(W_RATIO(260)-W_RATIO(60))/2.0, W_RATIO(60), W_RATIO(60));
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
        bgView.frame = CGRectMake(W_RATIO(80), W_RATIO(20), W_RATIO(650), W_RATIO(260));
        bgView.layer.cornerRadius = W_RATIO(20);
        bgView.layer.masksToBounds = YES;
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
-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        UILabel * subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel = subTitleLabel;
        [self.bgView addSubview:subTitleLabel];
        subTitleLabel.font = FONT(26);
        subTitleLabel.textColor = COLOR_999999;
        subTitleLabel.numberOfLines = 2;
    }
    return _subTitleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel * priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.bgView addSubview:priceLabel];
        priceLabel.adjustsFontSizeToFitWidth = YES;
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
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] init];
        _amountLabel = amountLabel;
        [self.bgView addSubview:amountLabel];
        amountLabel.text = @"1";
        amountLabel.textAlignment = NSTextAlignmentCenter;
        amountLabel.adjustsFontSizeToFitWidth = YES;
        amountLabel.font = FONT(40);
        amountLabel.textColor = COLOR_666666;
    }
    return _amountLabel;
}
-(UIButton *)subBtn{
    if (!_subBtn) {
        UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subBtn = subBtn;
        [self.bgView addSubview:subBtn];
        [subBtn setBackgroundImage:[UIImage imageNamed:@"jian_shenkui_gouwuche"] forState:UIControlStateNormal];
        [subBtn setBackgroundImage:[UIImage imageNamed:@"jian_qiankui_gouwuche"] forState:UIControlStateDisabled];
        subBtn.tag = 0;
        [subBtn addTarget:self action:@selector(handleCellAmountButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn = addBtn;
        [self.bgView addSubview:addBtn];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"jia_shenkui_gouwuche"] forState:UIControlStateNormal];
        addBtn.tag = 1;
        [addBtn addTarget:self action:@selector(handleCellAmountButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(void)handleCellAmountButtonClick:(UIButton*)btn{
    if (self.handleCellAddButtonBlock) {
        self.handleCellAddButtonBlock(btn.tag);
    }
}
@end
