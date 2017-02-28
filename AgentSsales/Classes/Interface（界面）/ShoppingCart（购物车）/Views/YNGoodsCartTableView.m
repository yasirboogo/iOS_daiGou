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
    cartCell.count = self.numArrayM[indexPath.row];
    cartCell.isSelected = [self.selectArrayM[indexPath.row] boolValue];
    cartCell.dict = self.dataArrayM[indexPath.row];
    [cartCell setDidSelectedButtonClickBlock:^(BOOL isSelect) {
        [_selectArrayM replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:isSelect]];
        if (isSelect) {
            self.allCount += [self.numArrayM[indexPath.row] integerValue];
            self.allPrice += [self.numArrayM[indexPath.row] integerValue]*[self.dataArrayM[indexPath.row][@"salesprice"] floatValue];
            [self.goodsIdsArrayM replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%@",self.dataArrayM[indexPath.row][@"shoppingId"]]];
        }else{
            self.allCount -= [self.numArrayM[indexPath.row] integerValue];
            self.allPrice -= [self.numArrayM[indexPath.row] integerValue]*[self.dataArrayM[indexPath.row][@"salesprice"] floatValue];
            [self.goodsIdsArrayM replaceObjectAtIndex:indexPath.row withObject:@"-99"];
        }
        [self reloadData];
    }];
    cartCell.isEnabled = [self.numArrayM[indexPath.row] integerValue] > 1 ? YES:NO;
    [cartCell setHandleCellAddButtonBlock:^(BOOL isSelect,NSInteger lastNum,NSInteger newNum) {
        [self.numArrayM replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%ld",newNum]];
        if (isSelect) {
            self.allCount += newNum-lastNum;
            self.allPrice += (newNum-lastNum)*[self.dataArrayM[indexPath.row][@"salesprice"] floatValue];
        }
        [self reloadData];
    }];
    [cartCell setHandleCellEditButtonBlock:^(BOOL isEdit) {
        if (isEdit) {
            self.allSaveCount +=1;
        }else{
            self.allSaveCount -=1;
        }
        self.handleCellEditButtonBlock(isEdit,indexPath.row);
        [self sendNSNotificationCenterToBalance];
    }];
    [self sendNSNotificationCenterToBalance];
    return cartCell;
}

-(void)sendNSNotificationCenterToBalance{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"priceBalance" object:nil userInfo:
     @{@"allPrice":[NSString stringWithFormat:@"%f",self.allPrice],
       @"allCount":[NSString stringWithFormat:@"%ld",self.allCount],
       @"allSaveCount":[NSString stringWithFormat:@"%ld",self.allSaveCount],
       @"goodsIdsArrayM":self.goodsIdsArrayM}];
}

-(NSMutableArray<NSNumber *> *)selectArrayM{
    if (!_selectArrayM) {
        _selectArrayM = [NSMutableArray array];
        for (NSInteger i = 0; i<_dataArrayM.count; i++) {
            [_selectArrayM addObject:@NO];
        }
    }
    return _selectArrayM;
}
-(NSMutableArray<NSString *> *)numArrayM{
    if (!_numArrayM) {
        _numArrayM = [NSMutableArray array];
        for (NSInteger i = 0; i<_dataArrayM.count; i++) {
            [_numArrayM addObject:[NSString stringWithFormat:@"%@",_dataArrayM[i][@"count"]]];
        }
    }
    return _numArrayM;
}
-(NSMutableArray<NSString *> *)goodsIdsArrayM{
    if (!_goodsIdsArrayM) {
        _goodsIdsArrayM = [NSMutableArray array];
        for (NSInteger i = 0; i<_dataArrayM.count; i++) {
            [_goodsIdsArrayM addObject:@"-99"];
        }
    }
    return _goodsIdsArrayM;
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
@end
@implementation YNGoodsCartCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    
    self.titleLabel.text = dict[@"name"];
    
    self.subTitleLabel.text = dict[@"note"];
    
    self.markLabel.text = @"$";
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@",dict[@"salesprice"]];

    
}
-(void)setCount:(NSString *)count{
    _count = count;
    self.amountTField.text = count;
}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.selectBtn.selected = isSelected;
}
-(void)setIsEnabled:(BOOL)isEnabled{
    _isEnabled = isEnabled;
    self.subBtn.enabled = isEnabled && self.addBtn.enabled;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    不同模式控件布局
    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:XF(self.editBtn)-MaxXF(_leftImgView)-W_RATIO(20)*2 font:_titleLabel.font line:_titleLabel.numberOfLines];
    self.titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(20), W_RATIO(20)*2, titleSize.width,titleSize.height);

    CGSize subTitleSize = [_subTitleLabel.text calculateHightWithWidth:WIDTHF(_titleLabel) font:_subTitleLabel.font line:_subTitleLabel.numberOfLines];
    self.subTitleLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_titleLabel)+kMinSpace, subTitleSize.width,subTitleSize.height);

    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_subTitleLabel),MaxYF(_leftImgView)-markSize.height-W_RATIO(20), markSize.width,markSize.height);
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
    self.priceLabel.frame = CGRectMake(MaxXF(_markLabel),MaxYF(_markLabel)-priceSize.height,WIDTHF(_subTitleLabel)*3/5.0,priceSize.height);
    
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
-(UIButton *)editBtn{
    if (!_editBtn) {
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn = editBtn;
        [self.bgView addSubview:editBtn];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        [editBtn setTitle:@"保存" forState:UIControlStateSelected];
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
        self.handleCellEditButtonBlock(!btn.selected);
    }
    self.addBtn.enabled = btn.selected;
    self.subBtn.enabled = (btn.selected) &&self.isEnabled;
    self.amountTField.enabled = btn.selected;
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
-(UITextField *)amountTField{
    if (!_amountTField) {
        UITextField *amountTField = [[UITextField alloc] init];
        _amountTField = amountTField;
        [self.bgView addSubview:amountTField];
        amountTField.text = @"1";
        amountTField.enabled = NO;
        amountTField.textAlignment = NSTextAlignmentCenter;
        amountTField.keyboardType = UIKeyboardTypeNumberPad;
        amountTField.delegate = self;
        amountTField.adjustsFontSizeToFitWidth = YES;
        amountTField.font = FONT(40);
        amountTField.textColor = COLOR_666666;
    }
    return _amountTField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text integerValue]<=1) {
        textField.text = [NSString stringWithFormat:@"1"];
        self.subBtn.enabled = NO;
    }else if ([textField.text integerValue]>1){
        textField.text = [NSString stringWithFormat:@"%ld",[textField.text integerValue]];
        self.subBtn.enabled = YES;
    }
    if (self.handleCellAddButtonBlock) {
        self.handleCellAddButtonBlock(self.selected,[self.count integerValue],[textField.text integerValue]);
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
    NSInteger num = [self.count integerValue];
    if (btn.tag == 0) {
        num -= 1;
    }else if (btn.tag == 1){
        num += 1;
    }
    if (self.handleCellAddButtonBlock) {
        self.handleCellAddButtonBlock(self.selected,[self.count integerValue],num);
    }
}
@end
