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
    flowLayout.itemSize = CGSizeMake(WIDTH(frame)-flowLayout.minimumInteritemSpacing*2, W_RATIO(260));
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
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, W_RATIO(170)+W_RATIO(100));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (self.index == 0) {
        return CGSizeMake(SCREEN_WIDTH,  W_RATIO(100)+W_RATIO(20)*2);
    }else if (self.index == 1){
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(100)+W_RATIO(20)*2+W_RATIO(300));
    }
    return CGSizeZero;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNFireOrderHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.dict = @{@"name":@"王大锤",@"phone":@"13631499633",@"address":@"广东省广州市白云区云城西路2208创意园A东1楼整层",@"item":@"平台商品"};
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        YNFireOrderFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        footerView.postWay = self.postWay;
        [footerView setDidSelectPostWayBlock:^{
            self.didSelectPostWayBlock();
        }];
        if (self.index == 0) {
            
        }else if (self.index == 1){
            footerView.dict = @{@"num":@"2",
                                @"total":@"502.64",
                                @"postage":@"10",
                                @"discount":@"12.54",
                                @"pay":@"452.02"};
        }
        return footerView;
    }
    return nil;
}
-(void)setPostWay:(NSString *)postWay{
    _postWay = postWay;
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
    fireCell.dict = _dataArray[indexPath.row];
    return fireCell;
}
@end

@interface YNFireOrderCell ()
/** 背景 */
@property (nonatomic,weak) UIView * bgView;
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
    self.leftImgView.image = [UIImage imageNamed:dict[@"image"]];
    self.titleLabel.text = dict[@"title"];
    self.subTitleLabel.text = dict[@"subTitle"];
    self.markLabel.text = NSLS(@"moneySymbol", @"货币符号");
    self.priceLabel.text = dict[@"price"];
    self.amountLabel.text = [NSString stringWithFormat:@"x%@",dict[@"amount"]];
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

-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView * leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        [self.bgView addSubview:leftImgView];
        leftImgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), W_RATIO(220), W_RATIO(220));
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

@property (nonatomic,weak) UILabel * itemLabel;

@end
@implementation YNFireOrderHeaderView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.mapImgView.image = [UIImage imageNamed:@"dingwei_gouwuche"];
    self.arrowImgView.image = [UIImage imageNamed:@"mianbaoxie_you_gouwuche"];
    self.nameLabel.text = dict[@"name"];
    self.phoneLabel.text = dict[@"phone"];
    self.addressLabel.text = dict[@"address"];
    self.itemLabel.text = dict[@"item"];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize nameSize = [_nameLabel.text calculateHightWithFont:_nameLabel.font maxWidth:W_RATIO(300)];
    self.nameLabel.frame = CGRectMake(MaxXF(_mapImgView)+kMidSpace, W_RATIO(30), nameSize.width, nameSize.height);
    
    self.phoneLabel.frame = CGRectMake(MaxXF(_nameLabel)+kMinSpace, YF(_nameLabel), XF(_arrowImgView)-kMidSpace-(MaxXF(_nameLabel)+kMinSpace), HEIGHTF(_nameLabel));

    CGSize addressSize = [_addressLabel.text calculateHightWithWidth:MaxXF(_phoneLabel)-XF(_nameLabel) font:_addressLabel.font];
    self.addressLabel.frame = CGRectMake(XF(_nameLabel), MaxYF(_nameLabel)+kMinSpace, addressSize.width, addressSize.height);
    
    CGSize itemSize = [_itemLabel.text calculateHightWithWidth:WIDTHF(self)-W_RATIO(20)*2 font:_itemLabel.font];
    self.itemLabel.frame = CGRectMake(W_RATIO(20), MaxYF(_topView)+W_RATIO(50), itemSize.width, itemSize.height);
}
-(UIView *)topView{
    if (!_topView) {
        UIView *topView = [[UIView alloc] init];
        _topView = topView;
        [self addSubview:topView];
        topView.backgroundColor = COLOR_FFFFFF;
        topView.frame = CGRectMake(0, 0, WIDTHF(self), W_RATIO(170));
    }
    return _topView;
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
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.textColor = COLOR_333333;
        nameLabel.font = FONT(26);
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        UILabel *phoneLabel = [[UILabel alloc] init];
        _phoneLabel =  phoneLabel;
        [self.topView addSubview:phoneLabel];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        phoneLabel.textColor = COLOR_333333;
        phoneLabel.font = FONT(26);
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
-(UILabel *)itemLabel{
    if (!_itemLabel) {
        UILabel *itemLabel = [[UILabel alloc] init];
        _itemLabel =  itemLabel;
        [self.topView addSubview:itemLabel];
        itemLabel.textColor = COLOR_999999;
        itemLabel.font = FONT(26);
    }
    return _itemLabel;
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
@property (nonatomic,weak) UILabel * discountLLabel;
@property (nonatomic,weak) UILabel * discountRLabel;

@property (nonatomic,weak) UILabel * markPayLabel;
@property (nonatomic,weak) UILabel * payLLabel;
@property (nonatomic,weak) UILabel * payRLabel;
@end
@implementation YNFireOrderFooterView

-(void)setPostWay:(NSString *)postWay{
    _postWay = postWay;
    self.wayLabel.text = @"配运方式";
    self.arrowImgView.image = [UIImage imageNamed:@"mianbaoxie_you_gouwuche"];
    self.priceLabel.text = postWay;
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;

    self.totalRLabel.text = dict[@"total"];
    self.markTotalLabel.text = @"￥";
    self.totalLLabel.text = [NSString stringWithFormat:@"%@件商品，共计:",dict[@"num"]];
    
    self.postageLLabel.text = @"邮费:";
    self.postageRLabel.text = dict[@"postage"];
    self.markPostageLabel.text = _markTotalLabel.text;
    
    self.discountLLabel.text = @"优惠券抵扣";
    self.discountRLabel.text = dict[@"discount"];
    self.markDiscountLabel.text = _markTotalLabel.text;
    
    self.payLLabel.text = @"应付金额";
    self.payRLabel.text = dict[@"pay"];
    self.markPayLabel.text = _markTotalLabel.text;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize totalRSize = [_totalRLabel.text calculateHightWithFont:_totalRLabel.font maxWidth:WIDTHF(self)/2.0];
    self.totalRLabel.frame = CGRectMake(WIDTHF(self)-W_RATIO(30)-totalRSize.width,MaxYF(_topView)+kMidSpace,totalRSize.width, totalRSize.height);
    CGSize markSize = [_markTotalLabel.text calculateHightWithFont:_markTotalLabel.font maxWidth:0];
    self.markTotalLabel.frame = CGRectMake(XF(_totalRLabel)-markSize.width, MaxYF(_totalRLabel)-markSize.height, markSize.width, markSize.height);
    CGSize totalLSize = [_totalLLabel.text calculateHightWithFont:_totalLLabel.font maxWidth:XF(_markTotalLabel)-W_RATIO(30)*2];
    self.totalLLabel.frame = CGRectMake(W_RATIO(30), MaxYF(_markTotalLabel)-totalLSize.height,XF(_markTotalLabel)-W_RATIO(20)-XF(_totalLLabel), totalLSize.height);
    
    CGSize postageRSize = [_postageRLabel.text calculateHightWithFont:_postageRLabel.font maxWidth:WIDTHF(self)/2.0];
    self.postageRLabel.frame = CGRectMake(MaxXF(_totalRLabel)-postageRSize.width, MaxYF(_totalRLabel)+W_RATIO(20),postageRSize.width,postageRSize.height);
    self.markPostageLabel.frame = CGRectMake(XF(_postageRLabel)-markSize.width, MaxYF(_postageRLabel)-markSize.height, markSize.width, markSize.height);
    self.postageLLabel.frame = CGRectMake(XF(_totalLLabel),MaxYF(_markPostageLabel)-totalLSize.height, XF(_markPostageLabel)-W_RATIO(20)-XF(_totalLLabel), totalLSize.height);

    CGSize discountRSize = [_discountRLabel.text calculateHightWithFont:_discountRLabel.font maxWidth:WIDTHF(self)/2.0];
    self.discountRLabel.frame = CGRectMake(MaxXF(_postageRLabel)-discountRSize.width, MaxYF(_postageRLabel)+W_RATIO(20),discountRSize.width,discountRSize.height);
    self.markDiscountLabel.frame = CGRectMake(XF(_discountRLabel)-markSize.width, MaxYF(_discountRLabel)-markSize.height, markSize.width, markSize.height);
    self.discountLLabel.frame = CGRectMake(XF(_totalLLabel),MaxYF(_markDiscountLabel)-totalLSize.height, XF(_markDiscountLabel)-W_RATIO(20)-XF(_totalLLabel), totalLSize.height);
    
    CGSize payRSize = [_payRLabel.text calculateHightWithFont:_payRLabel.font maxWidth:WIDTHF(self)/2.0];
    self.payRLabel.frame = CGRectMake(MaxXF(_discountRLabel)-payRSize.width, MaxYF(_discountRLabel)+W_RATIO(20),payRSize.width,payRSize.height);
    self.markPayLabel.frame = CGRectMake(XF(_payRLabel)-markSize.width, MaxYF(_payRLabel)-markSize.height, markSize.width, markSize.height);
    CGSize payLSize = [_payLLabel.text calculateHightWithFont:_discountRLabel.font maxWidth:0];
    self.payLLabel.frame = CGRectMake(XF(_totalLLabel),MaxYF(_markPayLabel)-payLSize.height, XF(_markDiscountLabel)-W_RATIO(20)-XF(_totalLLabel), payLSize.height);
    
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
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureClick)];
        [topView addGestureRecognizer:tapGesture];
    }
    return _topView;
}
-(void)handleTapGestureClick{
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
-(UILabel *)discountLLabel{
    if (!_discountLLabel) {
        UILabel *discountLLabel = [[UILabel alloc] init];
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
