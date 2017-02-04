//
//  YNNewsCommentSendView.m
//  AgentSsales
//
//  Created by innofive on 17/2/3.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewsCommentSendView.h"

@interface YNNewsCommentSendView ()

@property (nonatomic,strong) UITextField * textField;

@property (nonatomic,strong) UIButton * sendBtn;

@end

@implementation YNNewsCommentSendView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_FFFFFF;
        self.textField.placeholder = @"说点什么吧";
    }
    return self;
}
-(UITextField *)textField{
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        _textField = textField;
        [self addSubview:textField];
        textField.textColor = COLOR_666666;
        textField.font = FONT(30);
        textField.frame = CGRectMake(W_RATIO(20), W_RATIO(20), W_RATIO(610), HEIGHTF(self.sendBtn));
        [textField addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = COLOR_DF463E;
        lineView.frame = CGRectMake(0, HEIGHTF(textField), WIDTHF(textField), W_RATIO(1));
        [textField addSubview:lineView];
    }
    return _textField;
}
-(UIButton *)sendBtn{
    if (!_sendBtn) {
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn = sendBtn;
        [self addSubview:sendBtn];
        sendBtn.layer.cornerRadius = kViewRadius;
        sendBtn.layer.masksToBounds = YES;
        sendBtn.userInteractionEnabled = NO;
        sendBtn.backgroundColor = COLOR_EDEDED;
        [sendBtn setTitle:@"发布" forState:UIControlStateNormal];
        sendBtn.titleLabel.font = FONT(32);
        [sendBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [sendBtn addTarget:self action:@selector(handleSendButton:) forControlEvents:UIControlEventTouchUpInside];
        CGSize btnSize = [sendBtn.titleLabel.text calculateHightWithFont:sendBtn.titleLabel.font maxWidth:0];
        sendBtn.frame = CGRectMake(SCREEN_WIDTH-(btnSize.width+kMinSpace*2)-W_RATIO(20), W_RATIO(20), btnSize.width+kMinSpace*2, W_RATIO(50));
    }
    return _sendBtn;
}
-(void)handleSendButton:(UIButton*)btn{
    if (self.didSelectSendButtonClickBlock) {
        self.didSelectSendButtonClickBlock(_textField.text);
    }
    _textField.text = nil;
    [_textField resignFirstResponder];
    _sendBtn.userInteractionEnabled = NO;
    _sendBtn.backgroundColor = COLOR_EDEDED;
}
-(void)textfieldTextDidChange:(UITextField *)textField{
    if (textField.text.length) {
        _sendBtn.userInteractionEnabled = YES;
        _sendBtn.backgroundColor = COLOR_DF463E;
    }else{
        _sendBtn.userInteractionEnabled = NO;
        _sendBtn.backgroundColor = COLOR_EDEDED;
    }
}
@end
