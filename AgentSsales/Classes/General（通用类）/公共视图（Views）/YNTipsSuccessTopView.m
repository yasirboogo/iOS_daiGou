//
//  YNTipsSuccessTopView.m
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNTipsSuccessTopView.h"

@interface YNTipsSuccessTopView ()

@property (nonatomic,weak) UIImageView * bgImgView;

@end

@implementation YNTipsSuccessTopView

-(instancetype)init{
    CGRect frame = CGRectMake(W_RATIO(20),kUINavHeight+W_RATIO(20), SCREEN_WIDTH-W_RATIO(20)*2, W_RATIO(350));
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImgView.image = [UIImage imageNamed:@"chenggongbeijing"];
    }
    return self;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.tipsImgView.image = [UIImage imageNamed:dict[@"image"]];
    self.tipsLabel.text = dict[@"tips"];
}
-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        UIImageView *bgImgView = [[UIImageView alloc] init];
        _bgImgView = bgImgView;
        [self addSubview:bgImgView];
        bgImgView.frame = self.bounds;
        bgImgView.layer.masksToBounds = YES;
        bgImgView.layer.cornerRadius = W_RATIO(20);
    }
    return _bgImgView;
}
-(UIImageView *)tipsImgView{
    if (!_tipsImgView) {
        UIImageView *tipsImgView =[[UIImageView alloc] init];
        _tipsImgView = tipsImgView;
        [_bgImgView addSubview:tipsImgView];
        tipsImgView.frame = CGRectMake((WIDTHF(self)-W_RATIO(150))/2.0, kMaxSpace, W_RATIO(150), W_RATIO(120));
    }
    return _tipsImgView;
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [_bgImgView addSubview:tipsLabel];
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.font = FONT(42);
        tipsLabel.numberOfLines = 2;
        tipsLabel.textColor = COLOR_FFFFFF;
    }
    return _tipsLabel;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize tipsSize = [_tipsLabel.text calculateHightWithWidth:WIDTHF(self)-kMidSpace*2 font:_tipsLabel.font line:_tipsLabel.numberOfLines];
    self.tipsLabel.frame = CGRectMake(kMidSpace,kMidSpace+MaxYF(_tipsImgView), tipsSize.width, tipsSize.height);
}
@end
