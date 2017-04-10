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
@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;

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
    }
    return self;
}
-(void)setAddressM:(NSMutableDictionary *)addressM{
    _addressM = addressM;
    self.name = addressM[@"name"];
    self.phone = addressM[@"phone"];
    self.locality = addressM[@"region"];
    self.details = addressM[@"detailed"];
    self.email = addressM[@"email"];
    [self reloadData];
}
-(void)setArea:(NSString *)area{
    _area = area;
    [self.addressM setObject:area forKey:@"region"];
    self.locality = area;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.inforArray.count;
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
        inforCell.textFieldText = _name;
    }else if (indexPath.row == 1){
        inforCell.textFieldText = _phone;
        inforCell.keyboardType = UIKeyboardTypePhonePad;
    }else if (indexPath.row == 2){
        inforCell.textFieldText = _locality;
        inforCell.isForbidClick = YES;
        inforCell.isShowArrowImg = YES;
    }else if (indexPath.row == 3){
        inforCell.textFieldText = _details;
    }else if (indexPath.row == 4){
        inforCell.textFieldText = _email;
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
        }else if (indexPath.row == 4){
            self.email = str;
        }
    }];
    return inforCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 2) {
        self.didSelectAddressCellBlock();
    }
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":LocalRecName,@"placeholder":LocalInputRecName},
                        @{@"item":LocalRecPhone,@"placeholder":LocalInputRecPhone},
                        @{@"item":LocalArea,@"placeholder":LocalSelectArea},
                        @{@"item":LocalDetailArea,@"placeholder":LocalInputDeatilArea},
                        @{@"item":LocalEmail,@"placeholder":LocalInputEmail}
                        ];
    }
    return _inforArray;
}
@end
