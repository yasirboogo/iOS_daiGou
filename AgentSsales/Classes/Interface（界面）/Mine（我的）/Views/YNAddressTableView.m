//
//  YNAddressTableView.m
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNAddressTableView.h"

@interface YNAddressTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation YNAddressTableView

-(instancetype)init{
    CGRect frame = CGRectMake(W_RATIO(20), kUINavHeight, SCREEN_WIDTH-W_RATIO(20)*2, SCREEN_HEIGHT-kUINavHeight);
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = COLOR_CLEAR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.frame = CGRectMake(0, 0, WIDTHF(self), kMinSpace);
        self.tableFooterView = footerView;
    }
    return self;
}
-(void)setDataArrayM:(NSMutableArray *)dataArrayM{
    _dataArrayM = dataArrayM;
    _dataArrayM  = [YNAddressCellFrame initWithFromDictionaries:dataArrayM];

    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArrayM.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   YNAddressCellFrame *cellFrame = _dataArrayM[indexPath.row];
    return cellFrame.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YNAddressCell * addressCell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    if (addressCell == nil) {
        addressCell = [[YNAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"addressCell"];
        addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        addressCell.backgroundColor = COLOR_CLEAR;
    }
    addressCell.cellFrame = _dataArrayM[indexPath.row];
    addressCell.isSelect = [addressCell.cellFrame.dict[@"isdefault"] boolValue];
    NSInteger addressId = [addressCell.cellFrame.dict[@"addressId"] integerValue];
    [addressCell setDidSelectButtonClickBlock:^{
        self.didSelectSetDefaultAddressBlock(addressId);
    }];
    [addressCell setDidDelectButtonClickBlock:^{
        self.didSelectSetDelectAddressBlock(addressId);
    }];
    return addressCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.didSelectAddressCellBlock) {
        self.didSelectAddressCellBlock(indexPath);
    }
}

@end

@implementation YNAddressCellFrame

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    CGSize nameSize = [dict[@"name"] calculateHightWithFont:FONT(34) maxWidth:W_RATIO(400)];
    self.nameF = CGRectMake(kMidSpace, kMidSpace, nameSize.width, nameSize.height);
    
    self.phoneF = CGRectMake(MaxX(_nameF)+kMinSpace,Y(_nameF),SCREEN_WIDTH-W_RATIO(20)*2-kMidSpace-MaxX(_nameF)-kMinSpace ,HEIGHT(_nameF));

    CGSize addressSize = [[NSString stringWithFormat:@"%@%@",dict[@"region"],dict[@"detailed"]] calculateHightWithWidth:MaxX(_phoneF)-kMidSpace font:FONT(30)];
    self.addresssF = CGRectMake(X(_nameF),MaxY(_nameF)+W_RATIO(20),addressSize.width,addressSize.height);
    
    CGSize delectSize = [@"删除" calculateHightWithFont:FONT(26) maxWidth:0];
    self.delectF = CGRectMake(MaxX(_addresssF)-delectSize.width, MaxY(_addresssF)+W_RATIO(20), delectSize.width, delectSize.height+W_RATIO(20));
    self.delectBtnF = CGRectMake(X(_delectF)-HEIGHT(_delectF)-kMinSpace, Y(_delectF), HEIGHT(_delectF), HEIGHT(_delectF));
    
    CGSize selectSize = [@"设置为默认地址" calculateHightWithFont:FONT(26) maxWidth:0];
    self.selectBtnF = CGRectMake(X(_addresssF), Y(_delectBtnF), WIDTH(_delectBtnF), HEIGHT(_delectBtnF));
    self.selectF = CGRectMake(MaxX(_selectBtnF)+kMinSpace, Y(_selectBtnF),selectSize.width, HEIGHT(_delectBtnF));
    
    self.bgViewF = CGRectMake(0, W_RATIO(20), SCREEN_WIDTH-W_RATIO(20)*2, MaxY(_selectF)+kMidSpace);
    
    self.cellHeight = MaxY(_bgViewF);
}

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array{
    
    NSMutableArray *tempArrayM = [NSMutableArray arrayWithArray:array];
    
    NSMutableArray *endArray = [NSMutableArray array];
    
    [tempArrayM enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        YNAddressCellFrame *cellFrame = [[YNAddressCellFrame alloc] init];
        cellFrame.dict = dict;
        [endArray addObject:cellFrame];
    }];
    
    return endArray;
}

@end

@interface YNAddressCell ()
/** 背景图 */
@property (nonatomic,strong) UIView *bgView;
/** 姓名 */
@property (nonatomic,strong) UILabel *nameLabel;
/** 电话 */
@property (nonatomic,strong) UILabel *phoneLabel;
/** 地址 */
@property (nonatomic,strong) UILabel *addressLabel;
/** 选择按钮 */
@property (nonatomic,strong) UIButton *selectBtn;
/** 选择 */
@property (nonatomic,strong) UILabel *selectLabel;
/** 删除按钮 */
@property (nonatomic,strong) UIButton *delectBtn;
/** 删除 */
@property (nonatomic,strong) UILabel *delectLabel;

@end

@implementation YNAddressCell

-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    self.selectBtn.selected = isSelect;
    if (isSelect) {
        self.selectLabel.textColor = COLOR_DF463E;
    }else{
        self.selectLabel.textColor = COLOR_999999;
    }
}

-(void)setCellFrame:(YNAddressCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    
    [self setupCellFrame:cellFrame];
    
    [self setupCellContent:cellFrame];
    
}

-(void)setupCellFrame:(YNAddressCellFrame*)cellFrame{
    self.bgView.frame = cellFrame.bgViewF;
    self.nameLabel.frame = cellFrame.nameF;
    self.phoneLabel.frame = cellFrame.phoneF;
    self.addressLabel.frame = cellFrame.addresssF;
    
    self.selectBtn.frame = cellFrame.selectBtnF;
    self.selectLabel.frame = cellFrame.selectF;
    self.delectLabel.frame = cellFrame.delectF;
    self.delectBtn.frame = cellFrame.delectBtnF;
}
-(void)setupCellContent:(YNAddressCellFrame*)cellFrame{
    
    self.nameLabel.text = cellFrame.dict[@"name"];
    self.phoneLabel.text = cellFrame.dict[@"phone"];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@",cellFrame.dict[@"region"],cellFrame.dict[@"detailed"]];
    self.selectLabel.text = @"设为默认地址";
    self.delectLabel.text = @"删除";

}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView= bgView;
        [self.contentView addSubview:bgView];
        bgView.layer.cornerRadius = W_RATIO(20);
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = COLOR_FFFFFF;
    }
    return _bgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.bgView addSubview:nameLabel];
        nameLabel.font = FONT(34);
        nameLabel.textColor = COLOR_333333;
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        UILabel *phoneLabel = [[UILabel alloc] init];
        _phoneLabel = phoneLabel;
        [self.bgView addSubview:phoneLabel];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        phoneLabel.font = FONT(34);
        phoneLabel.textColor = COLOR_333333;
    }
    return _phoneLabel;
}
-(UILabel *)addressLabel{
    if (!_addressLabel) {
        UILabel *addressLabel = [[UILabel alloc] init];
        _addressLabel = addressLabel;
        [self.bgView addSubview:addressLabel];
        addressLabel.numberOfLines = 0;
        addressLabel.font = FONT(30);
        addressLabel.textColor = COLOR_333333;
    }
    return _addressLabel;
}
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn = selectBtn;
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_kui_gouwuche"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"gou_hong_gouwuche"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(handleSelectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:selectBtn];
    }
    return _selectBtn;
}
-(UILabel *)selectLabel{
    if (!_selectLabel) {
        UILabel *selectLabel = [[UILabel alloc] init];
        _selectLabel = selectLabel;
        [self.bgView addSubview:selectLabel];
        selectLabel.font = FONT(26);
        selectLabel.textColor = COLOR_999999;
        selectLabel.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSelectButtonClick)];
        [selectLabel addGestureRecognizer:tap];
    }
    return _selectLabel;
}

-(void)handleSelectButtonClick{
    if (self.didSelectButtonClickBlock) {
        self.didSelectButtonClickBlock();
    }
}
-(UIButton *)delectBtn{
    if (!_delectBtn) {
        UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delectBtn = delectBtn;
        [delectBtn setBackgroundImage:[UIImage imageNamed:@"shanchujilui_fanhu"] forState:UIControlStateNormal];
        [delectBtn addTarget:self action:@selector(handleDelectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:delectBtn];
    }
    return _delectBtn;
}
-(UILabel *)delectLabel{
    if (!_delectLabel) {
        UILabel *delectLabel = [[UILabel alloc] init];
        _delectLabel = delectLabel;
        [self.bgView addSubview:delectLabel];
        delectLabel.font = FONT(26);
        delectLabel.textColor = COLOR_999999;
        delectLabel.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDelectButtonClick)];
        [delectLabel addGestureRecognizer:tap];
    }
    return _delectLabel;
}
-(void)handleDelectButtonClick{
    if (self.didDelectButtonClickBlock && !self.isSelect) {//默认地址无法删除
        self.didDelectButtonClickBlock();
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












