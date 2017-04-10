//
//  YNCodeImgView.m
//  AgentSsales
//
//  Created by innofive on 17/2/22.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNCodeImgView.h"

@interface YNCodeImgView ()

@property (nonatomic,weak) UIImageView * codeImgView;

@property (nonatomic,weak) UILabel * tipsLabel;

@property (nonatomic,weak) UIButton * shareCodeBtn;
@end

@implementation YNCodeImgView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
        self.frame = CGRectMake((SCREEN_WIDTH-W_RATIO(480))/2.0,kUINavHeight+W_RATIO(200), W_RATIO(480), MaxYF(self.shareCodeBtn));
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = kViewRadius;
    }
    return self;
}
-(void)setCodeImg:(UIImage *)codeImg{
    _codeImg = codeImg;
    self.codeImgView.image = codeImg;
}
-(UIImageView *)codeImgView{
    if (!_codeImgView) {
        UIImageView *codeImgView = [[UIImageView alloc] init];
        _codeImgView = codeImgView;
        [self addSubview:codeImgView];
        codeImgView.backgroundColor = COLOR_DF463E;
        codeImgView.frame = CGRectMake(kMidSpace,kMidSpace, W_RATIO(400), W_RATIO(400));
    }
    return _codeImgView;
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        tipsLabel.text = LocalSharetips;
        tipsLabel.numberOfLines = 0;
        tipsLabel.font = FONT(26);
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.textColor = COLOR_999999;
        CGSize tipsSize = [tipsLabel.text calculateHightWithWidth:WIDTHF(self.codeImgView) font:tipsLabel.font];
        tipsLabel.frame = CGRectMake(XF(_codeImgView),MaxYF(_codeImgView)+W_RATIO(20), tipsSize.width, tipsSize.height);
    }
    return _tipsLabel;
}
-(UIButton *)shareCodeBtn{
    if (!_shareCodeBtn) {
        UIButton *shareCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareCodeBtn = shareCodeBtn;
        [self addSubview:shareCodeBtn];
        shareCodeBtn.backgroundColor = COLOR_DF463E;
        shareCodeBtn.titleLabel.font = FONT(30);
        [shareCodeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -W_RATIO(20), 0, 0)];
        [shareCodeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -W_RATIO(20))];
        [shareCodeBtn setImage:[UIImage imageNamed:@"fenxiang_wode"] forState:UIControlStateNormal];
        [shareCodeBtn setTitle:LocalShareCode forState:UIControlStateNormal];
        [shareCodeBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [shareCodeBtn addTarget:self action:@selector(handleShareCodeButton) forControlEvents:UIControlEventTouchUpInside];
        shareCodeBtn.frame = CGRectMake(0, MaxYF(self.tipsLabel)+W_RATIO(20), W_RATIO(480), W_RATIO(100));
    }
    return _shareCodeBtn;
}
-(void)handleShareCodeButton{
    if (self.didSelectShareCodeImgButtonBlock) {
        self.didSelectShareCodeImgButtonBlock();
    }
}
@end
