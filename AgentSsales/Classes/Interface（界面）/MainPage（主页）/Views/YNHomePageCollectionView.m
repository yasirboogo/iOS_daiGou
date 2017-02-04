//
//  YNHomePageCollectionView.m
//  AgentSsales
//
//  Created by innofive on 16/12/22.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNHomePageCollectionView.h"
#import "ImagesPlayer.h"

@interface YNHomePageCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ImagesPlayerDelegae>

@property (nonatomic,assign) BOOL isShowMoneyRate;

@end

@implementation YNHomePageCollectionView

-(instancetype)init{
    CGRect frame = CGRectMake(0,
                              kUINavHeight,
                              SCREEN_WIDTH,
                              SCREEN_HEIGHT-kUINavHeight-kUITabBarH);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        //隐藏滑块
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = COLOR_EDEDED;
        //注册单元格
        [self registerClass:[YNPlatSelectsCell class] forCellWithReuseIdentifier:@"selectCell"];
        [self registerClass:[YNMoneyRatesCell class] forCellWithReuseIdentifier:@"rateCell"];
        [self registerClass:[YNHotClassesCell class] forCellWithReuseIdentifier:@"classCell"];
        [self registerClass:[YNShowGoodsCell class] forCellWithReuseIdentifier:@"goodCell"];
        [self registerClass:[YNPlayerImgCell class] forCellWithReuseIdentifier:@"playerCell"];
        [self registerClass:[YNRateTypesCell class] forCellWithReuseIdentifier:@"typeCell"];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self registerClass:[YNHeaderBarView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"barHeader"];
        
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return self;
}
#pragma mark - 代理实现
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 3;
    }else if (section == 3){
        return 1;
    }else if (section == 4){
        return 2;
    }
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:
(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YNPlayerImgCell *playerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"playerCell" forIndexPath:indexPath];
        playerCell.backgroundColor = COLOR_FFFFFF;
        NSArray *imageURLs = @[@"http://tx.haiqq.com/uploads/allimg/150326/160R95612-10.jpg",
                               @"http://img4.duitang.com/uploads/item/201508/11/20150811220329_XyZAv.png",
                               @"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg",
                               ];
        playerCell.imageURLs = imageURLs;
        [playerCell setDidSelectPlayerImgClickBlock:^(NSString *str) {
            self.didSelectPlayerImgClickBlock(str);
        }];
        return playerCell;
    }else if (indexPath.section == 1) {
        YNPlatSelectsCell *selectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"selectCell" forIndexPath:indexPath];
        selectCell.backgroundColor = COLOR_FFFFFF;
        for (UIView *view in selectCell.contentView.subviews) {
            [view removeFromSuperview];
        }
        selectCell.platImgs = @[@"taobao_shouye",
                                @"weipinhui_shouye",
                                @"jingdong_shouye"];
        [selectCell setDidSelectPlatImgClickBlock:^(NSInteger index) {
            self.didSelectPlatImgClickBlock(index);
        }];
        return selectCell;
        
    }else if (indexPath.section == 2){
        if (!self.isShowMoneyRate) {
            //不做任何操作，隐藏
        }else{
            if (indexPath.row == 0) {
                YNRateTypesCell *typeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"typeCell" forIndexPath:indexPath];
                typeCell.backgroundColor = COLOR_FFFFFF;
                typeCell.rmbLabel.text = NSLS(@"人民币（主）", @"人民币（主）");
                typeCell.buyInLabel.text = NSLS(@"买进", @"买进");
                typeCell.sellOutLabel.text = NSLS(@"卖出", @"卖出");
                return typeCell;
            }else{
                YNMoneyRatesCell *rateCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rateCell" forIndexPath:indexPath];
                rateCell.backgroundColor = COLOR_FFFFFF;
                rateCell.flagImgView.image = [UIImage imageNamed:@"malaixiya_guoqi"];
                rateCell.typeLabel.text = NSLS(@"马来西亚币", @"货币类型");
                rateCell.buyLabel.text = NSLS(@"0.6545", @"买进");
                rateCell.sellLabel.text = NSLS(@"1.6057", @"卖出");
                return rateCell;
            }
        }
    }else if (indexPath.section == 3) {
        YNHotClassesCell *classCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
        for (UIView *view in classCell.contentView.subviews) {
            [view removeFromSuperview];
        }
        classCell.imageURLs = @[@"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg",
                                @"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg",
                                @"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg",
                                @"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg",
                                @"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg",
                                @"http://www.ld12.com/upimg358/allimg/c151129/144WW1420B60-401445_lit.jpg"];
        classCell.backgroundColor = COLOR_69B6FF;
        [classCell setDidSelectHotClassImgClickBlock:^(NSString *str) {
            self.didSelectHotClassImgClickBlock(str);
        }];
        return classCell;
    }else if(indexPath.section == 4) {
        YNShowGoodsCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodCell" forIndexPath:indexPath];
        goodsCell.backgroundColor = COLOR_FFFFFF;
        goodsCell.bigImageView.image = [UIImage imageNamed:_dataArray[indexPath.row][@"image"]];
        goodsCell.nameLabel.text = _dataArray[indexPath.row][@"name"];
        goodsCell.versionLabel.text = _dataArray[indexPath.row][@"version"];
        goodsCell.priceLabel.text = _dataArray[indexPath.row][@"price"];
        goodsCell.markLabel.text = _dataArray[indexPath.row][@"mark"];
        return goodsCell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = COLOR_FFFFFF;
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(400));
    }else if (indexPath.section == 1) {
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(198));
    }else if (indexPath.section == 2){
        if (!self.isShowMoneyRate) {
            //不做任何操作，隐藏
        }
        else{
            if (indexPath.row == 0) {
                return CGSizeMake(SCREEN_WIDTH, W_RATIO(80));
            }
            return CGSizeMake(SCREEN_WIDTH, W_RATIO(100));
        }
    }else if (indexPath.section == 3){
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(350));
    }else if (indexPath.section == 4){
        return CGSizeMake(W_RATIO(371), W_RATIO(371)+W_RATIO(169));
    }
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
    }else if (section == 1) {
    }else if (section == 2){
        return W_RATIO(2);
    }else if (section == 3){
        return W_RATIO(2);
    }else if (section == 4){
        return W_RATIO(8);
    }
    return kZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
    }else if (section == 1) {
    }else if (section == 2){
    }else if (section == 3){
        return W_RATIO(2);
    }else if (section == 4){
        return W_RATIO(8);
    }
    return kZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
    }else if (section == 1) {
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(10));
    }else if (section == 2){
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(10));
    }else if (section == 3){
    }else if (section == 4){
    }
    return CGSizeZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
    }else if (section == 1) {
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(80));
    }else if (section == 2){
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(100));
    }else if (section == 3){
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(80));
    }else if (section == 4){
        return CGSizeMake(SCREEN_WIDTH, W_RATIO(84));
    }
    return CGSizeZero;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
        }else if (indexPath.section == 1) {
            YNHeaderBarView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"barHeader" forIndexPath:indexPath];
            [headerView setWithTitle:NSLS(@"代购平台", @"代购平台") leftImg:[UIImage imageNamed:@"daigoupingtai_shouye"] moreImg:nil color:COLOR_FFFFFF moreClickBlock:nil];
            return headerView;
        }else if (indexPath.section == 2){
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            headerView.backgroundColor = COLOR_FFFFFF;
            [self addSubviewsToRateHeader:headerView];
            return headerView;
        }else if (indexPath.section == 3){
            YNHeaderBarView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"barHeader" forIndexPath:indexPath];
            [headerView setWithTitle:NSLS(@"热门分类", @"热门分类") leftImg:[UIImage imageNamed:@"remenfenlei_shouye"] moreImg:[UIImage imageNamed:@"gengduo_bai_shouye"] color:COLOR_69B6FF moreClickBlock:^(NSString *str) {
                self.didSelectMoreBtnClickBlock(str);
            }];
            return headerView;
        }else if (indexPath.section == 4){
            YNHeaderBarView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"barHeader" forIndexPath:indexPath];
            [headerView setWithTitle:NSLS(@"特色惠购", @"特色惠购") leftImg:[UIImage imageNamed:@"tesehuigou"] moreImg:[UIImage imageNamed:@"gengduo_kui"] color:COLOR_FFFFFF moreClickBlock:^(NSString *str) {
                self.didSelectMoreBtnClickBlock(str);
            }];
            return headerView;
        }
        return nil;
    }else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {//特色惠购可以选择
        if (self.didSelectGoodImgClickBlock) {
            self.didSelectGoodImgClickBlock([NSString stringWithFormat:@"你选择了第%ld个图片",indexPath.row]);
        }
    }
}
#pragma mark - 广告页ImagesPlayerDelegae
- (void)imagesPlayer:(ImagesPlayer *)player didSelectImageAtIndex:(NSInteger)index
{
    if (self.didSelectPlayerImgClickBlock) {
        self.didSelectPlayerImgClickBlock([NSString stringWithFormat:@"你点击第%ld个广告页",index]);
    }
}
-(UICollectionReusableView*)addSubviewsToRateHeader:(UICollectionReusableView*)headerView{
    for (UIView *view in headerView.subviews) {
        [view removeFromSuperview];
    }
    //左边图片，标题，展开按钮
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = NSLS(@"实时汇率", @"实时汇率");
    titleLabel.font = FONT(26);
    CGSize size = [titleLabel.text sizeWithAttributes:@{NSFontAttributeName:titleLabel.font}];
    titleLabel.frame = CGRectMake((WIDTHF(headerView)-size.width)/2.0+kMinSpace,
                                  0,
                                  size.width,
                                  HEIGHTF(headerView));
    titleLabel.textColor = COLOR_649CE0;
    [headerView addSubview:titleLabel];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(XF(titleLabel)-W_RATIO(72)-kMinSpace,
                                 YF(titleLabel)+(HEIGHTF(titleLabel)-W_RATIO(72))/2.0,
                                 W_RATIO(72),
                                 W_RATIO(72));
    imageView.image = [UIImage imageNamed:@"huilv_shouye"];
    [headerView addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(MaxXF(titleLabel)+kMinSpace,
                              YF(titleLabel)+(HEIGHTF(titleLabel)-W_RATIO(14))/2.0,
                              W_RATIO(24),
                              W_RATIO(14));
    [button setImage:[UIImage imageNamed:@"mianbaoxie_lanshang_shouye"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"mianbaoxie_lan_shouye"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(showCellsForMoneyRate:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = self.isShowMoneyRate;
    [headerView addSubview:button];
    return headerView;
}
-(void)showCellsForMoneyRate:(UIButton*)btn{
    btn.selected = !btn.selected;
    self.isShowMoneyRate = btn.selected;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [self reloadSections:indexSet];
}
@end

#pragma mark - cell的@implementation方法
#pragma mark YNPlatSelectsCell
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
    [imagesPlayer addNetWorkImages:imageURLs placeholder:nil];
    [self.contentView addSubview:imagesPlayer];
}
#pragma mark 广告页ImagesPlayerDelegae
- (void)imagesPlayer:(ImagesPlayer *)player didSelectImageAtIndex:(NSInteger)index
{
    if (self.didSelectPlayerImgClickBlock) {
        self.didSelectPlayerImgClickBlock([NSString stringWithFormat:@"你点击第%ld个广告页",index]);
    }
}
@end

@implementation YNPlatSelectsCell
-(void)setPlatImgs:(NSArray *)platImgs{
    _platImgs = platImgs;
    if (platImgs.count < 3) {
        DLog(@"图片个数小于3张");
    }
    CGFloat startX = (SCREEN_WIDTH-W_RATIO(175)*3-W_RATIO(30)*2)/2.0;
    for (NSInteger i = 0; i < 3; i++) {
        // 创建 imageView
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(startX+(i%3)*(W_RATIO(175)+W_RATIO(30)),
                                     0,
                                     W_RATIO(175),
                                     W_RATIO(175));
        imageView.image = [UIImage imageNamed:platImgs[i]];
        imageView.tag = i;
        [self.contentView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(handlePlatImgTapClick:)];
        [imageView addGestureRecognizer:tap];
    }
}
-(void)handlePlatImgTapClick:(UITapGestureRecognizer*)tap{
    if (self.didSelectPlatImgClickBlock) {
        self.didSelectPlatImgClickBlock(tap.view.tag);
    }
}
@end

#pragma mark YNRateTypesCell
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

#pragma mark YNHotClassesCell
@implementation YNHotClassesCell

-(void)setImageURLs:(NSArray *)imageURLs{
    _imageURLs = imageURLs;
    if (imageURLs.count < 6) {
        DLog(@"图片个数小于6张");
    }
    CGFloat startX = (SCREEN_WIDTH-W_RATIO(243)*3-W_RATIO(2)*2)/2.0;
    for (NSInteger i = 0; i < 6; i ++) {
        // 创建 imageView
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(startX+(i%3)*(W_RATIO(243)+W_RATIO(2)),
                                     (i/3)*(W_RATIO(168)+W_RATIO(2)),
                                     W_RATIO(243),
                                     W_RATIO(168));
        [imageView sd_setImageWithURL:imageURLs[i] placeholderImage:nil];
        imageView.tag = i;
        [self.contentView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(handleClassImgTapClick:)];
        [imageView addGestureRecognizer:tap];
    }
}
-(void)handleClassImgTapClick:(UITapGestureRecognizer*)tap{
    if (self.didSelectHotClassImgClickBlock) {
        self.didSelectHotClassImgClickBlock([NSString stringWithFormat:@"你点击了热门分类第%ld图片",tap.view.tag]);
    }
}
@end
#pragma mark YNMoneyRatesCell
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
#pragma mark YNShowGoodsCell
@implementation YNShowGoodsCell
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
    
    CGSize nameSize = [_nameLabel.text sizeWithAttributes:@{NSFontAttributeName:FONT(30)}];
    _nameLabel.frame = CGRectMake(0,
                                  MaxYF(_bigImageView)+kMinSpace,
                                  WIDTHF(_bigImageView),
                                  nameSize.height);
    
    CGSize versionSize = [_versionLabel.text sizeWithAttributes:@{NSFontAttributeName:_versionLabel.font}];
    _versionLabel.frame = CGRectMake(0,
                                     MaxYF(_nameLabel)+kMinSpace,
                                     WIDTHF(_bigImageView),
                                     versionSize.height);
    
    CGSize priceSize = [_priceLabel.text sizeWithAttributes:@{NSFontAttributeName:_priceLabel.font}];
    _priceLabel.frame = CGRectMake((WIDTHF(self.contentView)-priceSize.width)/2.0,
                                   MaxYF(_versionLabel)+kMinSpace*2,
                                   priceSize.width,
                                   priceSize.height);
    
    CGSize markSize = [_markLabel.text sizeWithAttributes:@{NSFontAttributeName:_markLabel.font}];
    _markLabel.frame = CGRectMake(MinXF(_priceLabel)-markSize.width,
                                  MaxYF(_priceLabel)-markSize.height,
                                  markSize.width,
                                  markSize.height);
}
@end

@implementation YNHeaderBarView

-(void)setWithTitle:(NSString *)title leftImg:(UIImage *)leftImg moreImg:(UIImage *)moreImg color:(UIColor *)color moreClickBlock:(moreButtonClickBlock)moreClickBlock{
    self.titleLabel.text = title;
    self.leftImgView.image = leftImg;
    self.backgroundColor = color;
    if (CGColorEqualToColor(color.CGColor, COLOR_FFFFFF.CGColor)) {
        self.titleLabel.textColor = COLOR_649CE0;
        [self.moreBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    }else{
        self.titleLabel.textColor = COLOR_FFFFFF;
        [self.moreBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
    }
    if (moreImg) {
        [self.moreBtn setImage:moreImg forState:UIControlStateNormal];
        self.moreBtn.hidden = NO;
    }
    if (moreClickBlock) {
        self.moreButtonClickBlock = moreClickBlock;
    }
}
-(void)layoutSubviews{
    CGSize size = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_titleLabel.font}];
    _titleLabel.frame = CGRectMake((SCREEN_WIDTH-size.width)/2.0+kMinSpace,
                                   0,
                                   size.width,
                                   HEIGHTF(self));
    _leftImgView.frame = CGRectMake(XF(_titleLabel)-W_RATIO(34)-kMinSpace,
                                    YF(_titleLabel)+(HEIGHTF(_titleLabel)-W_RATIO(42))/2.0,
                                    W_RATIO(34),
                                    W_RATIO(42));
    
    _moreBtn.frame = CGRectMake(SCREEN_WIDTH-W_RATIO(120), 0, W_RATIO(120), HEIGHTF(_titleLabel));
    [_moreBtn adjustButtonForImageAndTitleWithImagePosition:BtnWithImgOnHorizontalRight isSpace:NO];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        titleLabel.font = FONT(26);
        [self addSubview:titleLabel];
    }
    return _titleLabel;
}
-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView *leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        [self addSubview:_leftImgView];
    }
    return _leftImgView;
}
-(UIButton *)moreBtn{
    if (!_moreBtn) {
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn = moreBtn;
        [moreBtn setTitle:NSLS(@"更多", @"更多") forState:UIControlStateNormal];
        moreBtn.titleLabel.font = FONT(24);
        moreBtn.hidden = YES;
        [moreBtn addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moreBtn];
    }
    return _moreBtn;
}
-(void)moreButtonClick{
    self.moreButtonClickBlock(self.titleLabel.text);
}

@end
