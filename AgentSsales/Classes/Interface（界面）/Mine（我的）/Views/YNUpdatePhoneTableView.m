//
//  YNUpdatePhoneTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNUpdatePhoneTableView.h"
#import "YNUserInforCell.h"

@interface YNUpdatePhoneTableView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNUpdatePhoneTableView

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
        inforCell.isShowCodeBtn = YES;
        inforCell.keyboardType = UIKeyboardTypePhonePad;
    }else if (indexPath.row == 1){
        inforCell.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    inforCell.inforDict = _inforArray[indexPath.row];
    
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        
        [self.textArrayM replaceObjectAtIndex:indexPath.row withObject:str];
    }];
    
    return inforCell;
}
-(NSMutableArray<NSString *> *)textArrayM{
    if (!_textArrayM) {
        _textArrayM = [NSMutableArray arrayWithObjects:@"0",@"1", nil];
    }
    return _textArrayM;
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":@"新手机号码",@"placeholder":@"请输入新号码"},
                        @{@"item":@"验证码",@"placeholder":@"请填写验证码"}
                        ];
    }
    return _inforArray;
}

@end
