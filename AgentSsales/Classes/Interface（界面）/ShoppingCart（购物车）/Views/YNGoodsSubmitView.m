//
//  YNGoodsSubmitView.m
//  AgentSsales
//
//  Created by innofive on 17/1/18.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsSubmitView.h"

@interface YNGoodsSubmitView ()

@property (nonatomic,weak) UILabel * tipsLabel;

@property (nonatomic,weak) UILabel * markLabel;

@property (nonatomic,weak) UILabel * priceLabel;

@property (nonatomic,weak) UIButton * submitBtn;

@end

@implementation YNGoodsSubmitView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
    }
    return self;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.tipsLabel.text = @"总计(不含邮费):";
    self.markLabel.text = @"￥";
    self.priceLabel.text = dict[@"allPrice"];
    [self.submitBtn setTitle:[NSString stringWithFormat:@"结算(%d)",[dict[@"allNum"] intValue]] forState:UIControlStateNormal];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize tipsSize =[_tipsLabel.text calculateHightWithFont:_tipsLabel.font maxWidth:WIDTHF(self)/3.0];
    self.tipsLabel.frame = CGRectMake(W_RATIO(20),(HEIGHTF(self)-tipsSize.height)/2.0, tipsSize.width, tipsSize.height);
    
    CGSize markSize =[_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(MaxXF(_tipsLabel)+kMinSpace,MaxYF(_tipsLabel)-markSize.height, markSize.width, markSize.height);
    
    CGSize priceSize =[_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:XF(_submitBtn)-MaxXF(_markLabel)-kMinSpace];
    self.priceLabel.frame = CGRectMake(MaxXF(_markLabel),MaxYF(_markLabel)-priceSize.height, XF(_submitBtn)-MaxXF(_markLabel)-kMinSpace, priceSize.height);
}

-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        tipsLabel.font = FONT(24);
        tipsLabel.textColor = COLOR_333333;
    }
    return _tipsLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self addSubview:markLabel];
        markLabel.font = FONT(24);
        markLabel.textColor = COLOR_DF463E;
    }
    return _markLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self addSubview:priceLabel];
        priceLabel.font = FONT(38);
        priceLabel.textColor = COLOR_DF463E;
    }
    return _priceLabel;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        [self addSubview:submitBtn];
        submitBtn.backgroundColor = COLOR_DF463E;
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal|UIControlStateDisabled];
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn addTarget:self action:@selector(handleSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.frame = CGRectMake(WIDTHF(self)-W_RATIO(240), 0, W_RATIO(240), HEIGHTF(self));
    }
    return _submitBtn;
}
-(void)handleSubmitButtonClick:(UIButton*)btn{
    if (self.handleSubmitButtonBlock) {
        self.handleSubmitButtonBlock();
    }
}

@end
