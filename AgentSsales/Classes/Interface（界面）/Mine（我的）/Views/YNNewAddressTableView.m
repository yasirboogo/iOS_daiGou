//
//  YNNewAddressTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNNewAddressTableView.h"
#import "YNUserInforCell.h"

@interface YNNewAddressTableView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation YNNewAddressTableView

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
    inforCell.inforDict = _inforArray[indexPath.row];
    if (indexPath.row == 0) {
    }else if (indexPath.row == 1){
        inforCell.keyboardType = UIKeyboardTypePhonePad;
    }else if (indexPath.row == 2){
        inforCell.isForbidClick = YES;
        inforCell.isShowArrowImg = YES;
    }else if (indexPath.row == 3){
        
    }
    
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        if (indexPath.row == 0) {
            self.name = str;
        }else if (indexPath.row == 1){
            self.phone = str;
        }else if (indexPath.row == 2){
            self.locality = str;
        }else if (indexPath.row == 3){
            self.details = str;
        }
    }];
    
    return inforCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 2) {
    }
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":@"姓名",@"placeholder":@"请输入收货人姓名"},
                        @{@"item":@"手机号码",@"placeholder":@"请输入收货人的手机号码"},
                        @{@"item":@"所在地区",@"placeholder":@"请选择所在地区"},
                        @{@"item":@"详细地址",@"placeholder":@"请输入详细地址"},
                        ];
    }
    return _inforArray;
}
@end
