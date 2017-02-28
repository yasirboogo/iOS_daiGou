//
//  YNRegisterTableView.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNRegisterTableView.h"
#import "YNUserInforCell.h"

@interface YNRegisterTableView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNRegisterTableView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0,kUINavHeight, SCREEN_WIDTH, W_RATIO(100)*self.inforArray.count);
        self.rowHeight = W_RATIO(100);
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self reloadData];
    }
    return self;
}
-(void)setCode:(NSString *)code{
    [self.textArrayM replaceObjectAtIndex:0 withObject:code];
    _code = [NSString stringWithFormat:@"+%@",code];
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _inforArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNUserInforCell * inforCell = [tableView dequeueReusableCellWithIdentifier:@"inforCell"];
    if (inforCell == nil) {
        inforCell = [[YNUserInforCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"inforCell"];
        inforCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 0, WIDTHF(inforCell.contentView), W_RATIO(2));
        lineView.backgroundColor = COLOR_EDEDED;
        [inforCell.contentView addSubview:lineView];
    }
    inforCell.textFieldText = nil;
    if (indexPath.row == 0) {
        inforCell.textFieldText = _code;
        inforCell.isShowArrowImg = YES;
        inforCell.isForbidClick = YES;
    }else if (indexPath.row == 1){
        inforCell.keyboardType = UIKeyboardTypePhonePad;
        inforCell.isShowCodeBtn = YES;
        [inforCell setDidSendPhoneCodeButtonBlock:^{
            self.didSelectSendPhoneCodeBlock();
        }];
    }else if (indexPath.row == 2){
        inforCell.keyboardType = UIKeyboardTypeNumberPad;
    }else if (indexPath.row == 3){
        inforCell.keyboardType = UIKeyboardTypeASCIICapable;
    }
    inforCell.inforDict = _inforArray[indexPath.row];
    
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        
        [self.textArrayM replaceObjectAtIndex:indexPath.row withObject:str];
    }];
    
    return inforCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        if (self.didSelectAreaCellBlock) {
            self.didSelectAreaCellBlock();
        }
    }
}
-(NSMutableArray<NSString *> *)textArrayM{
    if (!_textArrayM) {
        _textArrayM = [NSMutableArray arrayWithObjects:kZeroStr,kZeroStr,kZeroStr,kZeroStr, nil];
    }
    return _textArrayM;
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":@"国家(区号)",@"placeholder":@"选择您所在的国家(区号)"},
                        @{@"item":@"手机号",@"placeholder":@"输入您的手机号"},
                        @{@"item":@"验证码",@"placeholder":@"输入验证码"},
                        @{@"item":@"密码",@"placeholder":@"输入登录密码"}
                        ];
    }
    return _inforArray;
}
@end
