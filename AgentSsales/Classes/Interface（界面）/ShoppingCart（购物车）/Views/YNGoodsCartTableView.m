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
        self.bounces = NO;
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = COLOR_EDEDED;
        footerView.frame = CGRectMake(0, 0, WIDTHF(self), kMinSpace);
        self.tableFooterView = footerView;
    }
    return self;
}
-(void)setShoppingCartListModel:(YNShoppingCartListModel *)shoppingCartListModel{
    _shoppingCartListModel = shoppingCartListModel;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shoppingCartListModel.shoppingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNGoodsCartCell * cartCell = [tableView dequeueReusableCellWithIdentifier:@"cartCell"];
    if (cartCell == nil) {
        cartCell = [[YNGoodsCartCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cartCell"];
        cartCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cartCell.backgroundColor = COLOR_EDEDED;
    }
    YNShoppingCartGoodsModel *shoppingCartGoodsModel = _shoppingCartListModel.shoppingArray[indexPath.row];
    cartCell.shoppingCartGoodsModel = shoppingCartGoodsModel;
    [cartCell setDidSelectedButtonClickBlock:^(BOOL isSelected) {
        CGFloat salesprice = [[NSString decimalNumberWithDouble:shoppingCartGoodsModel.salesprice] floatValue];
        if (isSelected) {
            //加数量，加价格
            _shoppingCartListModel.allCount += shoppingCartGoodsModel.count;
            _shoppingCartListModel.allPrice += shoppingCartGoodsModel.count * salesprice;
        }else{
            //减数量，减价格
            _shoppingCartListModel.allCount -= shoppingCartGoodsModel.count;
            _shoppingCartListModel.allPrice -= shoppingCartGoodsModel.count * salesprice;
        }
        YNShoppingCartGoodsModel *shoppingCartGoodsModel = _shoppingCartListModel.shoppingArray[indexPath.row];
        shoppingCartGoodsModel.selected = isSelected;
        [self.shoppingCartListModel.shoppingArray replaceObjectAtIndex:indexPath.row withObject:shoppingCartGoodsModel];
        
        [self sendNotificationCenterPriceAndCount];
        [self reloadData];
    }];
    [cartCell setHandleCellEditButtonBlock:^(BOOL isEditing) {
        YNShoppingCartGoodsModel *shoppingCartGoodsModel = _shoppingCartListModel.shoppingArray[indexPath.row];
        shoppingCartGoodsModel.editing = isEditing;
        if (!isEditing) {
            self.shoppingCartListModel.editingCount -= 1;
            self.handleCellEditButtonBlock(indexPath.row);
        }else{
            self.shoppingCartListModel.editingCount += 1;
        }
        [self sendNotificationCenterPriceAndCount];
        [self reloadData];
    }];
    [cartCell setHandleCellAddButtonBlock:^(NSInteger afterNum) {
        YNShoppingCartGoodsModel *shoppingCartGoodsModel = _shoppingCartListModel.shoppingArray[indexPath.row];
        if (shoppingCartGoodsModel.selected) {
            CGFloat salesprice = [[NSString decimalNumberWithDouble:shoppingCartGoodsModel.salesprice] floatValue];

            //加数量，加价格
            _shoppingCartListModel.allCount += afterNum - shoppingCartGoodsModel.count;
            _shoppingCartListModel.allPrice += (afterNum - shoppingCartGoodsModel.count) * salesprice;
        }
        shoppingCartGoodsModel.count = afterNum;
        [self sendNotificationCenterPriceAndCount];
        [self reloadData];
    }];
    [cartCell setDidSelectedGoodsCellBlock:^{
        if (self.didSelectCellBlock && shoppingCartGoodsModel.goodsId) {
            self.didSelectCellBlock(shoppingCartGoodsModel.goodsId);
        }
    }];
    return cartCell;
}
-(void)sendNotificationCenterPriceAndCount{
    NSMutableString *shoppingIds = [NSMutableString string];
    NSInteger isUnableCount = 0;
    for (YNShoppingCartGoodsModel *shoppingCartGoodsModel in _shoppingCartListModel.shoppingArray) {
        if (shoppingCartGoodsModel.selected) {
            [shoppingIds appendFormat:@",%ld",shoppingCartGoodsModel.shoppingId];
            BOOL isUnAble = shoppingCartGoodsModel.isdelete || (shoppingCartGoodsModel.count>shoppingCartGoodsModel.stock&&shoppingCartGoodsModel.goodsId);
            if (isUnAble) {
                isUnableCount += 1;
            }
        }
    }
    if (shoppingIds.length) {
        [shoppingIds deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"priceAndCount" object:nil userInfo:
     @{@"allPrice":[NSString stringWithFormat:@"%f",_shoppingCartListModel.allPrice],
       @"allCount":[NSString stringWithFormat:@"%ld",_shoppingCartListModel.allCount],
       @"isEditing":[NSNumber numberWithBool:_shoppingCartListModel.editingCount],
       @"isUnAble":[NSNumber numberWithBool:isUnableCount],
       @"shoppingIds":shoppingIds}];
}
@end
@interface YNGoodsCartCell ()<UITextFieldDelegate>
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
@property (nonatomic,weak) UITextField * amountTField;
/** 减按钮 */
@property (nonatomic,weak) UIButton * subBtn;
/** 加按钮 */
@property (nonatomic,weak) UIButton * addBtn;
/** 编辑按钮 */
@property (nonatomic,weak) UIButton * editBtn;
/** 是否下架/不足 */
@property (nonatomic,weak) UILabel * msgLabel;
@end
@implementation YNGoodsCartCell

-(void)setShoppingCartGoodsModel:(YNShoppingCartGoodsModel *)shoppingCartGoodsModel{
    _shoppingCartGoodsModel = shoppingCartGoodsModel;
    [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:shoppingCartGoodsModel.img] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    
    self.titleLabel.text = shoppingCartGoodsModel.name;
    
    if (shoppingCartGoodsModel.note) {
        self.subTitleLabel.text = shoppingCartGoodsModel.note;
    }else{
        self.subTitleLabel.text = LocalNothing;
    }
    
    self.markLabel.text = LocalMoneyMark;
    
    self.priceLabel.text = [NSString decimalNumberWithDouble:shoppingCartGoodsModel.salesprice] ;
    
    self.amountTField.text = [NSString stringWithFormat:@"%ld",shoppingCartGoodsModel.count];
    
    self.selectBtn.selected = shoppingCartGoodsModel.selected;
    
    self.editBtn.selected = shoppingCartGoodsModel.editing ;
    
    self.addBtn.enabled = shoppingCartGoodsModel.editing;
    
    self.subBtn.enabled = (shoppingCartGoodsModel.editing) && shoppingCartGoodsModel.count > 1;
    
    self.amountTField.enabled = shoppingCartGoodsModel.editing;
    if (shoppingCartGoodsModel.isdelete) {
        self.msgLabel.text = LocalShelf;
    }else if (shoppingCartGoodsModel.count>shoppingCartGoodsModel.stock&&shoppingCartGoodsModel.goodsId){
        self.msgLabel.text = LocalStock;
    }else{
        self.msgLabel.text = @"";
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    不同模式控件布局
    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:XF(self.editBtn)-MaxXF(_leftImgView)-W_RATIO(20)*2 font:_titleLabel.font line:_titleLabel.numberOfLines];
    self.titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(20), W_RATIO(20)*2, titleSize.width,titleSize.height);
    
    CGSize subTitleSize = [_subTitleLabel.text calculateHightWithWidth:WIDTHF(_titleLabel) font:_subTitleLabel.font line:_subTitleLabel.numberOfLines];
    self.subTitleLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_titleLabel)+kMinSpace, subTitleSize.width,subTitleSize.height);
    
    self.msgLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_subTitleLabel)+kMinSpace, subTitleSize.width+WIDTHF(self.editBtn),subTitleSize.height);
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_subTitleLabel),MaxYF(_leftImgView)-markSize.height-W_RATIO(20), markSize.width,markSize.height);
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
    self.priceLabel.frame = CGRectMake(MaxXF(_markLabel),MaxYF(_markLabel)-priceSize.height,WIDTHF(_titleLabel)*3/6.0,priceSize.height);
    
    self.subBtn.frame = CGRectMake(MaxXF(_priceLabel)+kMinSpace,YF(_priceLabel), HEIGHTF(_priceLabel),  HEIGHTF(_priceLabel));
    
    self.addBtn.frame = CGRectMake(WIDTHF(_bgView)-W_RATIO(20)-HEIGHTF(_subBtn),YF(_subBtn),HEIGHTF(_subBtn),HEIGHTF(_subBtn));
    
    self.amountTField.frame = CGRectMake(MaxXF(_subBtn)+kMinSpace, YF(_subBtn), XF(_addBtn)-MaxXF(_subBtn)-kMinSpace*2, HEIGHTF(_subBtn));
    
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
        bgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSelectGoodsCell)];
        [bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
-(void)handleSelectGoodsCell{
    if (self.didSelectedGoodsCellBlock) {
        self.didSelectedGoodsCellBlock();
    }
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
-(UIButton *)editBtn{
    if (!_editBtn) {
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn = editBtn;
        [self.bgView addSubview:editBtn];
        [editBtn setTitle:LocalEdit forState:UIControlStateNormal];
        [editBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        [editBtn setTitle:LocalSave forState:UIControlStateSelected];
        [editBtn setTitleColor:COLOR_666666 forState:UIControlStateSelected];
        editBtn.titleLabel.font = FONT(30);
        [editBtn addTarget:self action:@selector(handleCellEditButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        editBtn.frame = CGRectMake(WIDTHF(_bgView)-W_RATIO(100), W_RATIO(20)*2, W_RATIO(100) ,W_RATIO(40));
    }
    return _editBtn;
}
-(void)handleCellEditButtonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (self.handleCellEditButtonBlock) {
        self.handleCellEditButtonBlock(btn.selected);
    }
}
-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        UILabel * subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel = subTitleLabel;
        [self.bgView addSubview:subTitleLabel];
        subTitleLabel.font = FONT(28);
        subTitleLabel.textColor = COLOR_999999;
        subTitleLabel.numberOfLines = 1;
        
    }
    return _subTitleLabel;
}
-(UILabel *)msgLabel{
    if (!_msgLabel) {
        UILabel *msgLabel = [[UILabel alloc] init];
        _msgLabel = msgLabel;
        [self.bgView addSubview:msgLabel];
        msgLabel.font = FONT(26);
        msgLabel.textAlignment = NSTextAlignmentRight;
        msgLabel.textColor = COLOR_FF4844;
        msgLabel.numberOfLines = 1;
    }
    return _msgLabel;
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
-(UITextField *)amountTField{
    if (!_amountTField) {
        UITextField *amountTField = [[UITextField alloc] init];
        _amountTField = amountTField;
        [self.bgView addSubview:amountTField];
        amountTField.text = @"1";
        amountTField.enabled = NO;
        amountTField.textAlignment = NSTextAlignmentCenter;
        amountTField.keyboardType = UIKeyboardTypeNumberPad;
        //amountTField.delegate = self;
        amountTField.adjustsFontSizeToFitWidth = YES;
        amountTField.font = FONT(40);
        amountTField.textColor = COLOR_666666;
        [amountTField addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _amountTField;
}
- (void)textfieldTextDidChange:(UITextField *)textField
{
    if ([textField.text integerValue]<=1) {
        textField.text = [NSString stringWithFormat:@"1"];
        self.subBtn.enabled = NO;
    }else if ([textField.text integerValue]>1){
        textField.text = [NSString stringWithFormat:@"%d",[textField.text integerValue]];
        self.subBtn.enabled = YES;
    }
    if (self.handleCellAddButtonBlock) {
        self.handleCellAddButtonBlock([textField.text integerValue]);
    }
}
-(UIButton *)subBtn{
    if (!_subBtn) {
        UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subBtn = subBtn;
        [self.bgView addSubview:subBtn];
        subBtn.enabled = NO;
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
        addBtn.enabled = NO;
        [addBtn setBackgroundImage:[UIImage imageNamed:@"jia_shenkui_gouwuche"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"jian_qiankui_gouwuche"] forState:UIControlStateDisabled];
        addBtn.tag = 1;
        [addBtn addTarget:self action:@selector(handleCellAmountButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(void)handleCellAmountButtonClick:(UIButton*)btn{
    NSInteger num = _shoppingCartGoodsModel.count;
    if (btn.tag == 0) {
        num -= 1;
    }else if (btn.tag == 1){
        num += 1;
    }
    if (self.handleCellAddButtonBlock) {
        self.handleCellAddButtonBlock(num);
    }
}
@end
