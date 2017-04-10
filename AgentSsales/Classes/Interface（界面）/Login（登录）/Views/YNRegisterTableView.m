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
-(void)setCountry:(NSString *)country{
    _country = country;
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
        inforCell.textFieldText = _country;
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
    void (^codeBtnEnable)(BOOL) = ^(BOOL isEnable){
        inforCell.isEnableCodeBtn = isEnable;
    };
    
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        if (indexPath.row == 1) {
            self.loginphone = str;
            codeBtnEnable(str.length && _country.length);
        }else if (indexPath.row == 2){
            self.checkCode = str;
        }else if (indexPath.row == 3){
            self.password = str;
        }
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
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":LocalCountry,@"placeholder":LocalCountryID},
                        @{@"item":LocalPhoneID,@"placeholder":LocalInputID},
                        @{@"item":LocalCodeID,@"placeholder":LocalInputCodeID},
                        @{@"item":LocalUserPwd,@"placeholder":LocalInputPwd}
                        ];
    }
    return _inforArray;
}
@end
