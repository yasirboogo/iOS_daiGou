//
//  YNForgetPwdTableView.m
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNForgetPwdTableView.h"
#import "YNUserInforCell.h"

@interface YNForgetPwdTableView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNForgetPwdTableView

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
        inforCell.keyboardType = UIKeyboardTypeNumberPad;
        inforCell.isShowCodeBtn = YES;
        [inforCell setDidSendPhoneCodeButtonBlock:^{
            if (self.didSelectSendPhoneCodeBlock) {
                self.didSelectSendPhoneCodeBlock();
            }
        }];
    }else if (indexPath.row == 1){
        inforCell.keyboardType = UIKeyboardTypeASCIICapable;
    }else if (indexPath.row == 2){
        inforCell.keyboardType = UIKeyboardTypeASCIICapable;
    }
    
    inforCell.inforDict = _inforArray[indexPath.row];
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        
        [self.textArrayM replaceObjectAtIndex:indexPath.row withObject:str];
    }];
    
    return inforCell;
}
-(NSMutableArray<NSString *> *)textArrayM{
    if (!_textArrayM) {
        _textArrayM = [NSMutableArray arrayWithObjects:@"0",@"1",@"2", nil];
    }
    return _textArrayM;
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":@"验证码",@"placeholder":@"请输入验证码"},
                        @{@"item":@"新密码",@"placeholder":@"请输入新密码，6-20位数"},
                        @{@"item":@"确认密码",@"placeholder":@"请再次输入密码"}
                        ];
    }
    return _inforArray;
}
@end


