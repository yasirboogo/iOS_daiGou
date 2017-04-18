//
//  YNFireOrderCollectionView.m
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNFireOrderCollectionView.h"

@interface YNFireOrderCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation YNFireOrderCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = kZero;
    flowLayout.minimumInteritemSpacing = W_RATIO(20);
    flowLayout.itemSize = CGSizeMake(WIDTH(frame)-flowLayout.minimumInteritemSpacing*2, W_RATIO(320));
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = COLOR_EDEDED;
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[YNFireOrderCell class] forCellWithReuseIdentifier:@"fireCell"];
        
        [self registerClass:[YNFireOrderHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [self registerClass:[YNFireOrderFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    }
    return self;
}
-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    [self reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [(NSArray*)_dataDict[@"goodsArray"] count];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, W_RATIO(170)+W_RATIO(20));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, W_RATIO(100)+W_RATIO(20)*2+W_RATIO(300));
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNFireOrderHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.dict = _dataDict;
        [headerView setDidSelectAddressBlock:^{
            self.didSelectAddressBlock();
        }];
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        YNFireOrderFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        footerView.postWay = self.postWay;
        footerView.postMoney = self.postMoney;
        footerView.statusIndex = self.status;
        NSInteger count = 0;
        for (NSDictionary *dict in _dataDict[@"goodsArray"]) {
            count += [dict[@"count"] integerValue];
        }
        footerView.allCount = count;
        
        footerView.allPrice = [NSString stringWithFormat:@"%@",_dataDict[@"totalprice"]];
        footerView.postMoney = self.postMoney;
        footerView.subMoney = self.subMoney;
        [footerView setDidSelectDiscountBlock:^{
            if (self.didSelectDiscountBlock) {
                self.didSelectDiscountBlock([NSString stringWithFormat:@"%@",_dataDict[@"totalprice"]]);
            }
        }];
        [footerView setDidSelectPostWayBlock:^{
            self.didSelectPostWayBlock();
        }];
        return footerView;
    }
    return nil;
}
-(void)setPostWay:(NSString *)postWay{
    _postWay = postWay;
    [self reloadData];
}
-(void)setSubMoney:(NSString *)subMoney{
    _subMoney = subMoney;
    [self reloadData];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YNFireOrderCell *fireCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fireCell" forIndexPath:indexPath];
    [fireCell setViewCornerRadiusWithRectCorner:UIRectCornerAllCorners  cornerSize:CGSizeZero];
    if (indexPath.row == 0) {
        [fireCell setViewCornerRadiusWithRectCorner:UIRectCornerTopLeft|UIRectCornerTopRight  cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    }else{
        [fireCell setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight  cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    }
    fireCell.dict = _dataDict[@"goodsArray"][indexPath.row];
    return fireCell;
}
@end

@interface YNFireOrderCell ()
/** 背景 */
@property (nonatomic,weak) UIView * bgView;
/** 类型 */
@property (nonatomic,weak) UILabel * typeLabel;
/** 左边图片 */
@property (nonatomic,weak) UIImageView * leftImgView;
/** 标题 */
@property (nonatomic,weak) UILabel * titleLabel;
/** 副标题 */
@property (nonatomic,weak) UILabel * subTitleLabel;
/** ￥符号 */
@property (nonatomic,weak) UILabel * markLabel;
/** 价钱 */
@property (nonatomic,weak) UILabel * priceLabel;
/** 数量 */
@property (nonatomic,weak) UILabel * amountLabel;

@end

@implementation YNFireOrderCell
-(void)layoutSubviews{
    [super layoutSubviews];
    //控件布局
    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:WIDTHF(self.contentView)-MaxXF(_leftImgView)-W_RATIO(20)*2 font:_titleLabel.font line:_titleLabel.numberOfLines];
    _titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(20), YF(_leftImgView)+kMinSpace, titleSize.width,titleSize.height);
    
    CGSize subTitleSize = [_subTitleLabel.text calculateHightWithWidth:WIDTHF(_titleLabel) font:_subTitleLabel.font line:_subTitleLabel.numberOfLines];
    _subTitleLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_titleLabel)+kMinSpace, subTitleSize.width,subTitleSize.height);
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_subTitleLabel),MaxYF(_leftImgView)-markSize.height-W_RATIO(20), markSize.width,markSize.height);
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
    self.priceLabel.frame = CGRectMake(MaxXF(_markLabel),MaxYF(_markLabel)-priceSize.height, priceSize.width,priceSize.height);
    self.amountLabel.frame = CGRectMake(MaxXF(_priceLabel)+kMinSpace, YF(_priceLabel),WIDTHF(self.contentView)-MaxXF(_priceLabel)-kMidSpace-kMinSpace, HEIGHTF(_priceLabel));
    
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.typeLabel.text = dict[@"type"];
    [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];

    self.titleLabel.text = dict[@"name"];
    self.subTitleLabel.text = dict[@"note"];
    self.markLabel.text = LocalMoneyMark;
    self.priceLabel.text = [NSString decimalNumberWithDouble:dict[@"salesprice"]];
    self.amountLabel.text = [NSString stringWithFormat:@"x%@",dict[@"count"]];
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        [self.contentView addSubview:bgView];
        bgView.backgroundColor = COLOR_FFFFFF;
        bgView.frame = CGRectMake(0, 0, WIDTHF(self.contentView), HEIGHTF(self.contentView));
    }
    return _bgView;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        UILabel * typeLabel = [[UILabel alloc] init];
        _typeLabel = typeLabel;
        [self.bgView addSubview:typeLabel];
        typeLabel.font = FONT(26);
        typeLabel.textColor = COLOR_999999;
        typeLabel.frame = CGRectMake(W_RATIO(20), W_RATIO(20), WIDTHF(_bgView)-W_RATIO(20)*2, kMidSpace);
    }
    return _typeLabel;
}
-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView * leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        [self.bgView addSubview:leftImgView];
        leftImgView.frame = CGRectMake(W_RATIO(20),MaxYF(self.typeLabel)+W_RATIO(20), W_RATIO(220), W_RATIO(220));
    }
    return _leftImgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel * titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.bgView addSubview:titleLabel];
        titleLabel.font = FONT(32);
        titleLabel.numberOfLines = 1;
        titleLabel.textColor = COLOR_333333;
    }
    return _titleLabel;
}
-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        UILabel * subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel = subTitleLabel;
        [self.bgView addSubview:subTitleLabel];
        subTitleLabel.font = FONT(26);
        subTitleLabel.textColor = COLOR_999999;
        subTitleLabel.numberOfLines = 2;
    }
    return _subTitleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel * priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.bgView addSubview:priceLabel];
        priceLabel.font = FONT(34);
        priceLabel.textColor = COLOR_666666;
    }
    return _priceLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.bgView addSubview:markLabel];
        markLabel.font = FONT(22);
        markLabel.textColor = COLOR_666666;
    }
    return _markLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] init];
        _amountLabel = amountLabel;
        [self.bgView addSubview:amountLabel];
        amountLabel.font = FONT(48);
        amountLabel.textAlignment = NSTextAlignmentRight;
        amountLabel.textColor = COLOR_000000;
    }
    return _amountLabel;
}
@end
@interface YNFireOrderHeaderView ()

@property (nonatomic,weak) UIView * topView;

@property (nonatomic,weak) UIImageView * mapImgView;

@property (nonatomic,weak) UILabel * nameLabel;

@property (nonatomic,weak) UILabel * phoneLabel;

@property (nonatomic,weak) UILabel * addressLabel;

@property (nonatomic,weak) UIImageView * arrowImgView;

@end
@implementation YNFireOrderHeaderView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.mapImgView.image = [UIImage imageNamed:@"dingwei_gouwuche"];
    self.arrowImgView.image = [UIImage imageNamed:@"mianbaoxie_you_gouwuche"];

    if (dict[@"name"]) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@",dict[@"name"]];
    }else{
        self.nameLabel.text = [NSString stringWithFormat:@"%@",@"请选择"];
    }
    if (dict[@"phone"]) {
        self.phoneLabel.text = [NSString stringWithFormat:@"%@",dict[@"phone"]];
    }else{
        self.phoneLabel.text = [NSString stringWithFormat:@"%@",@"请选择"];
    }
    if (dict[@"country"]) {
        NSString *country = dict[@"country"]?dict[@"country"]:@"";
        NSString *province = dict[@"province"]?dict[@"province"]:@"";
        NSString *city = dict[@"city"]?dict[@"city"]:@"";
        NSString *area = dict[@"area"]?dict[@"area"]:@"";
        NSString *detailed = dict[@"detailed"]?dict[@"detailed"]:@"";
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",country,province,city,area,detailed];
    }else{
        self.addressLabel.text = [NSString stringWithFormat:@"%@",@"请选择"];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize nameSize = [_nameLabel.text calculateHightWithFont:_nameLabel.font maxWidth:W_RATIO(300)];
    self.nameLabel.frame = CGRectMake(MaxXF(_mapImgView)+kMidSpace, W_RATIO(30), W_RATIO(300), nameSize.height);
    
    self.phoneLabel.frame = CGRectMake(MaxXF(_nameLabel)+kMinSpace, YF(_nameLabel), XF(_arrowImgView)-kMidSpace-(MaxXF(_nameLabel)+kMinSpace), HEIGHTF(_nameLabel));

    CGSize addressSize = [_addressLabel.text calculateHightWithWidth:MaxXF(_phoneLabel)-XF(_nameLabel) font:_addressLabel.font];
    self.addressLabel.frame = CGRectMake(XF(_nameLabel), MaxYF(_nameLabel)+kMinSpace, addressSize.width, addressSize.height);
}
-(UIView *)topView{
    if (!_topView) {
        UIView *topView = [[UIView alloc] init];
        _topView = topView;
        [self addSubview:topView];
        topView.backgroundColor = COLOR_FFFFFF;
        topView.frame = CGRectMake(0, 0, WIDTHF(self), W_RATIO(170));
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAddressTapGestureClick)];
        [topView addGestureRecognizer:tapGesture];
    }
    return _topView;
}
-(void)handleAddressTapGestureClick{
    if (self.didSelectAddressBlock) {
        self.didSelectAddressBlock();
    }
}
-(UIImageView *)mapImgView{
    if (!_mapImgView) {
        UIImageView *mapImgView = [[UIImageView alloc] init];
        _mapImgView = mapImgView;
        [self.topView addSubview:mapImgView];
        mapImgView.frame = CGRectMake(kMidSpace, (HEIGHTF(_topView)-W_RATIO(50)*1.25)/2.0, W_RATIO(50), W_RATIO(50)*1.25);
    }
    return _mapImgView;
}
-(UIImageView *)arrowImgView{
    if (!_arrowImgView) {
        UIImageView *arrowImgView = [[UIImageView alloc] init];
        _arrowImgView = arrowImgView;
        [self.topView addSubview:arrowImgView];
        arrowImgView.frame = CGRectMake(WIDTHF(self)-W_RATIO(20)-W_RATIO(14), (HEIGHTF(_topView)-W_RATIO(24))/2.0, W_RATIO(14), W_RATIO(24));
    }
    return _arrowImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel =  nameLabel;
        [self.topView addSubview:nameLabel];
        nameLabel.font = FONT(26);
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.textColor = COLOR_333333;
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        UILabel *phoneLabel = [[UILabel alloc] init];
        _phoneLabel =  phoneLabel;
        [self.topView addSubview:phoneLabel];
        phoneLabel.font = FONT(26);
        phoneLabel.textAlignment = NSTextAlignmentRight;
        phoneLabel.textColor = COLOR_333333;
    }
    return _phoneLabel;
}
-(UILabel *)addressLabel{
    if (!_addressLabel) {
        UILabel *addressLabel = [[UILabel alloc] init];
        _addressLabel =  addressLabel;
        [self.topView addSubview:addressLabel];
        addressLabel.numberOfLines = 0;
        addressLabel.textColor = COLOR_333333;
        addressLabel.font = FONT(28);
    }
    return _addressLabel;
}
@end
@interface YNFireOrderFooterView ()

@property (nonatomic,weak) UIView * topView;
@property (nonatomic,weak) UILabel * wayLabel;
@property (nonatomic,weak) UILabel * priceLabel;
@property (nonatomic,weak) UIImageView * arrowImgView;

@property (nonatomic,weak) UILabel * markTotalLabel;
@property (nonatomic,weak) UILabel * totalLLabel;
@property (nonatomic,weak) UILabel * totalRLabel;

@property (nonatomic,weak) UILabel * markPostageLabel;
@property (nonatomic,weak) UILabel * postageLLabel;
@property (nonatomic,weak) UILabel * postageRLabel;

@property (nonatomic,weak) UILabel * markDiscountLabel;
@property (nonatomic,weak) YYLabel * discountLLabel;
@property (nonatomic,weak) UILabel * discountRLabel;

@property (nonatomic,weak) UILabel * markPayLabel;
@property (nonatomic,weak) UILabel * payLLabel;
@property (nonatomic,weak) UILabel * payRLabel;
@end
@implementation YNFireOrderFooterView

-(void)setStatusIndex:(NSInteger)statusIndex{
    _statusIndex = statusIndex;
    self.wayLabel.text = LocalPostWay;
    self.arrowImgView.image = [UIImage imageNamed:@"mianbaoxie_you_gouwuche"];
    if (statusIndex == 1) {
        self.priceLabel.text = [NSString stringWithFormat:@"%@",self.postWay];
    }else if (statusIndex == 2){
        self.priceLabel.text = [NSString stringWithFormat:@"%@%@%@",self.postWay,self.postMoney,LocalMoneyType];
    }
}

-(void)setAllCount:(NSInteger)allCount{
    _allCount = allCount;
    self.totalLLabel.text = [NSString stringWithFormat:@"%ld%@",(long)allCount,LocalGoodsTotal];
    self.postageLLabel.text = LocalPostMoney;
    
    UIFont *font = FONT(28);
    NSMutableAttributedString *attachText = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:LocalCouponDeduction attributes:@{NSForegroundColorAttributeName:COLOR_666666,NSFontAttributeName:font}];
    [attachText appendAttributedString:str1];
    
    if (self.statusIndex == 1) {
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:LocalNotSupportTips attributes:@{NSForegroundColorAttributeName:COLOR_DF463E,NSFontAttributeName:font}];
        [attachText appendAttributedString:str2];
    }else if (self.statusIndex == 2){
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:LocalSelectCoupon attributes:@{NSForegroundColorAttributeName:COLOR_DF463E,NSFontAttributeName:font}];
        YYTextHighlight *highlight = [YYTextHighlight new];
        [str2 setTextHighlight:highlight range:str2.rangeOfAll];
        [attachText appendAttributedString:str2];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            if (self.didSelectDiscountBlock) {
                self.didSelectDiscountBlock();
            }
        };
    }
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@":" attributes:@{NSForegroundColorAttributeName:COLOR_666666,NSFontAttributeName:font}];
    [attachText appendAttributedString:str3];
    self.discountLLabel.attributedText = attachText;
    
    self.payLLabel.text = LocalPriceTotal;
}
-(void)setAllPrice:(NSString *)allPrice{
    _allPrice = allPrice;
    self.markTotalLabel.text = LocalMoneyMark;
    self.markPostageLabel.text = _markTotalLabel.text;
    self.markDiscountLabel.text = [NSString stringWithFormat:@"-%@",_markTotalLabel.text];
    self.markPayLabel.text = _markTotalLabel.text;
    self.totalRLabel.text = [NSString stringWithFormat:@"%.2f",[allPrice floatValue]];
}
-(void)setPostMoney:(NSString *)postMoney{
    _postMoney = postMoney;
    self.postageRLabel.text = [NSString stringWithFormat:@"%.2f",[postMoney floatValue]];
    self.payRLabel.text = [NSString stringWithFormat:@"%.2f",[self.allPrice floatValue] +[self.postMoney floatValue]-[self.subMoney floatValue]];
    [self layoutSubviews];
}
-(void)setSubMoney:(NSString *)subMoney{
    _subMoney = subMoney;
    self.discountRLabel.text = [NSString stringWithFormat:@"%.2f",[subMoney floatValue]];
    self.payRLabel.text = [NSString stringWithFormat:@"%.2f",[self.allPrice floatValue] +[self.postMoney floatValue]-[self.subMoney floatValue]];
    [self layoutSubviews];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize totalRSize = [_totalRLabel.text calculateHightWithFont:_totalRLabel.font maxWidth:W_RATIO(250)];
    self.totalRLabel.frame = CGRectMake(WIDTHF(self)-W_RATIO(30)-totalRSize.width,MaxYF(_topView)+kMidSpace,totalRSize.width, totalRSize.height);
    CGSize markSize = [_markTotalLabel.text calculateHightWithFont:_markTotalLabel.font maxWidth:0];
    self.markTotalLabel.frame = CGRectMake(XF(_totalRLabel)-markSize.width, MaxYF(_totalRLabel)-markSize.height, markSize.width, markSize.height);
    CGSize totalLSize = [_totalLLabel.text calculateHightWithFont:_totalLLabel.font maxWidth:XF(_markTotalLabel)-W_RATIO(30)*2];
    self.totalLLabel.frame = CGRectMake(W_RATIO(30), MaxYF(_markTotalLabel)-totalLSize.height,XF(_markTotalLabel)-W_RATIO(20)-W_RATIO(30), totalLSize.height);
    
    CGSize postageRSize = [_postageRLabel.text calculateHightWithFont:_postageRLabel.font maxWidth:WIDTHF(self)/2.0];
    self.postageRLabel.frame = CGRectMake(MaxXF(_totalRLabel)-postageRSize.width, MaxYF(_totalRLabel)+W_RATIO(20),postageRSize.width,postageRSize.height);
    self.markPostageLabel.frame = CGRectMake(XF(_postageRLabel)-markSize.width, MaxYF(_postageRLabel)-markSize.height, markSize.width, markSize.height);
    self.postageLLabel.frame = CGRectMake(XF(_totalLLabel),MaxYF(_markPostageLabel)-totalLSize.height, XF(_markPostageLabel)-W_RATIO(20)-XF(_totalLLabel), totalLSize.height);

    CGSize discountRSize = [_discountRLabel.text calculateHightWithFont:_discountRLabel.font maxWidth:WIDTHF(self)/2.0];
    self.discountRLabel.frame = CGRectMake(MaxXF(_postageRLabel)-discountRSize.width, MaxYF(_postageRLabel)+W_RATIO(20),discountRSize.width,discountRSize.height);
    CGSize markDisSize = [_markDiscountLabel.text calculateHightWithFont:_markTotalLabel.font maxWidth:0];
    self.markDiscountLabel.frame = CGRectMake(XF(_discountRLabel)-markDisSize.width, MaxYF(_discountRLabel)-markDisSize.height, markDisSize.width, markDisSize.height);
    self.discountLLabel.frame = CGRectMake(XF(_totalLLabel),MaxYF(_markDiscountLabel)-totalLSize.height, XF(_markDiscountLabel)-W_RATIO(20)-XF(_totalLLabel), totalLSize.height);
    
    CGSize payRSize = [_payRLabel.text calculateHightWithFont:_payRLabel.font maxWidth:WIDTHF(self)/2.0];
    self.payRLabel.frame = CGRectMake(MaxXF(_discountRLabel)-payRSize.width, MaxYF(_discountRLabel)+W_RATIO(20),payRSize.width,payRSize.height);
    self.markPayLabel.frame = CGRectMake(XF(_payRLabel)-markSize.width, MaxYF(_payRLabel)-markSize.height, markSize.width, markSize.height);
    CGSize payLSize = [_payLLabel.text calculateHightWithFont:_discountRLabel.font maxWidth:0];
    self.payLLabel.frame = CGRectMake(XF(_totalLLabel),MaxYF(_markPayLabel)-payLSize.height, XF(_markPayLabel)-W_RATIO(20)-XF(_totalLLabel), payLSize.height);
    
}

-(UIView *)topView{
    if (!_topView) {
        UIView *topView = [[UIView alloc] init];
        _topView = topView;
        [self addSubview:topView];
        topView.backgroundColor = COLOR_FFFFFF;
        topView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), WIDTHF(self)-W_RATIO(20)*2, W_RATIO(100));
        topView.layer.masksToBounds = YES;
        topView.layer.cornerRadius = W_RATIO(20);
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePostWayTapGestureClick)];
        [topView addGestureRecognizer:tapGesture];
    }
    return _topView;
}
-(void)handlePostWayTapGestureClick{
    if (self.didSelectPostWayBlock) {
        self.didSelectPostWayBlock();
    }
}
-(UILabel *)wayLabel{
    if (!_wayLabel) {
        UILabel *wayLabel = [[UILabel alloc] init];
        _wayLabel = wayLabel;
        [self.topView addSubview:wayLabel];
        wayLabel.font = FONT(32);
        wayLabel.textColor = COLOR_999999;
        wayLabel.frame = CGRectMake(W_RATIO(20), 0, WIDTHF(_topView)/3.0, HEIGHTF(_topView));
    }
    return _wayLabel;
}
-(UIImageView *)arrowImgView{
    if (!_arrowImgView) {
        UIImageView *arrowImgView = [[UIImageView alloc] init];
        _arrowImgView = arrowImgView;
        [self.topView addSubview:arrowImgView];
        arrowImgView.frame = CGRectMake(WIDTHF(_topView)-W_RATIO(20)-W_RATIO(24), (HEIGHTF(_topView)-W_RATIO(24))/2.0, W_RATIO(14), W_RATIO(24));
    }
    return _arrowImgView;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        [self.topView addSubview:priceLabel];
        priceLabel.font = FONT(32);
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.textColor = COLOR_333333;
        priceLabel.frame = CGRectMake(MaxXF(_wayLabel),YF(_wayLabel),XF(_arrowImgView)-MaxXF(_wayLabel)-W_RATIO(20)*2, HEIGHTF(_topView));
    }
    return _priceLabel;
}
-(UILabel *)totalLLabel{
    if (!_totalLLabel) {
        UILabel *totalLLabel = [[UILabel alloc] init];
        _totalLLabel = totalLLabel;
        [self addSubview:totalLLabel];
        totalLLabel.font = FONT(28);
        totalLLabel.textColor = COLOR_666666;
    }
    return _totalLLabel;
}
-(UILabel *)totalRLabel{
    if (!_totalRLabel) {
        UILabel *totalRLabel = [[UILabel alloc] init];
        _totalRLabel = totalRLabel;
        [self addSubview:totalRLabel];
        totalRLabel.textAlignment = NSTextAlignmentRight;
        totalRLabel.font = FONT(34);
        totalRLabel.textColor = COLOR_666666;
    }
    return _totalRLabel;
}
-(UILabel *)markTotalLabel{
    if (!_markTotalLabel) {
        UILabel *markTotalLabel = [[UILabel alloc] init];
        _markTotalLabel = markTotalLabel;
        [self addSubview:markTotalLabel];
        markTotalLabel.font = FONT(26);
        markTotalLabel.textColor = COLOR_666666;
    }
    return _markTotalLabel;
}
-(UILabel *)postageLLabel{
    if (!_postageLLabel) {
        UILabel *postageLLabel = [[UILabel alloc] init];
        _postageLLabel = postageLLabel;
        [self addSubview:postageLLabel];
        postageLLabel.font = FONT(28);
        postageLLabel.textColor = COLOR_666666;
    }
    return _postageLLabel;
}
-(UILabel *)postageRLabel{
    if (!_postageRLabel) {
        UILabel *postageRLabel = [[UILabel alloc] init];
        _postageRLabel = postageRLabel;
        [self addSubview:postageRLabel];
        postageRLabel.textAlignment = NSTextAlignmentRight;
        postageRLabel.font = FONT(34);
        postageRLabel.textColor = COLOR_666666;
    }
    return _postageRLabel;
}
-(UILabel *)markPostageLabel{
    if (!_markPostageLabel) {
        UILabel *markPostageLabel = [[UILabel alloc] init];
        _markPostageLabel = markPostageLabel;
        [self addSubview:markPostageLabel];
        markPostageLabel.font = FONT(26);
        markPostageLabel.textColor = COLOR_666666;
    }
    return _markPostageLabel;
}
-(YYLabel *)discountLLabel{
    if (!_discountLLabel) {
        YYLabel *discountLLabel = [[YYLabel alloc] init];
        _discountLLabel = discountLLabel;
        [self addSubview:discountLLabel];
        discountLLabel.font = FONT(28);
        discountLLabel.textColor = COLOR_666666;
    }
    return _discountLLabel;
}
-(UILabel *)discountRLabel{
    if (!_discountRLabel) {
        UILabel *discountRLabel = [[UILabel alloc] init];
        _discountRLabel = discountRLabel;
        [self addSubview:discountRLabel];
        discountRLabel.textAlignment = NSTextAlignmentRight;
        discountRLabel.font = FONT(34);
        discountRLabel.textColor = COLOR_666666;
    }
    return _discountRLabel;
}
-(UILabel *)markDiscountLabel{
    if (!_markDiscountLabel) {
        UILabel *markDiscountLabel = [[UILabel alloc] init];
        _markDiscountLabel = markDiscountLabel;
        [self addSubview:markDiscountLabel];
        markDiscountLabel.font = FONT(26);
        markDiscountLabel.textColor = COLOR_666666;
    }
    return _markDiscountLabel;
}
-(UILabel *)payLLabel{
    if (!_payLLabel) {
        UILabel *payLLabel = [[UILabel alloc] init];
        _payLLabel = payLLabel;
        [self addSubview:payLLabel];
        payLLabel.font = FONT(32);
        payLLabel.textColor = COLOR_333333;
    }
    return _payLLabel;
}
-(UILabel *)payRLabel{
    if (!_payRLabel) {
        UILabel *payRLabel = [[UILabel alloc] init];
        _payRLabel = payRLabel;
        [self addSubview:payRLabel];
        payRLabel.textAlignment = NSTextAlignmentRight;
        payRLabel.font = FONT(38);
        payRLabel.textColor = COLOR_DF463E;
    }
    return _payRLabel;
}
-(UILabel *)markPayLabel{
    if (!_markPayLabel) {
        UILabel *markPayLabel = [[UILabel alloc] init];
        _markPayLabel = markPayLabel;
        [self addSubview:markPayLabel];
        markPayLabel.font = FONT(26);
        markPayLabel.textColor = COLOR_DF463E;
    }
    return _markPayLabel;
}


@end
