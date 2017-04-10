//
//  YNGoodsDetailBtnsView.m
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsDetailBtnsView.h"

@interface YNGoodsDetailBtnsView ()

@property (nonatomic,strong) UILabel * priceLabel;

@property (nonatomic,strong) UILabel * markLabel;

@property (nonatomic,strong) UIButton * addBtn;

@property (nonatomic,strong) UIButton * buyBtn;

@end

@implementation YNGoodsDetailBtnsView

-(void)layoutSubviews{
    CGSize buySize = [self.buyBtn.titleLabel.text calculateHightWithFont:_buyBtn.titleLabel.font maxWidth:SCREEN_WIDTH/3.0];
    self.buyBtn.frame = CGRectMake(WIDTHF(self)-W_RATIO(20)-(buySize.width+kMidSpace), (HEIGHTF(self)-W_RATIO(66))/2.0, buySize.width+kMidSpace, W_RATIO(66));
    
    CGSize addSize = [self.addBtn.titleLabel.text calculateHightWithFont:_addBtn.titleLabel.font maxWidth:SCREEN_WIDTH/3.0];
    self.addBtn.frame = CGRectMake(XF(_buyBtn)-W_RATIO(20)-(addSize.width+kMidSpace),YF(_buyBtn), addSize.width+kMidSpace,HEIGHTF(_buyBtn));
    
    CGSize markSize = [self.markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    
    CGSize priceSize = [self.priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:XF(_addBtn)-(kMidSpace+markSize.width)];
    self.priceLabel.frame = CGRectMake(kMidSpace+markSize.width,(HEIGHTF(self)-priceSize.height)/2.0, priceSize.width, priceSize.height);
    
    self.markLabel.frame = CGRectMake(kMidSpace,MaxYF(_priceLabel)-markSize.height, markSize.width, markSize.height);
}
-(void)setPrice:(NSString *)price{
    _price = price;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",[price floatValue]];
    [self layoutSubviews];
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.priceLabel.text = [NSString decimalNumberWithDouble:dict[@"salesprice"]];
    BOOL unEnable = [dict[@"isdelete"] integerValue] || [dict[@"stock"] integerValue]<1;
    self.buyBtn.enabled = !unEnable;
    self.addBtn.enabled = !unEnable;
    if (unEnable) {
        self.buyBtn.backgroundColor = COLOR_999999;
        self.addBtn.backgroundColor = COLOR_999999;
    }else{
        self.addBtn.layer.borderColor = COLOR_DF463E.CGColor;
        self.addBtn.layer.borderWidth = kOutLine;
        self.buyBtn.backgroundColor = COLOR_DF463E;
    }
    [self layoutSubviews];
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self addSubview:markLabel];
        markLabel.text = LocalMoneyMark;
        markLabel.textColor = COLOR_DF463E;
        markLabel.font = FONT(26);
    }
    return _markLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self addSubview:priceLabel];
        priceLabel.textColor = COLOR_DF463E;
        priceLabel.font = FONT(40);
    }
    return _priceLabel;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn = addBtn;
        [self addSubview:addBtn];
        addBtn.titleLabel.font = FONT(30);
        [addBtn setTitle:LocalJoinCart forState:UIControlStateNormal];
        [addBtn setTitleColor:COLOR_DF463E forState:UIControlStateNormal];
        [addBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateDisabled];
        [addBtn addTarget:self action:@selector(handleAddCartButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(void)handleAddCartButtonClick:(UIButton*)btn{
    if (self.didSelectAddCartButtonClickBlock) {
        self.didSelectAddCartButtonClickBlock();
    }
}
-(UIButton *)buyBtn{
    if (!_buyBtn) {
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn = buyBtn;
        [self addSubview:buyBtn];
        buyBtn.titleLabel.font = FONT(30);
        [buyBtn setTitle:LocalNowBuy forState:UIControlStateNormal];
        [buyBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [buyBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateDisabled];
        [buyBtn addTarget:self action:@selector(handlebuyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}
-(void)handlebuyButtonClick:(UIButton*)btn{
    if (self.didSelectBuyButtonClickBlock) {
        self.didSelectBuyButtonClickBlock();
    }
}
@end
