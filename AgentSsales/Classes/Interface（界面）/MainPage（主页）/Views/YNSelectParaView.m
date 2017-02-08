//
//  YNSelectParaView.m
//  AgentSsales
//
//  Created by innofive on 17/2/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSelectParaView.h"


@interface YNSelectParaView ()

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation YNSelectParaView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
        [self addSubview:self.cancelBtn];
        [self addSubview:self.scrollView];
        [self addSubview:self.submitBtn];
    }
    return self;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel * nameLabel = [[UILabel alloc] init];
        [self.scrollView addSubview:nameLabel];
        nameLabel.text = @"选择容量";
        nameLabel.textColor = COLOR_999999;
        nameLabel.font = FONT(26);
        nameLabel.frame = CGRectMake(kMidSpace,kMidSpace*3*i, WIDTHF(self)-kMidSpace*2,kMidSpace);
        
        
        for (NSInteger j = 0; j < 4; j ++) {
            UILabel * itemLabel = [[UILabel alloc] init];
            [self.scrollView addSubview:itemLabel];
            itemLabel.layer.borderWidth = W_RATIO(1);
            itemLabel.layer.borderColor = COLOR_CECECE.CGColor;
            itemLabel.text = @"5L";
            itemLabel.textColor = COLOR_999999;
            itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.font = FONT(30);
            itemLabel.frame = CGRectMake(kMidSpace+j*(W_RATIO(152)+W_RATIO(20)),MaxYF(nameLabel)+kMinSpace, W_RATIO(152),W_RATIO(58));
        }
    }
    
    
}
- (void)showPopView:(BOOL)animated
{
    [self.baseView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.baseView];
    
    if (!animated) {
        return;
    }
    
    self.transform = CGAffineTransformMakeScale(1.0f, 0.1f);
    self.alpha = 0.f;
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.0f, 1.25f);
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
        self.transform = CGAffineTransformMakeScale(1.0f, 0.1f);
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
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        _scrollView = scrollView;
        [self addSubview:scrollView];
        scrollView.frame = CGRectMake(0,MaxYF(_cancelBtn), WIDTHF(self), HEIGHTF(self)-HEIGHTF(self.submitBtn)-MaxYF(_cancelBtn));
        scrollView.contentSize = scrollView.frame.size;
    }
    return _scrollView;
}

-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        [self addSubview:submitBtn];
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [self.submitBtn setTitle:@"完成" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.frame = CGRectMake(0,HEIGHTF(self)-W_RATIO(100), WIDTHF(self), W_RATIO(100));
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
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"guanbi_xuanguige"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(handleCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(WIDTHF(self)-W_RATIO(80),W_RATIO(80)-W_RATIO(50), W_RATIO(50), W_RATIO(50));
    }
    return _cancelBtn;
}
-(void)handleCancelButtonClick:(UIButton*)btn{
    [self dismissPopView:YES];
}


@end
