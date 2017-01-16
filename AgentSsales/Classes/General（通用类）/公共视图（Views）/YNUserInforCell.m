//
//  YNUserInforCell.m
//  AgentSsales
//
//  Created by innofive on 17/1/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNUserInforCell.h"

@interface YNUserInforCell ()<UITextFieldDelegate>
/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (nonatomic, strong) dispatch_source_t timer;
/** 左边文字 */
@property (nonatomic,weak) UILabel *itemLabel;
/** 输入框 */
@property (nonatomic,weak) UITextField *inforTField;
/** 验证码按钮 */
@property (nonatomic,weak) UIButton *sendCodeBtn;
/** 右箭头 */
@property (nonatomic,weak) UIImageView *arrowImgView;

@end

@implementation YNUserInforCell

-(void)setInforDict:(NSDictionary *)inforDict{
    _inforDict = inforDict;
    
    self.itemLabel.text = inforDict[@"item"];
    self.inforTField.placeholder = inforDict[@"placeholder"];
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    self.inforTField.keyboardType = keyboardType;
}
-(void)setIsShowArrowImg:(BOOL)isShowArrowImg{
    _isShowArrowImg = isShowArrowImg;
    self.arrowImgView.hidden = !isShowArrowImg;
}
-(void)setIsForbidClick:(BOOL)isForbidClick{
    _isForbidClick = isForbidClick;
    self.inforTField.enabled = !isForbidClick;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.itemLabel.frame = CGRectMake(kMidSpace, 0, W_RATIO(180), HEIGHTF(self.contentView));
    if (self.isShowCodeBtn) {
        self.sendCodeBtn.frame = CGRectMake(WIDTHF(self.contentView)-W_RATIO(178)-kMinSpace*2, (HEIGHTF(self.contentView)-W_RATIO(70))/2.0, W_RATIO(178), W_RATIO(70));
    }else{
        self.sendCodeBtn.frame = CGRectMake(WIDTHF(self.contentView)-kMinSpace*2, kZero, kZero, kZero);
    }
    self.inforTField.frame = CGRectMake(MaxXF(_itemLabel), YF(_itemLabel), XF(_sendCodeBtn)-MaxXF(_itemLabel)-kMinSpace*2, HEIGHTF(_itemLabel));
}
-(UILabel *)itemLabel{
    if (!_itemLabel) {
        UILabel *itemLabel = [[UILabel alloc] init];
        _itemLabel = itemLabel;
        itemLabel.font = FONT(30);
        itemLabel.textColor = COLOR_666666;
        [self.contentView addSubview:itemLabel];
    }
    return _itemLabel;
}
-(UITextField *)inforTField{
    if (!_inforTField) {
        UITextField *inforTField = [[UITextField alloc] init];
        _inforTField = inforTField;
        inforTField.keyboardType = UIKeyboardTypeASCIICapable;
        inforTField.autocorrectionType = NO;
        inforTField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        inforTField.autocorrectionType = UITextAutocorrectionTypeNo;
        inforTField.secureTextEntry=YES;
        inforTField.font = FONT(32);
        inforTField.textColor = COLOR_999999;
        inforTField.delegate = self;
        [inforTField addTarget:self action:@selector(textfieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:inforTField];
        
    }
    return _inforTField;
}
-(UIImageView *)arrowImgView{
    if (!_arrowImgView) {
        UIImageView *arrowImgView = [[UIImageView alloc] init];
        _arrowImgView = arrowImgView;
        [self.contentView addSubview:arrowImgView];
        arrowImgView.image = [UIImage imageNamed:@"mianbaoxie_you_gouwuche"];
        arrowImgView.frame = CGRectMake(SCREEN_WIDTH-kMidSpace, (HEIGHT(self.contentView)-W_RATIO(24))/2.0, W_RATIO(14), W_RATIO(24));
    }
    return _arrowImgView;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return textField.enabled;
}
#pragma mark - private method

- (void)textfieldTextDidChange:(UITextField *)textField
{
    if (self.inforCellTextFieldBlock) {
        self.inforCellTextFieldBlock(_inforTField.text);
    }
}
-(UIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        // 按钮创建
        UIButton *sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendCodeBtn = sendCodeBtn;
        sendCodeBtn.layer.cornerRadius = kViewRadius;
        sendCodeBtn.backgroundColor = COLOR_DF463E;
        sendCodeBtn.titleLabel.font = FONT(28);
        [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [sendCodeBtn setTitleColor:COLOR_DF463E forState:UIControlStateDisabled];
        [sendCodeBtn addTarget:self action:@selector(handleSendButtonCodeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendCodeBtn];
    }
    return _sendCodeBtn;
}

-(void)handleSendButtonCodeClick:(UIButton*)btn{
    
    // 启动定时器
    dispatch_resume(self.timer);
    
}
-(dispatch_source_t)timer{
    if (!_timer) {
        __block long lastTime = 30;
        // 创建定时器
        dispatch_queue_t queue = dispatch_get_main_queue();
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC));
        uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
        dispatch_source_set_timer(_timer, start, interval, 0);
        // 设置回调
        dispatch_source_set_event_handler(_timer, ^{
            if (lastTime+1) {
                _sendCodeBtn.enabled = NO;
                _sendCodeBtn.backgroundColor = COLOR_EDEDED;
                [_sendCodeBtn setTitle:[NSString stringWithFormat:@"已发送 %02lds",lastTime--] forState:UIControlStateNormal];
            }else{
                _sendCodeBtn.enabled = YES;
                _sendCodeBtn.backgroundColor = COLOR_DF463E;
                [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                // 取消定时器
                dispatch_cancel(_timer);
                _timer = nil;
                /*
                 // 启动定时器
                 dispatch_resume(self.timer);
                 */
            }
        });
    }
    return _timer;
}
@end
