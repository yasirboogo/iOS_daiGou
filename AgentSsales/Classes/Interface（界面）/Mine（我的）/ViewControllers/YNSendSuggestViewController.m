//
//  YNSendSuggestViewController.m
//  AgentSsales1
//
//  Created by innofive on 17/2/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNSendSuggestViewController.h"

@interface YNSendSuggestViewController ()<UITextViewDelegate>

@property (nonatomic,weak) UIButton * submitBtn;

@property (nonatomic,weak) UITextView * textView;

@property (nonatomic,weak) UILabel * numberLabel;

@property (nonatomic,weak) UIView * numberView;

@end

@implementation YNSendSuggestViewController

#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //监听键盘的通知
    [self observeKeyboardStatus];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textView resignFirstResponder];
    
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - 网路请求
-(void)startNetWorkingRequestWithSendSuggest{
    NSDictionary *params = @{@"userId":[DEFAULTS valueForKey:kUserLoginInfors][@"userId"],
                             @"content":[_textView.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                             };
    [YNHttpManagers sendSuggestWithParams:params success:^(id response) {
        if ([response[@"code"] isEqualToString:@"success"]) {
            //do success things
            [SVProgressHUD showImage:nil status:LocalSubmitSuccess];
            [SVProgressHUD dismissWithDelay:2.0f completion:^{
                [self.navigationController popViewControllerAnimated:NO];
            }];
        }else{
            //do failure things
            [SVProgressHUD showImage:nil status:LocalSubmitFailure];
            [SVProgressHUD dismissWithDelay:2.0f ];
        }
    } failure:^(NSError *error) {
        //do error things
    }];
    
}
#pragma mark - 视图加载
-(UITextView *)textView{
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] init];
        _textView = textView;
        [self.view addSubview:textView];
        textView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, W_RATIO(720));
        textView.font = FONT(30);
        textView.delegate = self;
        textView.textColor = COLOR_999999;
        textView.placeholderFont = textView.font;
        textView.placeholder = LocalSuggestTips;
    }
    return _textView;
}
-(UIView *)numberView{
    if (!_numberView) {
        UIView * numberView = [[UIView alloc] init];
        _numberView = numberView;
        [self.view addSubview:numberView];
        numberView.backgroundColor = COLOR_FFFFFF;
        numberView.frame = CGRectMake(0, MaxYF(self.textView), SCREEN_WIDTH, W_RATIO(80));
    }
    return _numberView;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *numberLabel = [[UILabel alloc] init];
        _numberLabel = numberLabel;
        [self.numberView addSubview:numberLabel];
        numberLabel.textColor = COLOR_999999;
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.font = FONT(26);
        numberLabel.frame = CGRectMake(kMidSpace, 0, SCREEN_WIDTH-2*kMidSpace, HEIGHTF(self.numberView));
    }
    return _numberLabel;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn = submitBtn;
        submitBtn.frame = CGRectMake(0 ,SCREEN_HEIGHT-W_RATIO(100), SCREEN_WIDTH, W_RATIO(100));
        submitBtn.backgroundColor = COLOR_DF463E;
        submitBtn.titleLabel.font = FONT(36);
        [submitBtn setTitle:LocalSubmit forState:UIControlStateNormal];
        [submitBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(handleSubmitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitBtn];
    }
    return _submitBtn;
}
#pragma mark - 代理实现
#define MAX_STARWORDS_LENGTH 400
- (void)textViewDidChange:(UITextView *)textView{
    NSString *toBeString = textView.text;
    NSArray *current = [UITextInputMode activeInputModes];
    UITextInputMode *currentInputMode = [current firstObject];
    NSString *lang = [currentInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        //获取高亮部分
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
                if (rangeIndex.length == 1){
                    textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                }else{
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                    
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
        self.numberLabel.text = [NSString stringWithFormat:@"%lu",400-textView.text.length];
    }else {// 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > MAX_STARWORDS_LENGTH){
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1){
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
        self.numberLabel.text = [NSString stringWithFormat:@"%lu",400-textView.text.length];
    }
}
#pragma mark - 函数、消息
-(void)makeData{
    [super makeData];
    self.numberLabel.text = [NSString stringWithFormat:@"%d",MAX_STARWORDS_LENGTH];
}
-(void)makeNavigationBar{
    [super makeNavigationBar];
    self.titleLabel.text = LocalSuggestions;
}
-(void)makeUI{
    [super makeUI];
    [self.view addSubview:self.submitBtn];
}

-(void)handleSubmitButtonClick:(UIButton*)btn{
    [self.view endEditing:YES];
    if (!_textView.text.length) {
        [SVProgressHUD showImage:nil status:LocalInputIsEmpty];
        [SVProgressHUD dismissWithDelay:2.0f];
    }else{
        [self startNetWorkingRequestWithSendSuggest];
    }
}
#pragma mark - 数据懒加载

#pragma mark - 其他
-(void)observeKeyboardStatus{
    // 键盘即将展开
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}// 监听键盘
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.textView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, W_RATIO(720));
        self.numberView.frame = CGRectMake(0, MaxYF(self.textView), SCREEN_WIDTH, W_RATIO(80));
    }];
}
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 取出键盘高度
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = keyboardF.size.height;
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.textView.frame = CGRectMake(0, kUINavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kUINavHeight-W_RATIO(80)-keyboardH);
        self.numberView.frame = CGRectMake(0, MaxYF(self.textView), SCREEN_WIDTH, W_RATIO(80));
    }];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
