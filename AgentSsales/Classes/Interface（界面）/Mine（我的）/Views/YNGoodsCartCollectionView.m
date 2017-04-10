//
//  YNGoodsCartCollectionView.m
//  AgentSsales
//
//  Created by innofive on 17/1/15.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNGoodsCartCollectionView.h"

@interface YNGoodsCartCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation YNGoodsCartCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = W_RATIO(20);
    flowLayout.itemSize = CGSizeMake(WIDTH(frame)-flowLayout.minimumInteritemSpacing*2, W_RATIO(185)+W_RATIO(60));
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = COLOR_EDEDED;
        self.dataSource = self;
        self.delegate = self;
    }
    
    [self registerClass:[YNOrderGoodsCell class] forCellWithReuseIdentifier:@"goodsCell"];
    [self registerClass:[YNOrderGoodsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self registerClass:[YNOrderGoodsFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    return self;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArrayM.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    MyOrderListModel *myOrderListModel = _dataArrayM[section];
    return myOrderListModel.goodsArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(86)+W_RATIO(20));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(176));
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    MyOrderListModel *myOrderListModel = _dataArrayM[indexPath.section];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNOrderGoodsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.orderStasus = myOrderListModel.orderstatus;
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        YNOrderGoodsFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        footerView.dict = @{@"price":myOrderListModel.totalprice,@"status":myOrderListModel.ordernumber};
        [footerView setDidFooterViewRightButtonBlock:^(NSInteger index) {
            self.didFooterViewRightButtonBlock(index,[myOrderListModel.orderId integerValue],indexPath.section,[NSString stringWithFormat:@"%@",myOrderListModel.postage]);
        }];
        [footerView setDidFooterViewLeftButtonBlock:^(NSInteger index) {
            self.didFooterViewLeftButtonBlock(index,[myOrderListModel.orderId integerValue],indexPath.section,[NSString stringWithFormat:@"%@",myOrderListModel.postage]);
        }];
        [footerView setDidFooterViewQuestionButtonBlock:^{
            self.didFooterViewQuestionButtonBlock();
        }];
        return footerView;
    }
    return nil;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YNOrderGoodsCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsCell" forIndexPath:indexPath];
    MyOrderListModel *myOrderListModel = _dataArrayM[indexPath.section];
    MyOrderGoodsModel *myOrderGoodsModel = myOrderListModel.goodsArray[indexPath.row];
    goodsCell.myOrderGoodsModel = myOrderGoodsModel;
    return goodsCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (self.didSelectOrderGoodsCell) {
        MyOrderListModel *myOrderListModel = _dataArrayM[indexPath.section];
        self.didSelectOrderGoodsCell([myOrderListModel.orderId integerValue],indexPath.section,[NSString stringWithFormat:@"%@",myOrderListModel.postage]);
    }
}

@end
@interface YNOrderGoodsCell ()
/** 背景 */
@property (nonatomic,weak) UIView * bgView;
/** 平台标注 */
@property (nonatomic,weak) UILabel * platformLabel;
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

@implementation YNOrderGoodsCell
-(void)layoutSubviews{
    [super layoutSubviews];
    //控件布局
    CGSize titleSize = [_titleLabel.text calculateHightWithWidth:WIDTHF(self.contentView)-MaxXF(_leftImgView)-W_RATIO(20)*2 font:_titleLabel.font line:_titleLabel.numberOfLines];
    _titleLabel.frame = CGRectMake(MaxXF(_leftImgView)+W_RATIO(20), YF(_leftImgView), titleSize.width,titleSize.height);
    
    CGSize subTitleSize = [_subTitleLabel.text calculateHightWithWidth:WIDTHF(_titleLabel) font:_subTitleLabel.font line:_subTitleLabel.numberOfLines];
    _subTitleLabel.frame = CGRectMake(XF(_titleLabel), MaxYF(_titleLabel)+kMinSpace, subTitleSize.width,subTitleSize.height);
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_subTitleLabel),MaxYF(_leftImgView)-markSize.height, markSize.width,markSize.height);
    
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:0];
    self.priceLabel.frame = CGRectMake(MaxXF(_markLabel),MaxYF(_markLabel)-priceSize.height, priceSize.width,priceSize.height);
    self.amountLabel.frame = CGRectMake(MaxXF(_priceLabel)+kMinSpace, YF(_priceLabel),WIDTHF(self.contentView)-MaxXF(_priceLabel)-kMidSpace-kMinSpace, HEIGHTF(_priceLabel));
    
}
-(void)setMyOrderGoodsModel:(MyOrderGoodsModel *)myOrderGoodsModel{
    _myOrderGoodsModel = myOrderGoodsModel;
    [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:myOrderGoodsModel.img] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    self.platformLabel.text = myOrderGoodsModel.type;
    self.titleLabel.text = myOrderGoodsModel.name;
    self.subTitleLabel.text = myOrderGoodsModel.note;
    self.markLabel.text = LocalMoneyMark;
    self.priceLabel.text = [NSString decimalNumberWithDouble:myOrderGoodsModel.salesprice];
    self.amountLabel.text = [NSString stringWithFormat:@"x%@",myOrderGoodsModel.count];
    [self layoutSubviews];
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
-(UILabel *)platformLabel{
    if (!_platformLabel) {
        UILabel * platformLabel = [[UILabel alloc] init];
        _platformLabel = platformLabel;
        [self.bgView addSubview:platformLabel];
        platformLabel.font = FONT(28);
        platformLabel.numberOfLines = 1;
        platformLabel.textColor = COLOR_999999;
        platformLabel.frame = CGRectMake(W_RATIO(20),W_RATIO(20), WIDTHF(self.bgView)-W_RATIO(20)*2, kMidSpace);
    }
    return _platformLabel;
}
-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView * leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        [self.bgView addSubview:leftImgView];
        leftImgView.frame = CGRectMake(W_RATIO(20), W_RATIO(80), W_RATIO(145), W_RATIO(145));
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
        priceLabel.font = FONT(38);
        priceLabel.textColor = COLOR_666666;
    }
    return _priceLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.bgView addSubview:markLabel];
        markLabel.font = FONT(26);
        markLabel.textColor = COLOR_666666;
    }
    return _markLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] init];
        _amountLabel = amountLabel;
        [self.bgView addSubview:amountLabel];
        amountLabel.font = FONT(38);
        amountLabel.textAlignment = NSTextAlignmentRight;
        amountLabel.textColor = COLOR_666666;
    }
    return _amountLabel;
}
@end
@interface YNOrderGoodsHeaderView ()

@property (nonatomic,weak) UIView * bgView;

@property (nonatomic,weak) UILabel * statusLabel;

@end
@implementation YNOrderGoodsHeaderView
-(void)setOrderStasus:(NSString *)orderStasus{
    _orderStasus = orderStasus;
    self.statusLabel.text = orderStasus;
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        [self addSubview:bgView];
        bgView.frame =CGRectMake(W_RATIO(20),W_RATIO(20), WIDTHF(self)-W_RATIO(20)*2, HEIGHTF(self));
        bgView.backgroundColor = COLOR_FFFFFF;
        
        [bgView setViewCornerRadiusWithRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
    }
    return _bgView;
}
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        UILabel *statusLabel = [[UILabel alloc] init];
        _statusLabel = statusLabel;
        [self.bgView addSubview:statusLabel];
        statusLabel.font = FONT(30);
        statusLabel.textAlignment = NSTextAlignmentRight;
        statusLabel.textColor = COLOR_DF463E;
        statusLabel.frame = CGRectMake(W_RATIO(20), W_RATIO(20), WIDTHF(self.bgView)-W_RATIO(20)*2, HEIGHTF(self.bgView)-W_RATIO(20)*2);
    }
    return _statusLabel;
}
@end
@interface YNOrderGoodsFooterView ()
/** 背景 */
@property (nonatomic,weak) UIView * bgView;
/** 总共 */
@property (nonatomic,weak) UILabel * totallLabel;
/** ￥符号 */
@property (nonatomic,weak) UILabel * markLabel;
/** 价格 */
@property (nonatomic,weak) UILabel * priceLabel;
/** 问号 */
@property (nonatomic,weak) UIButton * questionBtn;
/** 问题提示 */
@property (nonatomic,weak) UILabel * questionLabel;
/** 取消订单 */
@property (nonatomic,weak) UIButton * leftBtn;
/** 马上付款 */
@property (nonatomic,weak) UIButton * rightBtn;

/** 失效 */
@property (nonatomic,weak) UILabel * invalidLabel;

@end
@implementation YNOrderGoodsFooterView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.totallLabel.text = LocalTotalCost;
    self.markLabel.text = LocalMoneyMark;
    self.priceLabel.text = dict[@"price"];
    
    self.status = dict[@"status"];
    
    if ([dict[@"num"] integerValue]) {
        self.invalidLabel.text = LocalInvalid;
    };
    
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize priceSize = [_priceLabel.text calculateHightWithFont:_priceLabel.font maxWidth:WIDTHF(_bgView)/2.0];
    self.priceLabel.frame =CGRectMake(WIDTHF(_bgView)-kMidSpace-priceSize.width, W_RATIO(20), priceSize.width, priceSize.height);
    
    CGSize markSize = [_markLabel.text calculateHightWithFont:_markLabel.font maxWidth:0];
    self.markLabel.frame = CGRectMake(XF(_priceLabel)-markSize.width-kMinSpace, MaxYF(_priceLabel)-markSize.height, markSize.width, markSize.height);
    
    CGSize totallSize = [_totallLabel.text calculateHightWithFont:_totallLabel.font maxWidth:XF(_markLabel)-W_RATIO(20)-kMinSpace];
    self.totallLabel.frame = CGRectMake(XF(_markLabel)-totallSize.width-kMinSpace,MaxYF(_markLabel)-totallSize.height,totallSize.width, totallSize.height);
    
    self.invalidLabel.frame = CGRectMake(kMinSpace*2, YF(_totallLabel), XF(_totallLabel)-kMidSpace, HEIGHTF(_totallLabel));
    
    if ([self.status isEqualToString:@"1"]) {
        self.rightBtn.tag = 200+1;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        [_rightBtn setTitle:LocalPayment forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_DF463E;
        [_rightBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        self.leftBtn.tag = 100+1;
        _leftBtn.hidden = NO;
        _leftBtn.enabled = YES;
        [_leftBtn setTitle:LocalCancelOrder forState:UIControlStateNormal];
        _leftBtn.backgroundColor = COLOR_FFFFFF;
        [_leftBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        //待处理无法付款原因
        self.questionBtn.hidden = YES;
        self.questionLabel.hidden = YES;
    }else if ([self.status isEqualToString:@"2"]){
        self.rightBtn.tag = 200+2;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = NO;
        [_rightBtn setTitle:LocalPayment forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_A4A4A4;
        [_rightBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        self.leftBtn.tag = 100+2;
        _leftBtn.hidden = NO;
        _leftBtn.enabled = YES;
        [_leftBtn setTitle:LocalCancelOrder forState:UIControlStateNormal];
        _leftBtn.backgroundColor = COLOR_FFFFFF;
        [_leftBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        //待处理无法付款原因
        self.questionBtn.hidden = NO;
        self.questionLabel.hidden = NO;
        
    }else if ([self.status isEqualToString:@"3"]){
        self.rightBtn.tag = 200+3;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        [_rightBtn setTitle:LocalPayment forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_DF463E;
        [_rightBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        self.leftBtn.tag = 100+3;
        _leftBtn.hidden = YES;
        _leftBtn.enabled = NO;
        
        //待处理无法付款原因
        self.questionBtn.hidden = YES;
        self.questionLabel.hidden = YES;
    }else if ([self.status isEqualToString:@"4"]){
        self.rightBtn.tag = 200+4;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        self.rightBtn.enabled = YES;
        [_rightBtn setTitle:LocalPrompt forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_FFFFFF;
        [_rightBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        self.leftBtn.tag = 100+4;
        _leftBtn.hidden = YES;
        _leftBtn.enabled = NO;
        //待处理无法付款原因
        self.questionBtn.hidden = YES;
        self.questionLabel.hidden = YES;
    }else if ([self.status isEqualToString:@"5"]){
        self.rightBtn.tag = 200+5;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        [_rightBtn setTitle:LocalConReceipt forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_DF463E;
        [_rightBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        self.leftBtn.tag = 100+5;
        _leftBtn.hidden = NO;
        _leftBtn.enabled = YES;
        [_leftBtn setTitle:LocalViewLogistics forState:UIControlStateNormal];
        _leftBtn.backgroundColor = COLOR_FFFFFF;
        [_leftBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        //待处理无法付款原因
        self.questionBtn.hidden = YES;
        self.questionLabel.hidden = YES;
    }else if ([self.status isEqualToString:@"6"]){
        self.rightBtn.tag = 200+6;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        [_rightBtn setTitle:LocalViewLogistics forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_FFFFFF;
        [_rightBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        self.leftBtn.tag = 100+6;
        _leftBtn.hidden = NO;
        _leftBtn.enabled = YES;
        [_leftBtn setTitle:LocalAnotherOne forState:UIControlStateNormal];
        _leftBtn.backgroundColor = COLOR_FFFFFF;
        [_leftBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        //待处理无法付款原因
        self.questionBtn.hidden = YES;
        self.questionLabel.hidden = YES;
    }
    
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        [self addSubview:bgView];
        bgView.frame =CGRectMake(W_RATIO(20),0, WIDTHF(self)-W_RATIO(20)*2, HEIGHTF(self));
        bgView.backgroundColor = COLOR_FFFFFF;
        [bgView setViewCornerRadiusWithRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerSize:CGSizeMake(W_RATIO(20), W_RATIO(20))];
        
    }
    return _bgView;
}
-(UILabel *)totallLabel{
    if (!_totallLabel) {
        UILabel *totallLabel = [[UILabel alloc] init];
        _totallLabel = totallLabel;
        [self.bgView addSubview:totallLabel];
        totallLabel.font = FONT(24);
        totallLabel.textAlignment = NSTextAlignmentRight;
        totallLabel.adjustsFontSizeToFitWidth = YES;
        totallLabel.textColor = COLOR_333333;
    }
    return _totallLabel;
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
        priceLabel.font = FONT(38);
        priceLabel.textColor = COLOR_DF463E;
    }
    return _priceLabel;
}
-(UILabel *)invalidLabel{
    if (!_invalidLabel) {
        UILabel *invalidLabel = [[UILabel alloc] init];
        _invalidLabel = invalidLabel;
        [self.bgView addSubview:invalidLabel];
        invalidLabel.font = FONT(28);
        invalidLabel.textColor = COLOR_FF4844;
    }
    return _invalidLabel;
}
-(UIButton *)questionBtn{
    if (!_questionBtn) {
        UIButton *questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _questionBtn = questionBtn;
        [self.bgView addSubview:questionBtn];
        [questionBtn setBackgroundImage:[UIImage imageNamed:@"wenhao_hong"] forState:UIControlStateNormal];
        [questionBtn addTarget:self action:@selector(handleQuestionButtonClick) forControlEvents:UIControlEventTouchUpInside];
        questionBtn.frame = CGRectMake(W_RATIO(20), YF(_rightBtn)+(HEIGHTF(_rightBtn)-W_RATIO(30))/2.0, W_RATIO(30), W_RATIO(30));
    }
    return _questionBtn;
}
-(void)handleQuestionButtonClick{
    if (self.didFooterViewQuestionButtonBlock) {
        self.didFooterViewQuestionButtonBlock();
    }
}
-(UILabel *)questionLabel{
    if (!_questionLabel) {
        UILabel *questionLabel = [[UILabel alloc] init];
        _questionLabel = questionLabel;
        [self.bgView addSubview:questionLabel];
        questionLabel.text = LocalWhyNotPay;
        questionLabel.font = FONT(24);
        questionLabel.numberOfLines = 3;
        questionLabel.textColor = COLOR_999999;
        questionLabel.userInteractionEnabled = YES;
        CGSize questionSize = [_questionLabel.text calculateHightWithWidth:XF(_leftBtn)-MaxXF(_questionBtn)-kMinSpace*2 font:_questionLabel.font line:_questionLabel.numberOfLines];
        questionLabel.frame = CGRectMake(MaxXF(_questionBtn)+kMinSpace,MaxYF(_totallLabel)+(W_RATIO(176) - MaxYF(_totallLabel)-questionSize.height)/2.0, questionSize.width, questionSize.height);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleQuestionButtonClick)];
        [questionLabel addGestureRecognizer:tap];
    }
    return _questionLabel;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn = leftBtn;
        [self.bgView addSubview:leftBtn];
        leftBtn.layer.borderWidth = kOutLine;
        leftBtn.layer.borderColor = COLOR_CECECE.CGColor;
        leftBtn.titleLabel.font = FONT(28);
        leftBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [leftBtn addTarget:self action:@selector(handleLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.frame = CGRectMake(XF(_rightBtn)-WIDTH(_rightBtn)-W_RATIO(20),YF(_rightBtn),WIDTH(_rightBtn),HEIGHTF(_rightBtn));
    }
    return _leftBtn;
}
-(void)handleLeftButtonClick:(UIButton*)btn{
    if (self.didFooterViewLeftButtonBlock) {
        self.didFooterViewLeftButtonBlock(btn.tag);
    }
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn = rightBtn;
        [self.bgView addSubview:rightBtn];
        rightBtn.layer.borderWidth = kOutLine;
        rightBtn.layer.borderColor = COLOR_CECECE.CGColor;
        rightBtn.titleLabel.font = FONT(28);
        rightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [rightBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(handleRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.frame = CGRectMake(MaxXF(_priceLabel)-W_RATIO(160)+W_RATIO(20), MaxYF(_priceLabel)+W_RATIO(20), W_RATIO(160), W_RATIO(64));
    }
    return _rightBtn;
}
-(void)handleRightButtonClick:(UIButton*)btn{
    if (self.didFooterViewRightButtonBlock) {
        self.didFooterViewRightButtonBlock(btn.tag);
    }
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    NSLog(@"%@",touch.view);
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return  YES;
//}



@end







