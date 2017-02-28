//
//  YNMineImgHeaderView.m
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNMineImgHeaderView.h"

@interface YNMineImgHeaderView ()

@property (nonatomic,strong) UILabel *topLabel;

@property (nonatomic,strong) UILabel *leftLabel;

@property (nonatomic,strong) UILabel *rightLabel;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation YNMineImgHeaderView


-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, W_RATIO(560));
        
        self.bgImgView.image = [UIImage imageNamed:@"wodefenxiao_beijing"];
    }
    return self;
}
-(void)setTopNumber:(NSString *)topNumber{
    _topNumber = topNumber;
    self.topLabel.text = topNumber;
}
-(void)setLeftNumber:(NSString *)leftNumber{
    _leftNumber = leftNumber;
    self.leftLabel.text = leftNumber;
}
-(void)setRightNumber:(NSString *)rightNumber{
    _rightNumber = rightNumber;
    self.rightLabel.text = rightNumber;
    [self layoutSubviews];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize topTitleSize = [_topTitleLabel.text calculateHightWithWidth:WIDTHF(_bgImgView)-kMidSpace*2 font:_topTitleLabel.font line:_topTitleLabel.numberOfLines];
    self.topTitleLabel.frame = CGRectMake(kMidSpace, kUINavHeight+kMidSpace, topTitleSize.width, topTitleSize.height);
    
    self.topLabel.frame = CGRectMake(XF(_topTitleLabel), MaxYF(_topTitleLabel), WIDTHF(_topTitleLabel),[_topLabel.text calculateHightWithFont:_topLabel.font maxWidth:WIDTHF(_topTitleLabel) ].height);
    
    
    CGSize leftTitleSizeSize = [_leftTitleLabel.text calculateHightWithWidth:WIDTHF(_bgImgView)/2.0-kMidSpace*2 font:_leftTitleLabel.font line:_leftTitleLabel.numberOfLines];
    self.leftTitleLabel.frame = CGRectMake(kMidSpace,MaxYF(self.lineView)+kMinSpace*2, leftTitleSizeSize.width, leftTitleSizeSize.height);
    
    self.leftLabel.frame = CGRectMake(XF(_leftTitleLabel), MaxYF(_leftTitleLabel)+kMinSpace, WIDTHF(_leftTitleLabel),[_leftLabel.text calculateHightWithFont:_leftLabel.font maxWidth:WIDTHF(_leftTitleLabel) ].height);
    
    
    CGSize rightTitleSizeSize = [_rightTitleLabel.text calculateHightWithWidth:leftTitleSizeSize.width font:_rightTitleLabel.font line:_rightTitleLabel.numberOfLines];
    self.rightTitleLabel.frame = CGRectMake(kMidSpace*2+MaxXF(_leftTitleLabel),YF(_leftTitleLabel), rightTitleSizeSize.width, rightTitleSizeSize.height);
    
    self.rightLabel.frame = CGRectMake(XF(_rightTitleLabel), MaxYF(_rightTitleLabel)+kMinSpace, WIDTHF(_rightTitleLabel),[_rightLabel.text calculateHightWithFont:_rightLabel.font maxWidth:WIDTHF(_rightTitleLabel) ].height);
}

-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        UIImageView *bgImgView = [[UIImageView alloc] init];
        _bgImgView = bgImgView;
        [self addSubview:bgImgView];
        bgImgView.frame = self.bounds;
    }
    return _bgImgView;
}

-(UILabel *)topTitleLabel{
    if (!_topTitleLabel) {
        UILabel * topTitleLabel = [[UILabel alloc] init];
        _topTitleLabel = topTitleLabel;
        [self.bgImgView addSubview:topTitleLabel];
        topTitleLabel.textAlignment = NSTextAlignmentCenter;
        topTitleLabel.textColor = COLOR_FFFFFF;
        topTitleLabel.font = FONT(24);
        topTitleLabel.numberOfLines = 2;
        
    }
    return _topTitleLabel;
}

-(UILabel *)leftTitleLabel{
    if (!_leftTitleLabel) {
        UILabel * leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel = leftTitleLabel;
        [_bgImgView addSubview:leftTitleLabel];
        leftTitleLabel.textColor = COLOR_FFFFFF;
        leftTitleLabel.font = FONT(22);
        leftTitleLabel.numberOfLines = 2;
    }
    return _leftTitleLabel;
}
-(UILabel *)rightTitleLabel{
    if (!_rightTitleLabel) {
        UILabel * rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel = rightTitleLabel;
        [_bgImgView addSubview:rightTitleLabel];
        rightTitleLabel.textColor = COLOR_FFFFFF;
        rightTitleLabel.font = FONT(22);
        rightTitleLabel.numberOfLines = 2;
    }
    return _rightTitleLabel;
}
-(UILabel *)topLabel{
    if (!_topLabel) {
        UILabel * topLabel = [[UILabel alloc] init];
        _topLabel = topLabel;
        [_bgImgView addSubview:topLabel];
        topLabel.textAlignment = NSTextAlignmentCenter;
        topLabel.adjustsFontSizeToFitWidth = YES;
        topLabel.textColor = COLOR_FFFFFF;
        topLabel.font = FONT(90);
        topLabel.numberOfLines = 2;
    }
    return _topLabel;
}
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        UILabel * leftLabel = [[UILabel alloc] init];
        _leftLabel = leftLabel;
        [_bgImgView addSubview:leftLabel];
        leftLabel.adjustsFontSizeToFitWidth = YES;
        leftLabel.textColor = COLOR_FFFFFF;
        leftLabel.font = FONT(56);
        leftLabel.numberOfLines = 2;
    }
    return _leftLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        UILabel * rightLabel = [[UILabel alloc] init];
        _rightLabel = rightLabel;
        [_bgImgView addSubview:rightLabel];
        rightLabel.adjustsFontSizeToFitWidth = YES;
        rightLabel.textColor = COLOR_FFFFFF;
        rightLabel.font = FONT(56);
        rightLabel.numberOfLines = 2;
    }
    return _rightLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        UIView *lineView = [[UIView alloc] init];
        _lineView = lineView;
        [_bgImgView addSubview:lineView];
        lineView.backgroundColor = COLOR_EF697B;
        lineView.frame = CGRectMake(0, HEIGHTF(_bgImgView)-W_RATIO(158), WIDTHF(_bgImgView), W_RATIO(1));
    }
    return _lineView;
}

@end

