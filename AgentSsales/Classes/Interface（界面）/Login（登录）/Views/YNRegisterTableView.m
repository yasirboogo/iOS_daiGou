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
        inforCell.keyboardType = UIKeyboardTypePhonePad;
        inforCell.isShowCodeBtn = YES;
    }else if (indexPath.row == 1){
        inforCell.keyboardType = UIKeyboardTypeNumberPad;
    }else if (indexPath.row == 2){
        inforCell.keyboardType = UIKeyboardTypeASCIICapable;
    }else if (indexPath.row == 3){
        inforCell.keyboardType = UIKeyboardTypeASCIICapable;
        inforCell.isShowArrowImg = YES;
        inforCell.isForbidClick = YES;
    }
    inforCell.inforDict = _inforArray[indexPath.row];
    
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        
        [self.textArrayM replaceObjectAtIndex:indexPath.row withObject:str];
    }];
    
    return inforCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 3) {
        NSLog(@"---------- %@ test is OK! ----------",@"1");
    }
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
                        @{@"item":@"手机号",@"placeholder":@"输入您的手机号"},
                        @{@"item":@"验证码",@"placeholder":@"输入验证码"},
                        @{@"item":@"账号",@"placeholder":@"输入登录密码"},
                        @{@"item":@"国家",@"placeholder":@"选择你所在的国家"}
                        ];
    }
    return _inforArray;
}
@end
