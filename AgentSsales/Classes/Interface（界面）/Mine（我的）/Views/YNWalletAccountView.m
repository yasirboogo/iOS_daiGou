//
//  YNWalletAccountView.m
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNWalletAccountView.h"

@interface YNWalletAccountView ()<UITextFieldDelegate>

@property (nonatomic,weak) UIImageView * accountImgView;

@property (nonatomic,weak) UILabel * accountLabel;

@property (nonatomic,weak) UITextField * moneyTField;

@property (nonatomic,weak) UILabel * tipsLabel;

@property (nonatomic,strong) UILabel * leftLabel;

@property (nonatomic,strong) UIButton * leftShowBtn;

@property (nonatomic,strong) UILabel * rightLabel;

@end

@implementation YNWalletAccountView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
        self.frame = CGRectMake(W_RATIO(20), kUINavHeight+W_RATIO(20), SCREEN_WIDTH-W_RATIO(20)*2, W_RATIO(510));
        
        self.accountImgView.image = [UIImage imageNamed:@"chongzhi_icon"];
        
        
        [self addSubview:self.moneyTField];
        
        [self addSubview:self.tipsLabel];
    }
    return self;
}
-(void)setIsShow:(BOOL)isShow{
    _isShow = isShow;
    _leftShowBtn.selected = isShow;
    if (self.didSelectLeftShowButtonBlock) {
        self.didSelectLeftShowButtonBlock(isShow);
    }
}
-(void)setAccountNumber:(NSString *)accountNumber{
    _accountNumber = accountNumber;
    self.accountLabel.text = [NSString stringWithFormat:@"%@：%@",LocalAccount,accountNumber];
    CGSize accountSize = [_accountLabel.text calculateHightWithFont:_accountLabel.font maxWidth:WIDTHF(self)-kMidSpace*2];
    _accountLabel.frame = CGRectMake(kMidSpace, MaxYF(_accountImgView)+kMidSpace, WIDTHF(self)-kMidSpace*2, accountSize.height);
}
-(void)setLeftMomeyType:(NSString *)leftMomeyType{
    _leftMomeyType = leftMomeyType;

    UIView *leftView = [[UIView alloc] init];
    
    self.leftLabel.text = leftMomeyType;
    CGSize leftSize = [_leftLabel.text calculateHightWithFont:_leftLabel.font maxWidth:0];
    self.leftLabel.frame = CGRectMake(0, 0, leftSize.width+W_RATIO(20), HEIGHTF(self.moneyTField));
    [leftView addSubview:_leftLabel];
    self.leftShowBtn.frame = CGRectMake(MaxXF(_leftLabel), 0, HEIGHTF(_leftLabel), HEIGHTF(_leftLabel));
    [leftView addSubview:_leftShowBtn];
    leftView.frame = CGRectMake(0, 0, MaxXF(_leftShowBtn), HEIGHTF(_leftLabel));
    self.moneyTField.leftView = leftView;
    _moneyTField.leftViewMode = UITextFieldViewModeAlways;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        UILabel * leftLabel = [[UILabel alloc] init];
        _leftLabel = leftLabel;
        leftLabel.font = FONT(26);
        leftLabel.textColor = COLOR_333333;
        leftLabel.textAlignment = NSTextAlignmentRight;
        leftLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftShowButtonClick)];
        [leftLabel addGestureRecognizer:tap];
    }
    return _leftLabel;
}
-(UIButton *)leftShowBtn{
    if (!_leftShowBtn) {
        UIButton *leftShowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftShowBtn = leftShowBtn;
        [leftShowBtn setImage:[UIImage imageNamed:@"mianbaoxie_kui_xia"] forState:UIControlStateNormal];
        [leftShowBtn setImage:[UIImage imageNamed:@"mianbaoxie_kui_shang"] forState:UIControlStateSelected];
        [leftShowBtn addTarget:self action:@selector(handleLeftShowButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftShowBtn;
}
-(void)handleLeftShowButtonClick{
    self.isShow = !_leftShowBtn.selected;
}
-(void)setRightMarkType:(NSString *)rightMarkType{
    _rightMarkType = rightMarkType;
    self.rightLabel.text = rightMarkType;
    CGSize rightSize = [_rightLabel.text calculateHightWithFont:_rightLabel.font maxWidth:0];
    _rightLabel.frame = CGRectMake(0, 0, rightSize.width+kMidSpace, HEIGHTF(_moneyTField));
    _moneyTField.rightView = _rightLabel;
    _moneyTField.rightViewMode = UITextFieldViewModeAlways;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        UILabel * rightLabel = [[UILabel alloc] init];
        _rightLabel = rightLabel;
        rightLabel.font = FONT(30);
        rightLabel.textColor = COLOR_333333;
        rightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightLabel;
}
-(UIImageView *)accountImgView{
    if (!_accountImgView) {
        UIImageView *accountImgView = [[UIImageView alloc] init];
        _accountImgView = accountImgView;
        [self addSubview:accountImgView];
        accountImgView.frame = CGRectMake((WIDTHF(self)-W_RATIO(160))/2.0, kMidSpace, W_RATIO(160), W_RATIO(160));
    }
    return _accountImgView;
}
-(UILabel *)accountLabel{
    if (!_accountLabel) {
        UILabel *accountLabel = [[UILabel alloc] init];
        _accountLabel = accountLabel;
        [self addSubview:accountLabel];
        accountLabel.textAlignment = NSTextAlignmentCenter;
        accountLabel.font = FONT(36);
        accountLabel.textColor = COLOR_333333;
    }
    return _accountLabel;
}
-(UITextField *)moneyTField{
    if (!_moneyTField) {
        UITextField *moneyTField = [[UITextField alloc] init];
        _moneyTField = moneyTField;
        [self addSubview:moneyTField];
        moneyTField.delegate = self;
        moneyTField.textAlignment = NSTextAlignmentCenter;
        moneyTField.backgroundColor = COLOR_EEEEEE;
        moneyTField.keyboardType = UIKeyboardTypeDecimalPad;
        moneyTField.autocorrectionType = NO;
        moneyTField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        moneyTField.autocorrectionType = UITextAutocorrectionTypeNo;
        moneyTField.font = FONT(30);
        moneyTField.placeholder = LocalInputMoney;
        moneyTField.textColor = COLOR_999999;
        [moneyTField addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
        moneyTField.frame = CGRectMake(W_RATIO(20), W_RATIO(320), WIDTHF(self)-W_RATIO(20)*2, W_RATIO(90));

        self.leftMomeyType = @[LocalChineseMoney,LocalMalayMoney,LocalAmericanMoney][[LanguageManager currentLanguageIndex]];
        self.rightMarkType = LocalMoneyType;
    }
    return _moneyTField;
}
#pragma mark - private method
- (void)textfieldTextDidChange:(UITextField *)textField
{
    if (self.accountTextFieldBlock) {
        self.accountTextFieldBlock(textField.text);
    }
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        tipsLabel.font = FONT(28);
        tipsLabel.textColor = COLOR_999999;
        tipsLabel.adjustsFontSizeToFitWidth = YES;
        tipsLabel.userInteractionEnabled = YES;
        tipsLabel.frame = CGRectMake(XF(_moneyTField), MaxYF(_moneyTField), WIDTHF(_moneyTField), HEIGHTF(_moneyTField));
        NSString *tipsStr = @"充值满1000元赠送20元优惠券";
        NSMutableAttributedString *attributedStrM = [[NSMutableAttributedString alloc] initWithString:tipsStr];
        [attributedStrM addAttributes:@{NSForegroundColorAttributeName:COLOR_DF463E} range:NSMakeRange(10, tipsStr.length-10)];
        
        tipsLabel.attributedText = attributedStrM;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTipsLabelClick:)];
        [tipsLabel addGestureRecognizer:tap];
        
    }
    return _tipsLabel;
}
-(void)handleTipsLabelClick:(UITapGestureRecognizer*)tap{
    if (self.tipsLabelClickBlock) {
        self.tipsLabelClickBlock();
    }
}
@end








