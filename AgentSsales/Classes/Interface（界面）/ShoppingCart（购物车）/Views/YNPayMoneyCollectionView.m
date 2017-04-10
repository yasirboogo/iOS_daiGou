//
//  YNPayMoneyCollectionView.m
//  AgentSsales
//
//  Created by innofive on 17/1/20.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNPayMoneyCollectionView.h"

@interface YNPayMoneyCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSIndexPath * indexPath;

@end

@implementation YNPayMoneyCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = kZero;
    flowLayout.minimumInteritemSpacing = W_RATIO(20);
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = COLOR_EDEDED;
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[YNPayOrderCell class] forCellWithReuseIdentifier:@"orderCell"];
        [self registerClass:[YNPayWayCell class] forCellWithReuseIdentifier:@"wayCell"];
        
        [self registerClass:[YNPayHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [self registerClass:[YNPayFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    }
    return self;
}
-(void)setOrderDict:(NSDictionary *)orderDict{
    _orderDict = orderDict;
    [self reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return [(NSArray*)_orderDict[@"goodsArray"] count];
    }else if (section == 1){
        return self.payArray.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH-W_RATIO(20)*2, W_RATIO(130));
    }else if (indexPath.section == 1){
        return CGSizeMake(SCREEN_WIDTH-W_RATIO(20)*2, W_RATIO(120));
    }
    return CGSizeZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, W_RATIO(90));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH-W_RATIO(20)*2, W_RATIO(100));
    }
    return CGSizeZero;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YNPayOrderCell *orderCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderCell" forIndexPath:indexPath];
        orderCell.backgroundColor = COLOR_FFFFFF;
        [orderCell setViewCornerRadiusWithRectCorner:UIRectCornerAllCorners cornerSize:CGSizeZero];
        if (indexPath.row == 0) {
            [orderCell setViewCornerRadiusWithRectCorner:UIRectCornerTopLeft|UIRectCornerTopRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
        }
        orderCell.dict = _orderDict[@"goodsArray"][indexPath.row];
        return orderCell;
    }else if (indexPath.section == 1){
        YNPayWayCell *wayCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wayCell" forIndexPath:indexPath];
        wayCell.backgroundColor = COLOR_FFFFFF;
        [wayCell setViewCornerRadiusWithRectCorner:UIRectCornerAllCorners cornerSize:CGSizeZero];
        if (indexPath.row == 0) {
            [wayCell setViewCornerRadiusWithRectCorner:UIRectCornerTopLeft|UIRectCornerTopRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
        }else if (indexPath.row == _payArray.count-1){
            [wayCell setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
        }
        wayCell.dict = _payArray[indexPath.row];
        wayCell.isEnable = YES;
        if (_typeIndex == 0 && indexPath.row == 2) {
            wayCell.isEnable = NO;
        }else if (_typeIndex == 1 && (indexPath.row == 0||indexPath.row == 1)){
            wayCell.isEnable = NO;
        }else if (_typeIndex == 2 && indexPath.row != 3){
            wayCell.isEnable = NO;
        }
        wayCell.isSelect = ([indexPath compare:self.indexPath] == NSOrderedSame) ? YES : NO;
        return wayCell;
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        self.indexPath = indexPath;
        [self reloadData];
        if (self.didSelectPayWayCellBlock) {
            self.didSelectPayWayCellBlock(indexPath.row);
        }
    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNPayHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.tips = LocalOrderInfor;
        }else if (indexPath.section == 1){
            headerView.tips = LocalPayWay;
        }
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        if (indexPath.section == 0) {
            YNPayFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
            footerView.realprice = self.payMoney;
            return footerView;
        }
    }
    return nil;
}
-(NSArray<NSDictionary *> *)payArray{
    if (!_payArray) {
        _payArray = @[@{@"payImg":@"zhifubao_gouwuche",@"payWay":LocalAlipay},
                      @{@"payImg":@"weixinhaoyou_fenxiang",@"payWay":LocalWeichat},
                      @{@"payImg":@"malaixiya_yuan",@"payWay":LocalBankcard},
                      @{@"payImg":@"qianbao_gouwuche",@"payWay":LocalMyWallet}];
    }
    return _payArray;
}
@end
@interface YNPayOrderCell ()

@property (nonatomic,weak) UIView * bgView;

@property (nonatomic,weak) UILabel * titleLabel;

@property (nonatomic,weak) UILabel * subTitleLabel;

@property (nonatomic,weak) UILabel * markLabel;

@property (nonatomic,weak) UILabel * priceLabel;

@property (nonatomic,weak) UILabel * amountLabel;

@end
@implementation YNPayOrderCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.titleLabel.text = dict[@"name"];
    self.subTitleLabel.text = dict[@"note"];
    self.markLabel.text = LocalMoneyMark;
    self.priceLabel.text = [NSString decimalNumberWithDouble:dict[@"salesprice"]];
    self.amountLabel.text = [NSString stringWithFormat:@"x%@",dict[@"count"]];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:WIDTHF(_bgView)/2.0];
    self.priceLabel.frame = CGRectMake(WIDTHF(_bgView)-W_RATIO(20)-priceSize.width, W_RATIO(15), priceSize.width, priceSize.height);
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_priceLabel)-markSize.width,MaxYF(_priceLabel)-markSize.height, markSize.width, markSize.height);
    
    CGSize titleSize = [_titleLabel.text calculateHightWithFont:_titleLabel.font maxWidth:0];
    self.titleLabel.frame = CGRectMake(W_RATIO(20),MaxYF(_markLabel)-titleSize.height, XF(_markLabel)-W_RATIO(20)*2, titleSize.height);
    
    CGSize amountSize = [_amountLabel.text calculateHightWithFont:_amountLabel.font maxWidth:WIDTHF(_bgView)/3.0];
    self.amountLabel.frame = CGRectMake(MaxXF(_priceLabel)-amountSize.width, MaxYF(_priceLabel)+kMinSpace, amountSize.width, amountSize.height);
    
    CGSize subTitleSize = [_subTitleLabel.text calculateHightWithFont:_subTitleLabel.font maxWidth:0];
    self.subTitleLabel.frame = CGRectMake(XF(_titleLabel), YF(_amountLabel), XF(_amountLabel)-W_RATIO(20)*2, subTitleSize.height);
    
}
-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView= [[UIView alloc] init];
        _bgView = bgView;
        [self.contentView addSubview:bgView];
        bgView.backgroundColor = COLOR_FFF6E0;
        bgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), WIDTHF(self)-W_RATIO(20)*2, HEIGHTF(self)-W_RATIO(20));
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = W_RATIO(20);
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.bgView addSubview:titleLabel];
        titleLabel.font = FONT(28);
        titleLabel.textColor = COLOR_666666;
    }
    return _titleLabel;
}
-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        UILabel *subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel = subTitleLabel;
        [self.bgView addSubview:subTitleLabel];
        subTitleLabel.font = FONT(24);
        subTitleLabel.textColor = COLOR_999999;
    }
    return _subTitleLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.bgView addSubview:markLabel];
        markLabel.font = FONT(22);
        markLabel.textColor = COLOR_333333;
    }
    return _markLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.bgView addSubview:priceLabel];
        priceLabel.adjustsFontSizeToFitWidth = YES;
        priceLabel.font = FONT(32);
        priceLabel.textColor = COLOR_333333;
    }
    return _priceLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] init];
        _amountLabel = amountLabel;
        [self.bgView addSubview:amountLabel];
        amountLabel.font = FONT(30);
        amountLabel.textColor = COLOR_999999;
    }
    return _amountLabel;
}
@end
@interface YNPayWayCell ()

@property (nonatomic,weak) UIImageView * payImgView;

@property (nonatomic,weak) UILabel * paymentLabel;

@property (nonatomic,weak) UIButton * paymentBtn;

@end

@implementation YNPayWayCell

-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    self.paymentBtn.selected = isSelect;
}
-(void)setIsEnable:(BOOL)isEnable{
    _isEnable = isEnable;
    self.payImgView.image = [UIImage imageNamed:_dict[@"payImg"]];
    if (isEnable) {
        self.paymentLabel.text = [NSString stringWithFormat:@"%@",_dict[@"payWay"]];
        self.userInteractionEnabled = YES;
        self.paymentLabel.textColor = COLOR_333333;
    }else{
        self.paymentLabel.text = [NSString stringWithFormat:@"%@%@",_dict[@"payWay"],LocalNoSupport];
        self.userInteractionEnabled = NO;
        self.paymentLabel.textColor = COLOR_999999;
    }
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
        paymentLabel.adjustsFontSizeToFitWidth = YES;
        paymentLabel.textColor = COLOR_333333;
        paymentLabel.frame = CGRectMake(MaxXF(_payImgView)+kMidSpace,
                                        0,
                                        XF(self.paymentBtn)-(MaxXF(_payImgView)+kMidSpace*2),
                                        W_RATIO(120));
    }
    return _paymentLabel;
}

@end
@interface YNPayHeaderView ()

@property (nonatomic,weak) UILabel * tipsLabel;

@end
@implementation YNPayHeaderView

-(void)setTips:(NSString *)tips{
    _tips = tips;
    self.tipsLabel.text = tips;
}

-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self addSubview:tipsLabel];
        tipsLabel.font = FONT(26);
        tipsLabel.textColor = COLOR_929292;
        tipsLabel.frame = CGRectMake(W_RATIO(20),W_RATIO(20),WIDTHF(self)-W_RATIO(20)*2,HEIGHTF(self)-W_RATIO(20));
    }
    return _tipsLabel;
}
@end
@interface YNPayFooterView ()

@property (nonatomic,weak) UIView * bgView;

@property (nonatomic,weak) UILabel * tipsLabel;

@property (nonatomic,weak) UILabel * markLabel;

@property (nonatomic,weak) UILabel * priceLabel;

@end
@implementation YNPayFooterView

-(void)setRealprice:(NSString *)realprice{
    _realprice = realprice;
    self.priceLabel.text = realprice;
    self.markLabel.text = LocalMoneyMark;
    self.tipsLabel.text = LocalPriceTotal;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:WIDTHF(self)/2.0];
    self.priceLabel.frame = CGRectMake(WIDTHF(_bgView)-W_RATIO(20)-priceSize.width, W_RATIO(20), priceSize.width, priceSize.height);
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_priceLabel)-markSize.width, MaxYF(_priceLabel)-markSize.height, markSize.width, markSize.height);
    
    CGSize tipsSize = [_tipsLabel.text calculateHightWithFont:_tipsLabel.font maxWidth:0];
    self.tipsLabel.frame = CGRectMake(W_RATIO(20), MaxYF(_markLabel)-tipsSize.height,XF(_markLabel)-W_RATIO(20)*2, tipsSize.height);
}
-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView =[[UIView alloc] init];
        _bgView = bgView;
        [self addSubview:bgView];
        bgView.backgroundColor = COLOR_FFFFFF;
        bgView.frame = CGRectMake(W_RATIO(20), 0, WIDTHF(self)-W_RATIO(20)*2, HEIGHTF(self));
        [bgView setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    }
    return _bgView;
}

-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self.bgView addSubview:tipsLabel];
        tipsLabel.textAlignment = NSTextAlignmentRight;
        tipsLabel.font = FONT(28);
        tipsLabel.textColor = COLOR_333333;
    }
    return _tipsLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.bgView addSubview:markLabel];
        markLabel.font = FONT(26);
        markLabel.textColor = COLOR_DF463E;
    }
    return _markLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.bgView addSubview:priceLabel];
        priceLabel.font = FONT(40);
        priceLabel.textColor = COLOR_DF463E;
    }
    return _priceLabel;
}
@end
