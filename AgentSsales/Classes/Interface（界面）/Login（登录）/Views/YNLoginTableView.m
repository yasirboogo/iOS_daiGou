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
        inforCell.keyboardType = UIKeyboardTypePhonePad;
    }else if (indexPath.row == 1){
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
        _textArrayM = [NSMutableArray arrayWithObjects:@"0",@"1", nil];
    }
    return _textArrayM;
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":@"账号",@"placeholder":@"输入注册手机号"},
                        @{@"item":@"密码",@"placeholder":@"输入登录密码"}
                        ];
    }
    return _inforArray;
}
@end
