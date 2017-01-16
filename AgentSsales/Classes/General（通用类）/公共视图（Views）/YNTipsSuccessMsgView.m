//
//  YNTipsSuccessMsgView.m
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNTipsSuccessMsgView.h"

@interface YNTipsSuccessMsgView ()

@property (nonatomic,weak) UILabel * titleLabel;

@property (nonatomic,weak) UILabel * msgLabel;

@end

@implementation YNTipsSuccessMsgView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = W_RATIO(20);
        self.backgroundColor = COLOR_FFFFFF;
    }
    return self;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.titleLabel.text = dict[@"title"];
    self.msgLabel.attributedText = dict[@"msg"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize titleSize =[_titleLabel.text calculateHightWithWidth:SCREEN_WIDTH-W_RATIO(20)*2-kMidSpace*2 font:_titleLabel.font line:_titleLabel.numberOfLines];
    
    self.titleLabel.frame = CGRectMake(kMidSpace,kMidSpace, titleSize.width, titleSize.height);
    
    self.msgLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_titleLabel)+kMinSpace*2, WIDTHF(_titleLabel),self.msgSize.height);
    
    self.frame = CGRectMake(W_RATIO(20), kUINavHeight+W_RATIO(20)+W_RATIO(350), WIDTHF(_titleLabel)+kMidSpace*2, MaxYF(_msgLabel)+kMidSpace);
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel =[[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self addSubview:titleLabel];
        titleLabel.font = FONT(38);
        titleLabel.numberOfLines = 2;
        titleLabel.textColor = COLOR_333333;
        titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}
-(UILabel *)msgLabel{
    if (!_msgLabel) {
        UILabel *msgLabel =[[UILabel alloc] init];
        _msgLabel = msgLabel;
        [self addSubview:msgLabel];
        msgLabel.font = FONT(28);
        msgLabel.numberOfLines = 0;
        msgLabel.textColor = COLOR_666666;
    }
    return _msgLabel;
}
@end
