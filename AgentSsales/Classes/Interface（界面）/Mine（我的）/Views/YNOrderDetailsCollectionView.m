//
//  YNOrderDetailsCollectionView.m
//  AgentSsales
//
//  Created by innofive on 17/1/16.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNOrderDetailsCollectionView.h"

@interface YNOrderDetailsCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSArray * manMsgArray;
@property (nonatomic,strong) NSArray * orderMsgArray;
@property (nonatomic,strong) NSDictionary * goodsMsgDict;

@end

@implementation YNOrderDetailsCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = W_RATIO(20);
    flowLayout.itemSize = CGSizeMake(WIDTH(frame)-flowLayout.minimumInteritemSpacing*2, W_RATIO(185));
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = COLOR_EDEDED;
        self.dataSource = self;
        self.delegate = self;
    }
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"goodsCell"];
    
    [self registerClass:[YNDetailsManMsgCell class] forCellWithReuseIdentifier:@"manMsgCell"];
    
    [self registerClass:[YNDetailsOrderMsgCell class] forCellWithReuseIdentifier:@"orderMsgCell"];
    
    [self registerClass:[YNOrderDetailsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    
    
//    [self registerClass:[YNOrderGoodsCell class] forCellWithReuseIdentifier:@"goodsCell"];
//    [self registerClass:[YNOrderGoodsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
//    [self registerClass:[YNOrderGoodsFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    return self;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.manMsgArray = [YNManMsgCellFrame initWithFromDictionaries:@[dict[@"manMsg"]]];
    self.orderMsgArray = dict[@"orderMsg"];
    self.goodsMsgDict = dict[@"goodsMsg"];
    [self reloadData];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YNManMsgCellFrame *cellFrame = self.manMsgArray[0];
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2,cellFrame.cellHeight);
    }else if (indexPath.section == 1){
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(70));
    }else if (indexPath.section == 2){
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(185));
    }
    return CGSizeZero;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 5;
    }else if (section == 2){
        return 2;
    }
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(86)+W_RATIO(20));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 2){
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(90));
    }
    return CGSizeZero;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNOrderDetailsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.dict = @{@"image":@"shouhuoren_dingdan",@"tips":@"收货人信息"};
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        footerView.backgroundColor = COLOR_EF697B;
        if (indexPath.section == 2) {
            return footerView;
        }
        return nil;
    }
    return nil;
    
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        YNOrderGoodsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
//        if (indexPath.section == 0) {
//            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待处理"};
//        }else if (indexPath.section == 1){
//            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待付款"};
//        }else if (indexPath.section == 2){
//            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待发货"};
//        }else if (indexPath.section == 3){
//            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待收货"};
//        }else if (indexPath.section == 4){
//            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待评价"};
//        }
//        return headerView;
//    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
//        YNOrderGoodsFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
//        if (indexPath.section == 0) {
//            footerView.dict = @{@"price":@"500.12",@"status":@"待处理"};
//        }else if (indexPath.section == 1){
//            footerView.dict = @{@"price":@"500.12",@"status":@"待付款"};
//        }else if (indexPath.section == 2){
//            footerView.dict = @{@"price":@"500.12",@"status":@"待发货"};
//        }else if (indexPath.section == 3){
//            footerView.dict = @{@"price":@"500.12",@"status":@"待收货"};
//        }else if (indexPath.section == 4){
//            footerView.dict = @{@"price":@"500.12",@"status":@"待评价"};
//        }
//        return footerView;
//    }
//    return nil;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YNDetailsManMsgCell *manMsgCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"manMsgCell" forIndexPath:indexPath];
        manMsgCell.cellFrame = self.manMsgArray[0];
        return manMsgCell;
    }else if (indexPath.section == 1){
        YNDetailsOrderMsgCell *orderMsgCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderMsgCell" forIndexPath:indexPath];
//        orderMsgCell.dict = self.orderMsgArray[indexPath.row];
        if (indexPath.row == 4) {
            [orderMsgCell setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
        }
        return orderMsgCell;
        
    }
    
    UICollectionViewCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsCell" forIndexPath:indexPath];
    goodsCell.backgroundColor = [UIColor colorWithRandom];
//    goodsCell.dict = @{@"image":@"testGoods",@"title":@"书籍-设计师的自我修养",@"subTitle":@"2016年出版版本",@"price":@"501.21",@"amount":@"2"};
    return goodsCell;
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
//    if (self.didSelectOrderGoodsCell) {
//        self.didSelectOrderGoodsCell(@"订单详情");
//    }
//}

@end

@implementation YNManMsgCellFrame

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    CGSize nameSize = [dict[@"name"] calculateHightWithFont:FONT(34) maxWidth:W_RATIO(400)];
    self.nameF = CGRectMake(kMaxSpace, kMidSpace, nameSize.width, nameSize.height);
    
    self.phoneF = CGRectMake(MaxX(_nameF)+kMinSpace,Y(_nameF),SCREEN_WIDTH-W_RATIO(20)*2-kMidSpace-MaxX(_nameF)-kMidSpace ,HEIGHT(_nameF));
    
    CGSize addressSize = [dict[@"address"] calculateHightWithWidth:MaxX(_phoneF)-kMidSpace font:FONT(30)];
    self.addresssF = CGRectMake(X(_nameF),MaxY(_nameF)+W_RATIO(20),addressSize.width,addressSize.height);
    
    self.bgViewF = CGRectMake(0,0, SCREEN_WIDTH-W_RATIO(20)*2, MaxY(_addresssF)+kMidSpace);
    
    self.cellHeight = MaxY(_bgViewF);
}

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array{
    
    NSMutableArray *tempArrayM = [NSMutableArray arrayWithArray:array];
    
    NSMutableArray *endArray = [NSMutableArray array];
    
    [tempArrayM enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        YNManMsgCellFrame *cellFrame = [[YNManMsgCellFrame alloc] init];
        cellFrame.dict = dict;
        [endArray addObject:cellFrame];
    }];
    
    return endArray;
}

@end

@interface YNDetailsManMsgCell ()

@property (nonatomic,weak) UIView *bgView;

@property (nonatomic,weak) UILabel *nameLabel;

@property (nonatomic,weak) UILabel *phoneLabel;

@property (nonatomic,weak) UILabel *addressLabel;

@end
@implementation YNDetailsManMsgCell

-(void)setCellFrame:(YNManMsgCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    
    [self setupCellFrame:cellFrame];
    
    [self setupCellContent:cellFrame];
    
}

-(void)setupCellFrame:(YNManMsgCellFrame*)cellFrame{
    self.bgView.frame = cellFrame.bgViewF;
    self.nameLabel.frame = cellFrame.nameF;
    self.phoneLabel.frame = cellFrame.phoneF;
    self.addressLabel.frame = cellFrame.addresssF;
    
    [_bgView setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];

}
-(void)setupCellContent:(YNManMsgCellFrame*)cellFrame{
    
    self.nameLabel.text = cellFrame.dict[@"name"];
    self.phoneLabel.text = cellFrame.dict[@"phone"];
    self.addressLabel.text = cellFrame.dict[@"address"];
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView= bgView;
        [self.contentView addSubview:bgView];
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


@end
@interface YNDetailsOrderMsgCell ()

@property (nonatomic,weak) UIView *bgView;

//@property (nonatomic,weak) UILabel *itemLabel;
//
//@property (nonatomic,weak) UILabel *detailsLabel;

@end
@implementation YNDetailsOrderMsgCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.itemLabel.text = dict[@"item"];
    self.detailsLabel.text = dict[@"deatils"];
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

-(UILabel *)itemLabel{
    if (!_itemLabel) {
        UILabel *itemLabel =[[UILabel alloc] init];
        _itemLabel = itemLabel;
        [self.bgView addSubview:itemLabel];
        itemLabel.font = FONT(30);
        itemLabel.textColor = COLOR_999999;
        itemLabel.frame = CGRectMake(kMaxSpace, 0, WIDTHF(_bgView)*2/7.0, HEIGHTF(_bgView));
    }
    return _itemLabel;
}
-(UILabel *)detailsLabel{
    if (!_detailsLabel) {
        UILabel *detailsLabel =[[UILabel alloc] init];
        _detailsLabel = detailsLabel;
        [self.bgView addSubview:detailsLabel];
        detailsLabel.font = FONT(30);
        detailsLabel.textColor = COLOR_999999;
        detailsLabel.frame = CGRectMake(MaxXF(_itemLabel)+kMinSpace, YF(_itemLabel), WIDTHF(_bgView)-MaxXF(_itemLabel)-kMidSpace-kMinSpace,HEIGHTF(_itemLabel));
    }
    return _detailsLabel;
}

@end

@interface YNOrderDetailsHeaderView ()

@property (nonatomic,weak) UIView *bgView;

@property (nonatomic,weak) UIImageView *icoImgView;

@property (nonatomic,weak) UILabel *tipsLabel;

@end
@implementation YNOrderDetailsHeaderView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.icoImgView.image = [UIImage imageNamed:dict[@"image"]];
    self.tipsLabel.text = dict[@"tips"];
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        [self addSubview:bgView];
        bgView.backgroundColor = COLOR_FFFFFF;
        bgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), WIDTHF(self)-W_RATIO(20)*2, HEIGHTF(self)-W_RATIO(20));
        [bgView setViewCornerRadiusWithRectCorner:UIRectCornerTopLeft|UIRectCornerTopRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    }
    return _bgView;
}
-(UIImageView *)icoImgView{
    if (!_icoImgView) {
        UIImageView *icoImgView = [[UIImageView alloc] init];
        _icoImgView = icoImgView;
        [self.bgView addSubview:icoImgView];
        icoImgView.frame = CGRectMake(W_RATIO(20), HEIGHTF(_bgView)/4.0,HEIGHTF(_bgView)/2.0, HEIGHTF(_bgView)/2.0);
    }
    return _icoImgView;
}
-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        [self.bgView addSubview:tipsLabel];
        tipsLabel.textColor = COLOR_666666;
        tipsLabel.font = FONT(28);
        tipsLabel.frame = CGRectMake(MaxXF(_icoImgView)+kMinSpace, 0, WIDTHF(_bgView)-MaxXF(_icoImgView)-kMinSpace, HEIGHTF(_bgView));
    }
    return _tipsLabel;
}

@end





























