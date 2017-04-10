//
//  YNPrefectInforTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPrefectInforTableView.h"
#import "YNUserInforCell.h"

@interface YNPrefectInforTableView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;

@end

@implementation YNPrefectInforTableView

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
-(void)setLocality:(NSString *)locality{
    _locality = locality;
    [self reloadData];
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
        inforCell.textFieldText = self.locality;
    }else if (indexPath.row == 3){
        
    }
    
    [inforCell setInforCellTextFieldBlock:^(NSString *str) {
        if (indexPath.row == 0) {
            self.name = str;
        }else if (indexPath.row == 1){
            self.phone = str;
        }else if (indexPath.row == 2){
        }else if (indexPath.row == 3){
            self.details = str;
        }else if (indexPath.row == 4){
            self.emial = str;
        }else if (indexPath.row == 5){
            self.numberID = str;
        }
    }];
    
    return inforCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 2 && self.didSelectAddressCellBlock) {
        self.didSelectAddressCellBlock();
    }
}
-(NSArray<NSDictionary *> *)inforArray{
    if (!_inforArray) {
        _inforArray = @[
                        @{@"item":LocalRecName,@"placeholder":LocalInputRecName},
                        @{@"item":LocalRecPhone,@"placeholder":LocalInputRecName},
                        @{@"item":LocalArea,@"placeholder":LocalSelectArea},
                        @{@"item":LocalDetailArea,@"placeholder":LocalInputDeatilArea},
                        @{@"item":LocalEmail,@"placeholder":LocalInputEmail},
                        @{@"item":LocalCardID,@"placeholder":LocalInputCardID},
                        ];
    }
    return _inforArray;
}
@end
