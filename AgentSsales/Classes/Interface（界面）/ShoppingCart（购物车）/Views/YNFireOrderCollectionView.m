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
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = W_RATIO(20);
    flowLayout.itemSize = CGSizeMake(WIDTH(frame)-flowLayout.minimumInteritemSpacing*2, W_RATIO(260));
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = COLOR_EDEDED;
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
    return CGSizeMake(SCREEN_WIDTH, W_RATIO(380));
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNFireOrderHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.dict = @{@"name":@"王大锤",@"phone":@"13631499633",@"address":@"广东省广州市白云区云城西路2208创意园A东1楼整层",@"item":@"平台商品"};
//        headerView.backgroundColor = COLOR_FFFFFF;
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        YNFireOrderFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        footerView.backgroundColor = COLOR_FFFFFF;
        return footerView;
    }
    return nil;
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

@property (nonatomic,weak) UILabel * totalLLabel;
@property (nonatomic,weak) UILabel * totalRLabel;

@property (nonatomic,weak) UILabel * postageLabel;
@property (nonatomic,weak) UILabel * postageRabel;

@property (nonatomic,weak) UILabel * discountLabel;
@property (nonatomic,weak) UILabel * discountRabel;

@property (nonatomic,weak) UILabel * payLLabel;
@property (nonatomic,weak) UILabel * payLRabel;
@end
@implementation YNFireOrderFooterView


@end
