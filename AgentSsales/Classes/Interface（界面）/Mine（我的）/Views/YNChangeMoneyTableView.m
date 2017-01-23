//
//  YNChangeMoneyTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNChangeMoneyTableView.h"

@interface YNChangeMoneyTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView * footerView;

@end

@implementation YNChangeMoneyTableView

-(instancetype)init{
    self = [super init];
    self.frame = CGRectMake(W_RATIO(20),kUINavHeight+W_RATIO(20), SCREEN_WIDTH-W_RATIO(20)*2, W_RATIO(224)*2+W_RATIO(150));
    if (self) {
        self.rowHeight = W_RATIO(224);
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_CLEAR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
        self.tableFooterView = self.footerView;
    }
    return self;
}

-(UIView *)footerView{
    if (!_footerView) {
        UIView *footerView = [[UIView alloc] init];
        _footerView = footerView;
        footerView.frame = CGRectMake(0, 0, WIDTHF(self), W_RATIO(150));
        footerView.backgroundColor = COLOR_649CE0;
        
        YYLabel *changeLabel = [[YYLabel alloc] init];
        
    }
    return _footerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNChangeMoneyCell * moneyCell = [tableView dequeueReusableCellWithIdentifier:@"moneyCell"];
    if (moneyCell == nil) {
        moneyCell = [[YNChangeMoneyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        moneyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        moneyCell.layer.cornerRadius = W_RATIO(20);
        moneyCell.layer.masksToBounds = YES;
    }
    if (indexPath.row == 0) {
        moneyCell.name = @"持有货币";
        moneyCell.type = self.type1;
        moneyCell.money = self.money1;
        [moneyCell setDidSelectMoneyNumClickBlock:^{
            if (self.didSelectMoneyNumClickBlock) {
                self.didSelectMoneyNumClickBlock();
            }
        }];

    }else if (indexPath.row == 1){
        moneyCell.name = @"兑换货币";
        moneyCell.type = self.type2;
        moneyCell.money = self.money2;
    }
    [moneyCell setDidSelectMoneyTypeClickBlock:^{
        if (self.didSelectMoneyTypeClickBlock) {
            self.didSelectMoneyTypeClickBlock(indexPath);
        }
    }];
    
    return moneyCell;
}
-(void)setType1:(NSString *)type1{
    _type1 = type1;
    
    _money2 = [NSString stringWithFormat:@"%f",[_money1 floatValue] * 10];
    
    [self reloadData];
}
-(void)setType2:(NSString *)type2{
    _type2 = type2;
    
    _money2 = [NSString stringWithFormat:@"%f",[_money1 floatValue] * 10];
    
    [self reloadData];
}
-(void)setMoney1:(NSString *)money1{
    _money1 = money1;
    
    _money2 = [NSString stringWithFormat:@"%f",[_money1 floatValue] * 10];
    
    [self reloadData];
}

@end
@interface YNChangeMoneyCell ()

@property (nonatomic,weak) UILabel * nameLabel;

@property (nonatomic,weak) UILabel * typeLabel;

@property (nonatomic,weak) UIButton * arrowBtn;

@property (nonatomic,weak) UILabel * symbolLabel;

@property (nonatomic,weak) UILabel * moneyLabel;

@property (nonatomic,weak) UIScrollView * moneyScrollView;

@end
@implementation YNChangeMoneyCell

-(void)setName:(NSString *)name{
    _name = name;
    
    if ([name isEqualToString:@"持有货币"]) {
        self.backgroundColor = COLOR_DF463E;
        
        self.nameLabel.text = @"持有货币";
        self.nameLabel.textColor = COLOR_F6D3D2;
        
        self.typeLabel.textColor = COLOR_FFFFFF;
        
        [self.arrowBtn setBackgroundImage:[UIImage imageNamed:@"xuanze_bai"] forState:UIControlStateNormal];
        
        self.symbolLabel.textColor = COLOR_FFFFFF;
        
        self.moneyLabel.textColor = COLOR_FFFFFF;
        
    }else if ([name isEqualToString:@"兑换货币"]){
        self.backgroundColor = COLOR_FFFFFF;
        
        self.nameLabel.text = @"兑换货币";
        self.nameLabel.textColor = COLOR_333333;
        
        self.typeLabel.textColor = COLOR_000000;
        
        [self.arrowBtn setBackgroundImage:[UIImage imageNamed:@"xuanze_hong"] forState:UIControlStateNormal];
        
        self.symbolLabel.textColor = COLOR_000000;
        
        self.moneyLabel.textColor = COLOR_000000;
        
    }
}
-(void)setType:(NSString *)type{
    _type = type;
    
    self.typeLabel.text = type;
    if ([type isEqualToString:@"人民币"]) {
        self.symbolLabel.text = @"MCY";
    }else if ([type isEqualToString:@"马来西亚币"]){
        self.symbolLabel.text = @"RM";
    }else if ([type isEqualToString:@"美元"]){
        self.symbolLabel.text = @"USD";
    }
}
-(void)setMoney:(NSString *)money{
    _money = money;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%0.2f",[money floatValue]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize typeSize = [_typeLabel.text calculateHightWithFont:_typeLabel.font maxWidth:W_RATIO(200)];
    self.typeLabel.frame = CGRectMake(XF(_nameLabel),MaxYF(_nameLabel)+kMinSpace*3, typeSize.width, typeSize.height);
    
    self.arrowBtn.frame = CGRectMake(MaxXF(_typeLabel)+kMinSpace,YF(_typeLabel),HEIGHTF(_typeLabel), HEIGHTF(_typeLabel));
    
    
    CGSize symbolSize = [_symbolLabel.text calculateHightWithFont:_symbolLabel.font maxWidth:WIDTHF(_nameLabel)/2.0-MaxXF(_arrowBtn)];
    self.symbolLabel.frame = CGRectMake(MaxXF(_arrowBtn), YF(_typeLabel),kMidSpace+WIDTHF(_nameLabel)/2.0-MaxXF(_arrowBtn),symbolSize.height);
    
    CGSize moneySize = [_moneyLabel.text calculateHightWithFont:_moneyLabel.font maxWidth:0];
    self.moneyLabel.frame = CGRectMake(0, 0,moneySize.width, moneySize.height);
    
    self.moneyScrollView.frame = CGRectMake(MaxXF(_symbolLabel)+kMinSpace, YF(_symbolLabel), WIDTHF(_nameLabel)/2.0-kMinSpace, moneySize.height);
    self.moneyScrollView.contentSize = CGSizeMake(WIDTHF(_moneyLabel), HEIGHTF(_moneyLabel));
    
}


-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.contentView addSubview:nameLabel];
        nameLabel.frame = CGRectMake(kMidSpace, kMinSpace*3, SCREEN_WIDTH-kMidSpace*2-W_RATIO(20)*2, W_RATIO(30));
        nameLabel.font = FONT(26);
    }
    return _nameLabel;
}

-(UILabel *)typeLabel{
    if (!_typeLabel) {
        UILabel *typeLabel = [[UILabel alloc] init];
        _typeLabel = typeLabel;
        [self.contentView addSubview:typeLabel];
        typeLabel.font = FONT(36);
        typeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleArrowButtonSelectClick)];
        [typeLabel addGestureRecognizer:tap];
    }
    return _typeLabel;
}
-(UIButton *)arrowBtn{
    if (!_arrowBtn) {
        UIButton *arrowBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _arrowBtn = arrowBtn;
        [self.contentView addSubview:arrowBtn];
        [arrowBtn addTarget:self action:@selector(handleArrowButtonSelectClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}
-(void)handleArrowButtonSelectClick{
    if (self.didSelectMoneyTypeClickBlock) {
        self.didSelectMoneyTypeClickBlock();
    }
}
-(UILabel *)symbolLabel{
    if (!_symbolLabel) {
        UILabel *symbolLabel =[[UILabel alloc] init];
        _symbolLabel = symbolLabel;
        [self.contentView addSubview:symbolLabel];
        symbolLabel.font = FONT(32);
        symbolLabel.textAlignment = NSTextAlignmentRight;
    }
    return _symbolLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        UILabel *moneyLabel =[[UILabel alloc] init];
        _moneyLabel = moneyLabel;
        moneyLabel.text = @"0.00";
        moneyLabel.font = FONT(66);
        [self.moneyScrollView addSubview:moneyLabel];
    }
    return _moneyLabel;
}
-(UIScrollView *)moneyScrollView{
    if (!_moneyScrollView) {
        UIScrollView *moneyScrollView = [[UIScrollView alloc] init];
        _moneyScrollView = moneyScrollView;
        [self.contentView addSubview:moneyScrollView];
        moneyScrollView.showsHorizontalScrollIndicator = NO;
        moneyScrollView.showsVerticalScrollIndicator = NO;
        moneyScrollView.bounces = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlemoneyScrollViewClick)];
        [moneyScrollView addGestureRecognizer:tap];
    }
    return _moneyScrollView;
}
-(void)handlemoneyScrollViewClick{
    if (self.didSelectMoneyNumClickBlock) {
        self.didSelectMoneyNumClickBlock();
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

@end






