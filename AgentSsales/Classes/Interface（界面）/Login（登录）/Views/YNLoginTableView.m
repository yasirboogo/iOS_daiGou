//
//  YNLoginTableView.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNLoginTableView.h"
#import "YNUserInforCell.h"

@interface YNLoginTableView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNLoginTableView

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
    
    if (indexPath.row == 0) {
        inforCell.textFieldText = _loginphone;
        inforCell.keyboardType = UIKeyboardTypePhonePad;
    }else if (indexPath.row == 1){
        inforCell.textFieldText = _password;
        inforCell.keyboardType = UIKeyboardTypeASCIICapable;
    }
    
    inforCell.inforDict = _inforArray[indexPath.row];
    void (^codeBtnEnable)(BOOL) = ^(BOOL isEnable){
        inforCell.isEnableCodeBtn = isEnable;
    };
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        if (indexPath.row == 0) {
            self.loginphone = str;
            codeBtnEnable(str.length);
        }else if (indexPath.row == 1){
            self.password = str;
        }
    }];
    
    return inforCell;
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":kLocalizedString(@"userID", @"账号"),@"placeholder":kLocalizedString(@"inputID", @"输入注册手机号")},
                        @{@"item":kLocalizedString(@"userPwd", @"密码"),@"placeholder":kLocalizedString(@"inputPwd",@"输入登录密码")}
                        ];
    }
    return _inforArray;
}
@end
