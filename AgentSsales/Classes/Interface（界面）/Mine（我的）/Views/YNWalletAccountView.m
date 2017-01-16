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

-(void)setAccountNumber:(NSString *)accountNumber{
    _accountNumber = accountNumber;
    self.accountLabel.text = [NSString stringWithFormat:@"账户：%@",accountNumber];
    CGSize accountSize = [_accountLabel.text calculateHightWithFont:_accountLabel.font maxWidth:WIDTHF(self)-kMidSpace*2];
    _accountLabel.frame = CGRectMake(kMidSpace, MaxYF(_accountImgView)+kMidSpace, WIDTHF(self)-kMidSpace*2, accountSize.height);
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
        moneyTField.textAlignment = NSTextAlignmentLeft;
        moneyTField.backgroundColor = COLOR_EEEEEE;
        moneyTField.keyboardType = UIKeyboardTypeDecimalPad;
        moneyTField.autocorrectionType = NO;
        moneyTField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        moneyTField.autocorrectionType = UITextAutocorrectionTypeNo;
        moneyTField.font = FONT(30);
        moneyTField.placeholder = @"请输入充值金额";
        moneyTField.textColor = COLOR_999999;
        [moneyTField addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
        moneyTField.frame = CGRectMake(W_RATIO(20), W_RATIO(320), WIDTHF(self)-W_RATIO(20)*2, W_RATIO(90));
        //左边视图
        {
            UILabel * leftLabel = [[UILabel alloc] init];
            leftLabel.text = @"人民币";
            leftLabel.font = FONT(30);
            leftLabel.textColor = COLOR_333333;
            leftLabel.textAlignment = NSTextAlignmentCenter;
            CGSize leftSize = [leftLabel.text calculateHightWithFont:leftLabel.font maxWidth:0];
            leftLabel.frame = CGRectMake(0, 0, leftSize.width+kMidSpace, HEIGHTF(moneyTField));
            
            moneyTField.leftView = leftLabel;
            moneyTField.leftViewMode = UITextFieldViewModeAlways;
        }
        //右边视图
        {
            UILabel * rightLabel = [[UILabel alloc] init];
            rightLabel.text = @"元";
            rightLabel.font = FONT(30);
            rightLabel.textColor = COLOR_333333;
            rightLabel.textAlignment = NSTextAlignmentCenter;
            CGSize rightSize = [rightLabel.text calculateHightWithFont:rightLabel.font maxWidth:0];
            rightLabel.frame = CGRectMake(0, 0, rightSize.width+kMidSpace, HEIGHTF(moneyTField));
            
            moneyTField.rightView = rightLabel;
            moneyTField.rightViewMode = UITextFieldViewModeAlways;
        }
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








