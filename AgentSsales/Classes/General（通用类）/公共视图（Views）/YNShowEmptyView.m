//
//  YNShowEmptyView.m
//  AgentSsales
//
//  Created by innofive on 17/1/11.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNShowEmptyView.h"

@interface YNShowEmptyView ()

@property (nonatomic,weak) UIImageView * tipsImgView;

@property (nonatomic,weak) UILabel * tipsLabel;

@end

@implementation YNShowEmptyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
        self.hidden = YES;
    }
    return self;
}
-(void)setTipImg:(UIImage *)tipImg{
    _tipImg = tipImg;
    self.tipsImgView.image = tipImg;
}
-(void)setTips:(NSString *)tips{
    _tips = tips;
    self.tipsLabel.text = tips;
    
    CGSize tipsSize = [_tipsLabel.text calculateHightWithWidth:WIDTHF(self)-kMaxSpace*2 font:_tipsLabel.font];
    self.tipsLabel.frame = CGRectMake(kMaxSpace, MaxYF(_tipsImgView)+kMidSpace,tipsSize.width, tipsSize.height);
}
-(UIImageView *)tipsImgView{
    if (!_tipsImgView) {
        UIImageView *tipsImgView = [[UIImageView alloc] init];
        _tipsImgView = tipsImgView;
        [self addSubview:tipsImgView];

        tipsImgView.frame = CGRectMake(WIDTHF(self)/3.0,HEIGHTF(self)/4.0, WIDTHF(self)/3.0, WIDTHF(self)/3.0);
        [self addSubview:tipsImgView];
    }
    return _tipsImgView;
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        tipsLabel.font = FONT(38);
        tipsLabel.textColor = COLOR_999999;
        tipsLabel.numberOfLines = 0;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tipsLabel];
    }
    return _tipsLabel;
}

@end
