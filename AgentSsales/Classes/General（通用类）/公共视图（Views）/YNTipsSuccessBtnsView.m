//
//  YNTipsSuccessBtnsView.m
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNTipsSuccessBtnsView.h"

@implementation YNTipsSuccessBtnsView

-(void)setIsEnable:(BOOL)isEnable{
    _isEnable = isEnable;
    for (UIButton *btn in self.subviews) {
        btn.userInteractionEnabled = isEnable;
    }
}

-(void)setBtnTitles:(NSArray<NSString *> *)btnTitles{
    _btnTitles = btnTitles;
    
    CGFloat height = _btnTitles.count*(W_RATIO(100)+W_RATIO(20))-W_RATIO(20)+kMidSpace*2;
    self.frame = CGRectMake(W_RATIO(20), SCREEN_HEIGHT-height, SCREEN_WIDTH-W_RATIO(20)*2, height);
    
    [btnTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 按钮创建
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomBtn setTitle:title forState:UIControlStateNormal];
        bottomBtn.titleLabel.font = FONT(36);
        bottomBtn.tag = idx;
        bottomBtn.layer.borderWidth = kOutLine;
        bottomBtn.layer.cornerRadius = kViewRadius;
        bottomBtn.layer.masksToBounds = YES;
        [bottomBtn addTarget:self action:@selector(handleBottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bottomBtn];
        bottomBtn.frame = CGRectMake(0, kMidSpace+idx*(W_RATIO(100)+W_RATIO(20)), WIDTHF(self), W_RATIO(100));
        
        if (self.btnStyle == UIButtonStyle1) {
            UIColor *titleColor = COLOR_DF463E;
            if (idx == 0) {
                titleColor = COLOR_DF463E;
            }else if (idx == 1){
                titleColor = COLOR_649CE0;
            }
            bottomBtn.layer.borderColor = titleColor.CGColor;
            [bottomBtn setTitleColor:titleColor forState:UIControlStateNormal];
        }else if (self.btnStyle == UIButtonStyle2){
            UIColor *titleColor = COLOR_DF463E;
            if (idx == 0) {
                titleColor = COLOR_FFFFFF;
                bottomBtn.backgroundColor = COLOR_DF463E;
            }else if (idx == 1){
                titleColor = COLOR_DF463E;
                bottomBtn.backgroundColor = COLOR_FFFFFF;
            }
            bottomBtn.layer.borderColor = titleColor.CGColor;
            [bottomBtn setTitleColor:titleColor forState:UIControlStateNormal];
        }
        
    }];
}

-(void)handleBottomButtonClick:(UIButton*)btn{
    if (self.didSelectBottomButtonClickBlock) {
        self.didSelectBottomButtonClickBlock(_btnTitles[btn.tag]);
    }
}

@end
