//
//  YNPaymentTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPaymentTableView.h"

@interface YNPaymentTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSIndexPath * indexPath;

@end

@implementation YNPaymentTableView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.rowHeight = W_RATIO(120);
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_EDEDED;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.text = @"付款方式";
        tipsLabel.font = FONT(28);
        tipsLabel.textColor = COLOR_999999;
        tipsLabel.frame = CGRectMake(0, 0, WIDTHF(self), W_RATIO(80));
        
        self.tableHeaderView = tipsLabel;
        
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNPaymentCell * PaymentCell = [tableView dequeueReusableCellWithIdentifier:@"paymentCell"];
    if (PaymentCell == nil) {
        PaymentCell = [[YNPaymentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"paymentCell"];
        PaymentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    PaymentCell.dict = _dataArray[indexPath.row];
    PaymentCell.isSelect = indexPath == self.indexPath ? YES :NO;
    return PaymentCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.indexPath = indexPath;
    if (self.didSelectPaymentCellBlock) {
        self.didSelectPaymentCellBlock(_dataArray[indexPath.row][@"payment"]);
    }
}
@end

@interface YNPaymentCell ()

@property (nonatomic,weak) UIImageView * payImgView;

@property (nonatomic,weak) UILabel * paymentLabel;

@property (nonatomic,weak) UIButton * paymentBtn;

@end

@implementation YNPaymentCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.payImgView.image = [UIImage imageNamed:dict[@"image"]];
    self.paymentLabel.text = dict[@"payment"];
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    self.paymentBtn.selected = isSelect;
}
-(UIImageView *)payImgView{
    if (!_payImgView) {
        UIImageView *payImgView = [[UIImageView alloc] init];
        _payImgView = payImgView;
        [self.contentView addSubview:payImgView];
        payImgView.frame = CGRectMake(W_RATIO(40),
                                      (W_RATIO(120)-W_RATIO(60))/2.0,
                                      W_RATIO(60), W_RATIO(60));
        payImgView.layer.cornerRadius = WIDTHF(payImgView)/2.0;
        payImgView.layer.masksToBounds = YES;
    }
    return _payImgView;
}
-(UIButton *)paymentBtn{
    if (!_paymentBtn) {
        UIButton *paymentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _paymentBtn = paymentBtn;
        [self.contentView addSubview:paymentBtn];
        
        [paymentBtn setBackgroundImage:[UIImage imageNamed:@"gou_kui_gouwuche"] forState:UIControlStateNormal];
        [paymentBtn setBackgroundImage:[UIImage imageNamed:@"gou_hong_gouwuche"] forState:UIControlStateSelected];

        paymentBtn.frame = CGRectMake(W_RATIO(710)-kMidSpace*2,
                                      (W_RATIO(120)-kMidSpace)/2.0,
                                      kMidSpace,
                                      kMidSpace);
    }
    return _paymentBtn;
}
-(UILabel *)paymentLabel{
    if (!_paymentLabel) {
        UILabel *paymentLabel = [[UILabel alloc] init];
        _paymentLabel = paymentLabel;
        [self.contentView addSubview:paymentLabel];
        paymentLabel.font = FONT(32);
        paymentLabel.textColor = COLOR_333333;
        paymentLabel.frame = CGRectMake(MaxXF(_payImgView)+kMidSpace,
                                        0,
                                        XF(self.paymentBtn)-(MaxXF(_payImgView)+kMidSpace*2),
                                        W_RATIO(120));
    }
    return _paymentLabel;
}

@end
