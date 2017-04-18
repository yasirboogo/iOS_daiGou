//
//  YNHomePageCollectionView.m
//  AgentSsales
//
//  Created by innofive on 16/12/22.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNHomePageCollectionView.h"
#import "ImagesPlayer.h"

#pragma mark - YNHomePageCollectionView ------------------------------------------
@interface YNHomePageCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ImagesPlayerDelegae>

@property (nonatomic,assign) BOOL isShowMoneyRate;

@end

@implementation YNHomePageCollectionView

-(instancetype)init{
    CGRect frame = CGRectMake(0,
                              kUINavHeight,
                              SCREEN_WIDTH,
                              SCREEN_HEIGHT-kUINavHeight-kUITabBarH-W_RATIO(2));
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        //隐藏滑块
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = COLOR_FFFFFF;
        //注册单元格
        [self registerClass:[YNPlatSelectsCell class] forCellWithReuseIdentifier:@"selectCell"];
        [self registerClass:[YNMoneyRatesCell class] forCellWithReuseIdentifier:@"rateCell"];
        [self registerClass:[YNHotClassesCell class] forCellWithReuseIdentifier:@"classCell"];
        [self registerClass:[YNSpecialBuyCell class] forCellWithReuseIdentifier:@"buyCell"];
        [self registerClass:[YNPlayerImgCell class] forCellWithReuseIdentifier:@"playerCell"];
        [self registerClass:[YNRateTypesCell class] forCellWithReuseIdentifier:@"typeCell"];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self registerClass:[YNHeaderBarView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"barHeader"];
        
        [self registerClass:[YNHeaderShowBarView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"showHeader"];
        
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return self;
}
#pragma mark - 代理实现
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.adArray.count){
        return 5;
    }
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 10;
    }else if (section == 2){
        return 3;
    }else if (section == 3){
        return 3;
    }else if (section == 4){
        return _dataArrayM.count;
    }
    return 0;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else if (section == 1){
        return UIEdgeInsetsMake(0, W_RATIO(30), 0, W_RATIO(30));
    }else if (section == 2){
        return UIEdgeInsetsZero;
    }else if (section == 3){
        return UIEdgeInsetsMake(0, W_RATIO(110), W_RATIO(30), W_RATIO(110));
    }else if (section == 4){
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(320));
    }else if (indexPath.section == 1) {
        return CGSizeMake(W_RATIO(100), W_RATIO(175));
    }else if (indexPath.section == 2){
        if (self.isShowMoneyRate) {
            //不做任何操作，隐藏
        }
        else{
            if (indexPath.row == 0) {
                return CGSizeMake(SCREEN_WIDTH, W_RATIO(80));
            }
            return CGSizeMake(SCREEN_WIDTH, W_RATIO(100));
        }
    }else if (indexPath.section == 3){
        return CGSizeMake(W_RATIO(130), W_RATIO(130));
    }else if (indexPath.section == 4){
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(200));
    }
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
    }else if (section == 1) {
    }else if (section == 2){
        return W_RATIO(2);
    }else if (section == 3){
        return W_RATIO(30);
    }else if (section == 4){
        return W_RATIO(30);
    }
    return kZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
    }else if (section == 1) {
        return (SCREEN_WIDTH-W_RATIO(30)*2-W_RATIO(100)*5)/4.0;
    }else if (section == 2){
    }else if (section == 3){
        return (SCREEN_WIDTH-W_RATIO(110)*2-W_RATIO(130)*3)/2.0;
    }else if (section == 4){
        return W_RATIO(8);
    }
    return kZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, W_RATIO(10));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }else{
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(80));
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:
(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YNPlayerImgCell *playerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"playerCell" forIndexPath:indexPath];
        NSMutableArray <NSString*> *imageURLs = [NSMutableArray array];
        [self.adArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            [imageURLs addObject:dict[@"img"]];
        }];
        playerCell.imageURLs = imageURLs;
        [playerCell setDidSelectPlayerImgClickBlock:^(NSInteger index) {
            self.didSelectPlayerImgClickBlock(self.adArray[index][@"url"],[NSString stringWithFormat:@"%@",self.adArray[index][@"type"]]);
        }];
        return playerCell;
    }else if (indexPath.section == 1) {
        YNHotClassesCell *classCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
        if (indexPath.row == 9) {
            classCell.dict = @{@"classimg":@"gengduofenglei",@"classname":LocalMore};
        }else{
            classCell.dict = _hotArray[indexPath.row];
        }
        return classCell;
    }else if (indexPath.section == 2){
        YNRateTypesCell *typeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"typeCell" forIndexPath:indexPath];
        YNMoneyRatesCell *rateCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rateCell" forIndexPath:indexPath];
        if (self.isShowMoneyRate) {
            //不做任何操作，隐藏
        }else{
            if (indexPath.row == 0) {
                typeCell.rmbLabel.text = @"人民币（主）";
                typeCell.buyInLabel.text = @"买进";
                typeCell.sellOutLabel.text = @"卖出";
                return typeCell;
            }
            else{
                if (indexPath.row == 1){
                    rateCell.flagImgView.image = [UIImage imageNamed:@"malaixiya_guoqi"];
                    rateCell.typeLabel.text = @"马来西亚币";
                }else if (indexPath.row == 2){
                    rateCell.flagImgView.image = [UIImage imageNamed:@"meiguo_guoqi"];
                    rateCell.typeLabel.text = @"美元";
                }
                rateCell.buyLabel.text = [NSString stringWithFormat:@"%@",_rateArray[indexPath.row-1][@"buyup"]];
                rateCell.sellLabel.text = [NSString stringWithFormat:@"%@",_rateArray[indexPath.row-1][@"sell"]];
                
                return rateCell;
            }
        }
    }else if (indexPath.section == 3) {
        YNPlatSelectsCell *selectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"selectCell" forIndexPath:indexPath];
        NSArray *platImgs = @[@"taobao_shouye",
                              @"weipinhui_shouye",
                              @"jingdong_shouye"];
        selectCell.platImg = platImgs[indexPath.row];
        return selectCell;
    }else if(indexPath.section == 4) {
        YNSpecialBuyCell *buyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"buyCell" forIndexPath:indexPath];
        buyCell.dict = _dataArrayM[indexPath.row];
        [buyCell setDidBuyNowButtonClickBlock:^{
            if (self.didSelectGoodImgClickBlock) {
                self.didSelectGoodImgClickBlock([NSString stringWithFormat:@"%@",_dataArrayM[indexPath.row][@"id"]]);
            }
        }];
        return buyCell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            return nil;
        }else if (indexPath.section == 1) {
            YNHeaderBarView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"barHeader" forIndexPath:indexPath];
            [headerView setWithTitle:kLocalizedString(@"hotClasses",@"热门分类") leftImg:[UIImage imageNamed:@"hot"] moreImg:[UIImage imageNamed:@"gengduo_kui"] color:COLOR_FFFFFF moreClickBlock:^ {
                self.didSelectMoreBtnClickBlock(indexPath.section);
            }];
            return headerView;
        }else if (indexPath.section == 2){
            YNHeaderShowBarView *showHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"showHeader" forIndexPath:indexPath];
            showHeader.backgroundColor = COLOR_FFFFFF;
            [showHeader setWithTitle:kLocalizedString(@"exchangeRate",@"实时汇率") leftImg:[UIImage imageNamed:@"huilv_shouye"] isShow:self.isShowMoneyRate showClickBlock:^(BOOL isShow) {
                self.isShowMoneyRate = isShow;
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [UIView animateWithDuration:0.5 animations:^{
                    [self reloadSections:indexSet];
                }];
            }];
            return showHeader;
        }else if (indexPath.section == 3){
            YNHeaderBarView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"barHeader" forIndexPath:indexPath];
            [headerView.moreBtn removeFromSuperview];
            [headerView setWithTitle:kLocalizedString(@"purchasePlatform",@"代购平台") leftImg:[UIImage imageNamed:@"daigoupingtai_shouye"] moreImg:nil color:COLOR_FFFFFF moreClickBlock:nil];
            return headerView;
        }else if (indexPath.section == 4){
            YNHeaderBarView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"barHeader" forIndexPath:indexPath];
            [headerView setWithTitle:kLocalizedString(@"specialPurchase", @"特色惠购") leftImg:[UIImage imageNamed:@"tesehuigou"] moreImg:[UIImage imageNamed:@"gengduo_kui"] color:COLOR_FFFFFF moreClickBlock:^ {
                self.didSelectMoreBtnClickBlock(indexPath.section);
            }];
            return headerView;
        }
        return nil;
    }else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerView.backgroundColor = COLOR_EDEDED;
        return footerView;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {//代购平台
        self.didSelectPlatImgClickBlock(indexPath.row);
    }
    else if (indexPath.section == 1){//热门分类
        if (self.didSelectHotClassImgClickBlock) {
            NSInteger index = indexPath.row;
            if (indexPath.row == 9) {
                index = 0;
            }
            self.didSelectHotClassImgClickBlock([NSString stringWithFormat:@"%@",_hotArray[index][@"classId"]],indexPath.row);
        }
    }
    else if(indexPath.section == 4) {//特色惠购可以选择
        if (self.didSelectGoodImgClickBlock) {
            self.didSelectGoodImgClickBlock([NSString stringWithFormat:@"%@",_dataArrayM[indexPath.row][@"id"]]);
        }
    }
}
#pragma mark - 广告页ImagesPlayerDelegae
- (void)imagesPlayer:(ImagesPlayer *)player didSelectImageAtIndex:(NSInteger)index
{
    if (self.didSelectPlayerImgClickBlock) {
        self.didSelectPlayerImgClickBlock(self.adArray[index][@"url"],[NSString stringWithFormat:@"%@",self.adArray[index][@"type"]]);
    }
}

@end

#pragma mark - YNPlayerImgCell ------------------------------------------
@interface YNPlayerImgCell ()<ImagesPlayerDelegae>
@end

@implementation YNPlayerImgCell

-(void)setImageURLs:(NSArray<NSString *> *)imageURLs{
    _imageURLs = imageURLs;
    
    ImagesPlayer *imagesPlayer = [[ImagesPlayer alloc] init];
    imagesPlayer.frame = CGRectMake(0, 0, WIDTHF(self), HEIGHTF(self));
    imagesPlayer.delegate = self;
    imagesPlayer.indicatorView.currentPageIndicatorTintColor = COLOR_DF463E;
    imagesPlayer.indicatorView.pageIndicatorTintColor = COLOR_FFFFFF;
    [imagesPlayer addNetWorkImages:imageURLs placeholder:[UIImage imageNamed:@"zhanwei2"]];
    [self.contentView addSubview:imagesPlayer];
}
#pragma mark 广告页ImagesPlayerDelegae
- (void)imagesPlayer:(ImagesPlayer *)player didSelectImageAtIndex:(NSInteger)index
{
    if (self.didSelectPlayerImgClickBlock) {
        self.didSelectPlayerImgClickBlock(index);
    }
}
@end
#pragma mark - YNPlatSelectsCell ------------------------------------------
@interface YNPlatSelectsCell ()

@property(nonatomic,weak)UIImageView *platImgView;

@end

@implementation YNPlatSelectsCell

-(void)setPlatImg:(NSString *)platImg{
    _platImg = platImg;
    self.platImgView.image = [UIImage imageNamed:platImg];
}
-(UIImageView *)platImgView{
    if (!_platImgView) {
        UIImageView * platImgView = [[UIImageView alloc] init];
        _platImgView = platImgView;
        platImgView.frame = CGRectMake(0, 0, WIDTHF(self),HEIGHTF(self));
        [self.contentView addSubview:platImgView];
    }
    return _platImgView;
}
@end

#pragma mark - YNRateTypesCell ------------------------------------------
@implementation YNRateTypesCell
-(UILabel *)rmbLabel{
    if (!_rmbLabel) {
        UILabel *rmbLabel= [[UILabel alloc] init];
        _rmbLabel = rmbLabel;
        rmbLabel.frame = CGRectMake(0, 0, WIDTHF(self.contentView)/3.0, HEIGHTF(self.contentView));
        rmbLabel.textColor = COLOR_999999;
        rmbLabel.font = FONT(26);
        rmbLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:rmbLabel];
    }
    return _rmbLabel;
}
-(UILabel *)buyInLabel{
    if (!_buyInLabel) {
        UILabel *buyInLabel= [[UILabel alloc] init];
        buyInLabel.frame = CGRectMake(MaxXF(self.rmbLabel), 0, WIDTHF(self.rmbLabel), HEIGHTF(self.rmbLabel));
        _buyInLabel = buyInLabel;
        buyInLabel.textColor = COLOR_999999;
        buyInLabel.font = FONT(26);
        buyInLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:buyInLabel];
    }
    return _buyInLabel;
}
-(UILabel *)sellOutLabel{
    if (!_sellOutLabel) {
        UILabel *sellOutLabel= [[UILabel alloc] init];
        sellOutLabel.frame = CGRectMake(MaxXF(self.buyInLabel), 0, WIDTHF(self.buyInLabel), HEIGHTF(self.buyInLabel));
        _sellOutLabel = sellOutLabel;
        sellOutLabel.textColor = COLOR_999999;
        sellOutLabel.font = FONT(26);
        sellOutLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:sellOutLabel];
    }
    return _sellOutLabel;
}
@end

#pragma mark - YNHotClassesCell ------------------------------------------

@interface YNHotClassesCell ()

@property (nonatomic,weak) UIImageView *classImgView;
@property (nonatomic,weak) UILabel *titleLabel;

@end
@implementation YNHotClassesCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    if ([dict[@"classimg"] hasPrefix:@"http"]) {
        [self.classImgView sd_setImageWithURL:[NSURL URLWithString:dict[@"classimg"]] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    }else{
        self.classImgView.image = [UIImage imageNamed:dict[@"classimg"]];
    }
    self.titleLabel.text = dict[@"classname"];
}

-(UIImageView *)classImgView{
    if (!_classImgView) {
        UIImageView *classImgView = [[UIImageView alloc] init];
        _classImgView = classImgView;
        [self.contentView addSubview:classImgView];
        classImgView.frame = CGRectMake(0, 0, WIDTHF(self), WIDTHF(self));
        classImgView.layer.masksToBounds = YES;
        classImgView.layer.cornerRadius = W_RATIO(20);
    }
    return _classImgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        titleLabel.frame = CGRectMake(0, WIDTHF(self), WIDTHF(self), HEIGHTF(self)-WIDTHF(self));
        titleLabel.font = FONT(24);
        titleLabel.textColor = COLOR_333333;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        //titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

@end
#pragma mark - YNMoneyRatesCell ------------------------------------------
@implementation YNMoneyRatesCell
-(UIImageView *)flagImgView{
    if (!_flagImgView) {
        UIImageView *flagImgView = [[UIImageView alloc] init];
        _flagImgView = flagImgView;
        flagImgView.frame = CGRectMake(kMidSpace,
                                       (HEIGHTF(self.contentView)-W_RATIO(26))/2.0,
                                       W_RATIO(40),
                                       W_RATIO(26));
        [self.contentView addSubview:flagImgView];
    }
    return _flagImgView;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        UILabel *typeLabel = [[UILabel alloc] init];
        _typeLabel = typeLabel;
        typeLabel.frame = CGRectMake(MaxXF(_flagImgView)+kMinSpace,
                                     0,
                                     SCREEN_WIDTH/3.0-(MaxXF(_flagImgView)+kMinSpace),
                                     HEIGHTF(self.contentView));
        typeLabel.font = FONT(30);
        typeLabel.textColor = COLOR_333333;
        [self.contentView addSubview:typeLabel];
    }
    return _typeLabel;
}
-(UILabel *)buyLabel{
    if (!_buyLabel) {
        UILabel *buyLabel = [[UILabel alloc] init];
        _buyLabel = buyLabel;
        buyLabel.frame = CGRectMake(MaxXF(self.typeLabel),
                                    0,
                                    SCREEN_WIDTH/3.0,
                                    HEIGHTF(self.contentView));
        buyLabel.font = FONT(30);
        buyLabel.textAlignment = NSTextAlignmentCenter;
        buyLabel.textColor = COLOR_333333;
        [self.contentView addSubview:buyLabel];
    }
    return _buyLabel;
}
-(UILabel *)sellLabel{
    if (!_sellLabel) {
        UILabel *sellLabel = [[UILabel alloc] init];
        _sellLabel = sellLabel;
        sellLabel.frame = CGRectMake(MaxXF(self.buyLabel),
                                     0,
                                     SCREEN_WIDTH/3.0,
                                     HEIGHTF(self.contentView));
        sellLabel.font = FONT(30);
        sellLabel.textAlignment = NSTextAlignmentCenter;
        sellLabel.textColor = COLOR_333333;
        [self.contentView addSubview:sellLabel];
    }
    return _sellLabel;
}
@end
#pragma mark - YNSpecialBuyCell ------------------------------------------
@interface YNSpecialBuyCell ()
/** 大图 */
@property (nonatomic,weak) UIImageView *bigImageView;
/** 名称 */
@property (nonatomic,weak) UILabel *nameLabel;
/** 型号 */
@property (nonatomic,weak) UILabel *versionLabel;
/** ￥符号 */
@property (nonatomic,weak) UILabel *markLabel;
/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;
/** 立即购买 */
@property (nonatomic,weak) UIButton *buyBtn;
@end
@implementation YNSpecialBuyCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    self.nameLabel.text = dict[@"name"];
    self.versionLabel.text = dict[@"note"];
    self.priceLabel.text = [NSString decimalNumberWithDouble:dict[@"salesprice"]];
    self.markLabel.text = LocalMoneyMark;
    [self layoutSubviews];
}

-(UIImageView *)bigImageView{
    if (!_bigImageView) {
        UIImageView *bigImageView= [[UIImageView alloc] init];
        _bigImageView = bigImageView;
        [self addSubview:bigImageView];
    }
    return _bigImageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        nameLabel.font = FONT(30);
        nameLabel.numberOfLines = 2;
        nameLabel.textColor = COLOR_333333;
        [self addSubview:nameLabel];
    }
    return _nameLabel;
}
-(UILabel *)versionLabel{
    if (!_versionLabel) {
        UILabel *versionLabel = [[UILabel alloc] init];
        _versionLabel = versionLabel;
        versionLabel.font = FONT(24);
        versionLabel.textColor = COLOR_666666;
        [self addSubview:versionLabel];
    }
    return _versionLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        priceLabel.font = FONT(44);
        priceLabel.textColor = COLOR_FF4844;
        [self addSubview:priceLabel];
    }
    return _priceLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        markLabel.font = FONT(26);
        markLabel.textColor = COLOR_FF4844;
        [self addSubview:markLabel];
    }
    return _markLabel;
}
-(UIButton *)buyBtn{
    if (!_buyBtn) {
        UIButton *buyBtn = [[UIButton alloc] init];
        _buyBtn = buyBtn;
        [self addSubview:buyBtn];
        [buyBtn setTitle:LocalNowBuy forState:UIControlStateNormal];
        buyBtn.backgroundColor = COLOR_DF463E;
        buyBtn.titleLabel.font = FONT(24);
        buyBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [buyBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(didBuyNowButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}
-(void)didBuyNowButtonClick{
    if (self.didBuyNowButtonClickBlock) {
        self.didBuyNowButtonClickBlock();
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _bigImageView.frame = CGRectMake(W_RATIO(10), 0, W_RATIO(260),W_RATIO(200));
    
    CGSize nameSize = [_nameLabel.text calculateHightWithWidth:WIDTHF(self)-MaxXF(_bigImageView)-W_RATIO(30)*2 font:_nameLabel.font line:_nameLabel.numberOfLines];
    _nameLabel.frame = CGRectMake(MaxXF(_bigImageView)+W_RATIO(20),
                                  0,
                                  nameSize.width,
                                  nameSize.height);

    _versionLabel.frame = CGRectMake(XF(_nameLabel),
                                     HEIGHTF(_bigImageView)/2.0,
                                     W_RATIO(300),
                                     W_RATIO(30));
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    _markLabel.frame = CGRectMake(XF(_nameLabel),
                                  MaxYF(_bigImageView)-markSize.height-W_RATIO(10),
                                  markSize.width,
                                  markSize.height);
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
    _priceLabel.frame = CGRectMake(MaxXF(_markLabel),
                                   MaxYF(_markLabel)-priceSize.height+W_RATIO(5),
                                   priceSize.width,
                                   priceSize.height);
    self.buyBtn.frame = CGRectMake(MaxXF(_versionLabel)+W_RATIO(20), MaxYF(_priceLabel)-W_RATIO(54), W_RATIO(120), W_RATIO(54));
    _buyBtn.layer.cornerRadius = W_RATIO(8);
    
}

@end
#pragma mark - YNShowGoodsCell ------------------------------------------
@interface YNShowGoodsCell()
/** 大图 */
@property (nonatomic,weak) UIImageView *bigImageView;
/** 名称 */
@property (nonatomic,weak) UILabel *nameLabel;
/** 型号 */
@property (nonatomic,weak) UILabel *versionLabel;
/** ￥符号 */
@property (nonatomic,weak) UILabel *markLabel;
/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;
@end
@implementation YNShowGoodsCell
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    self.nameLabel.text = dict[@"name"];
    self.versionLabel.text = dict[@"note"];
    self.priceLabel.text = [NSString decimalNumberWithDouble:dict[@"salesprice"]];
    self.markLabel.text = LocalMoneyMark;
    [self layoutSubviews];
}

-(UIImageView *)bigImageView{
    if (!_bigImageView) {
        UIImageView *bigImageView= [[UIImageView alloc] init];
        _bigImageView = bigImageView;
        [self addSubview:bigImageView];
    }
    return _bigImageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        nameLabel.font = FONT(30);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = COLOR_333333;
        [self addSubview:nameLabel];
    }
    return _nameLabel;
}
-(UILabel *)versionLabel{
    if (!_versionLabel) {
        UILabel *versionLabel = [[UILabel alloc] init];
        _versionLabel = versionLabel;
        versionLabel.font = FONT(24);
        versionLabel.textAlignment = NSTextAlignmentCenter;
        versionLabel.textColor = COLOR_666666;
        [self addSubview:versionLabel];
    }
    return _versionLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        priceLabel.font = FONT(38);
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.textColor = COLOR_FF4844;
        [self addSubview:priceLabel];
    }
    return _priceLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        markLabel.font = FONT(26);
        markLabel.textColor = COLOR_FF4844;
        [self addSubview:markLabel];
    }
    return _markLabel;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _bigImageView.frame = CGRectMake(0, 0, WIDTHF(self.contentView),WIDTHF(self.contentView));
    
    CGSize nameSize = [_nameLabel.text calculateHightWithFont:_nameLabel.font maxWidth:0];
    _nameLabel.frame = CGRectMake(0,
                                  MaxYF(_bigImageView)+kMinSpace,
                                  WIDTHF(_bigImageView),
                                  nameSize.height);
    
    CGSize versionSize = [_versionLabel.text calculateHightWithFont:_versionLabel.font maxWidth:0];
    _versionLabel.frame = CGRectMake(0,
                                     MaxYF(_nameLabel)+kMinSpace,
                                     WIDTHF(_bigImageView),
                                     versionSize.height);
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
    _priceLabel.frame = CGRectMake((WIDTHF(self.contentView)-priceSize.width)/2.0,
                                   MaxYF(_versionLabel)+kMinSpace*2,
                                   priceSize.width,
                                   priceSize.height);
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    _markLabel.frame = CGRectMake(MinXF(_priceLabel)-markSize.width,
                                  MaxYF(_priceLabel)-markSize.height,
                                  markSize.width,
                                  markSize.height);
}
@end
#pragma mark - YNHeaderBarView ------------------------------------------
@implementation YNHeaderBarView

-(void)setWithTitle:(NSString *)title leftImg:(UIImage *)leftImg moreImg:(UIImage *)moreImg color:(UIColor *)color moreClickBlock:(moreButtonClickBlock)moreClickBlock{
    self.leftImgView.image = leftImg;
    self.titleLabel.text = title;
    self.backgroundColor = color;
    self.titleLabel.textColor = COLOR_649CE0;
    [self.moreBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    if (moreImg) {
        [self.moreBtn setImage:moreImg forState:UIControlStateNormal];
        self.moreBtn.hidden = NO;
    }
    if (moreClickBlock) {
        self.moreButtonClickBlock = moreClickBlock;
    }
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        titleLabel.font = FONT(26);
        titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(10),
                                       0,
                                       WIDTHF(self)/2.0,
                                       HEIGHTF(self));
        [self addSubview:titleLabel];
    }
    return _titleLabel;
}
-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView *leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        leftImgView.frame = CGRectMake(W_RATIO(20),
                                        (HEIGHTF(self)-W_RATIO(42))/2.0,
                                        W_RATIO(34),
                                        W_RATIO(42));
        [self addSubview:_leftImgView];
    }
    return _leftImgView;
}
-(UIButton *)moreBtn{
    if (!_moreBtn) {
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn = moreBtn;
        [moreBtn setTitle:LocalMore forState:UIControlStateNormal];
        moreBtn.titleLabel.font = FONT(24);
        moreBtn.hidden = YES;
        [moreBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moreBtn];
        moreBtn.frame = CGRectMake(SCREEN_WIDTH-W_RATIO(120), (HEIGHTF(self)-W_RATIO(50))/2.0, W_RATIO(120), W_RATIO(50));
    }
    return _moreBtn;
}
-(void)moreButtonClick{
    self.moreButtonClickBlock(self.titleLabel.text);
}

@end
#pragma mark - YNHeaderShowBarView ------------------------------------------
@interface YNHeaderShowBarView ()
@property (nonatomic,weak)UIImageView *leftImgView;
@property (nonatomic,weak)UILabel *titleLabel;
@property (nonatomic,weak)UIButton *showRateBtn;
@end
@implementation YNHeaderShowBarView
-(void)setWithTitle:(NSString *)title leftImg:(UIImage *)leftImg isShow:(BOOL )isShow showClickBlock:(showButtonClickBlock)showClickBlock{
    self.leftImgView.image = leftImg;
    
    self.titleLabel.text = title;
    
    CGFloat titleWidth = [title calculateHightWithFont:_titleLabel.font maxWidth:SCREEN_WIDTH/2.0].width;
    _titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(10),
                                   0,
                                   titleWidth,
                                   HEIGHTF(self));
    self.backgroundColor = COLOR_FFFFFF;
    self.titleLabel.textColor = COLOR_649CE0;
    self.showRateBtn.selected = isShow;
    self.showButtonClickBlock = showClickBlock;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        titleLabel.font = FONT(26);
        [self addSubview:titleLabel];
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCellsForMoneyRate)];
        [titleLabel addGestureRecognizer:tap];
    }
    return _titleLabel;
}
-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView *leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        leftImgView.frame = CGRectMake(W_RATIO(20),
                                       (HEIGHTF(self)-W_RATIO(42))/2.0,
                                       W_RATIO(42),
                                       W_RATIO(42));
        [self addSubview:leftImgView];
    }
    return _leftImgView;
}
-(UIButton *)showRateBtn{
    if (!_showRateBtn) {
        UIButton *showRateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showRateBtn = showRateBtn;
        [showRateBtn addTarget:self action:@selector(showCellsForMoneyRate) forControlEvents:UIControlEventTouchUpInside];
        [showRateBtn setImage:[UIImage imageNamed:@"mianbaoxie_lanshang_shouye"] forState:UIControlStateSelected];
        [showRateBtn setImage:[UIImage imageNamed:@"mianbaoxie_lan_shouye"] forState:UIControlStateNormal];
        showRateBtn.frame = CGRectMake(MaxXF(_titleLabel)+W_RATIO(20), (HEIGHTF(self)-W_RATIO(26))/2.0, W_RATIO(26), W_RATIO(30));
        [self addSubview:showRateBtn];
    }
    return _showRateBtn;
}
-(void)showCellsForMoneyRate{
    _showRateBtn.selected = !_showRateBtn.selected;
    self.showButtonClickBlock(_showRateBtn.selected);
}
@end
