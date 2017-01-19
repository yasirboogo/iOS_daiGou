//
//  YNTipsPerfectInforView.m
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNTipsPerfectInforView.h"

@interface YNTipsPerfectInforView ()

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UIImageView *showImgView;

@property (nonatomic, strong) UILabel *showLabel;

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation YNTipsPerfectInforView

-(instancetype)initWithFrame:(CGRect)frame img:(UIImage*)img title:(NSString*)title tips:(NSString*)tips btnTitle:(NSString*)btnTitle{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
        self.layer.cornerRadius = W_RATIO(20);
        self.showImgView.image = img;
        self.showLabel.text = title;
        CGSize titleSize = [_showLabel.text calculateHightWithFont:_showLabel.font maxWidth:0];
        self.showLabel.frame = CGRectMake(kMaxSpace, MaxYF(_showImgView)+W_RATIO(20),WIDTHF(self)-kMaxSpace*2, titleSize.height);
        
        self.tipsLabel.text = tips;
        CGSize tipsSize = [_tipsLabel.text calculateHightWithWidth:WIDTHF(self)-kMidSpace*2 font:_tipsLabel.font];
        self.tipsLabel.frame = CGRectMake(kMidSpace, MaxYF(_showLabel)+W_RATIO(20),tipsSize.width, tipsSize.height);
        
        [self.submitBtn setTitle:btnTitle forState:UIControlStateNormal];
        [self cancelBtn];
        
        self.frame =CGRectMake(X(frame),(SCREEN_HEIGHT-MaxYF(_submitBtn))/2.0, WIDTH(frame), MaxYF(_submitBtn));
    }
    return self;
}

- (void)showPopView:(BOOL)animated
{
    [self.baseView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.baseView];
    
    if (!animated) {
        return;
    }
    
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.alpha = 0.f;
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}
- (void)dismissPopView:(BOOL)animated
{
    if (!animated) {
        [self.baseView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.baseView removeFromSuperview];
    }];
}
-(UIView *)baseView{
    if (!_baseView) {
        UIView *baseView = [[UIView alloc] init];
        _baseView = baseView;
        [baseView setFrame:[UIScreen mainScreen].bounds];
        [baseView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [baseView setUserInteractionEnabled:YES];
        
    }
    return _baseView;
}
-(void)setIsTapGesture:(BOOL)isTapGesture{
    _isTapGesture = isTapGesture;
    if (isTapGesture) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureClick:)];
        [self.baseView addGestureRecognizer:tapGesture];
    }
}

- (void)handleTapGestureClick:(UITapGestureRecognizer *)tap
{
    [self dismissPopView:YES];
}
-(UIImageView *)showImgView{
    if (!_showImgView) {
        UIImageView *showImgView = [[UIImageView alloc] init];
        _showImgView = showImgView;
        [self addSubview:showImgView];
        showImgView.frame = CGRectMake((WIDTHF(self)-W_RATIO(200))/2.0, kMaxSpace, W_RATIO(200), W_RATIO(180));
        
    }
    return _showImgView;
}
-(UILabel *)showLabel{
    if (!_showLabel) {
        UILabel *showLabel = [[UILabel alloc] init];
        _showLabel = showLabel;
        [self addSubview:showLabel];
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.font = FONT(38);
        showLabel.textColor = COLOR_333333;
    }
    return _showLabel;
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.numberOfLines = 0;
        tipsLabel.font = FONT(26);
        tipsLabel.textColor = COLOR_999999;
    }
    return _tipsLabel;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        [self addSubview:submitBtn];
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.frame = CGRectMake(0, MaxYF(_tipsLabel)+W_RATIO(20), WIDTHF(self), W_RATIO(100));
        [submitBtn setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft |UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    }
    return _submitBtn;
}
-(void)handleSubmitButtonClick:(UIButton*)btn{
    [self dismissPopView:YES];
    if(self.didSelectSubmitButtonBlock){
        self.didSelectSubmitButtonBlock();
    }
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn = cancelBtn;
        [self addSubview:cancelBtn];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"guanbi_tankuang"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(handleCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(WIDTHF(self)-W_RATIO(30),-W_RATIO(30), W_RATIO(60), W_RATIO(60));
    }
    return _cancelBtn;
}
-(void)handleCancelButtonClick:(UIButton*)btn{
    [self dismissPopView:YES];
}

@end
