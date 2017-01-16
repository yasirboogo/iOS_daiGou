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
    flowLayout.itemSize = CGSizeMake(WIDTH(frame)-flowLayout.minimumInteritemSpacing*2, W_RATIO(185));
    
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
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    [self reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(86)+W_RATIO(20));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(176));
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YNOrderGoodsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待处理"};
        }else if (indexPath.section == 1){
            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待付款"};
        }else if (indexPath.section == 2){
            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待发货"};
        }else if (indexPath.section == 3){
            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待收货"};
        }else if (indexPath.section == 4){
            headerView.dict = @{@"name":@"淘宝商城",@"status":@"待评价"};
        }
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        YNOrderGoodsFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            footerView.dict = @{@"price":@"500.12",@"status":@"待处理"};
        }else if (indexPath.section == 1){
            footerView.dict = @{@"price":@"500.12",@"status":@"待付款"};
        }else if (indexPath.section == 2){
            footerView.dict = @{@"price":@"500.12",@"status":@"待发货"};
        }else if (indexPath.section == 3){
            footerView.dict = @{@"price":@"500.12",@"status":@"待收货"};
        }else if (indexPath.section == 4){
            footerView.dict = @{@"price":@"500.12",@"status":@"待评价"};
        }
        return footerView;
    }
    return nil;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YNOrderGoodsCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsCell" forIndexPath:indexPath];
    goodsCell.backgroundColor = COLOR_FFFFFF;
    goodsCell.dict = @{@"image":@"testGoods",@"title":@"书籍-设计师的自我修养",@"subTitle":@"2016年出版版本",@"price":@"501.21",@"amount":@"2"};
    return goodsCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (self.didSelectOrderGoodsCell) {
        self.didSelectOrderGoodsCell(@"订单详情");
    }
}

@end
@interface YNOrderGoodsCell ()
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
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.leftImgView.image = [UIImage imageNamed:dict[@"image"]];
    self.titleLabel.text = dict[@"title"];
    self.subTitleLabel.text = dict[@"subTitle"];
    self.markLabel.text = NSLS(@"moneySymbol", @"货币符号");
    self.priceLabel.text = dict[@"price"];
    self.amountLabel.text = [NSString stringWithFormat:@"x%@",dict[@"amount"]];
}
-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        UIImageView * leftImgView = [[UIImageView alloc] init];
        _leftImgView = leftImgView;
        [self.contentView addSubview:leftImgView];
        leftImgView.frame = CGRectMake(W_RATIO(20), W_RATIO(20), W_RATIO(145), W_RATIO(145));
    }
    return _leftImgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel * titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
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
        [self.contentView addSubview:subTitleLabel];
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
        [self.contentView addSubview:priceLabel];
        priceLabel.font = FONT(38);
        priceLabel.textColor = COLOR_666666;
    }
    return _priceLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        UILabel *markLabel = [[UILabel alloc] init];
        _markLabel = markLabel;
        [self.contentView addSubview:markLabel];
        markLabel.font = FONT(26);
        markLabel.textColor = COLOR_666666;
    }
    return _markLabel;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        UILabel *amountLabel = [[UILabel alloc] init];
        _amountLabel = amountLabel;
        [self.contentView addSubview:amountLabel];
        amountLabel.font = FONT(38);
        amountLabel.textAlignment = NSTextAlignmentRight;
        amountLabel.textColor = COLOR_666666;
    }
    return _amountLabel;
}
@end
@interface YNOrderGoodsHeaderView ()

@property (nonatomic,weak) UIView * bgView;

@property (nonatomic,weak) UILabel * nameLabel;

@property (nonatomic,weak) UILabel * statusLabel;

@end
@implementation YNOrderGoodsHeaderView

-(void)setDict:(NSDictionary *)dict{
    _dict  = dict;
    self.nameLabel.text = dict[@"name"];
    self.statusLabel.text = dict[@"status"];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize nameSize = [_nameLabel.text calculateHightWithFont:_nameLabel.font maxWidth:WIDTHF(_bgView)*2/3.0];
    self.nameLabel.frame = CGRectMake(W_RATIO(20), 0, nameSize.width, HEIGHTF(_bgView));
    self.statusLabel.frame = CGRectMake(MaxXF(_nameLabel), YF(_nameLabel), WIDTHF(_bgView)-MaxXF(_nameLabel)-W_RATIO(20)-kMinSpace, HEIGHTF(_nameLabel));
    
}
-(UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        _bgView = bgView;
        [self addSubview:bgView];
        bgView.frame =CGRectMake(W_RATIO(20),W_RATIO(20), WIDTHF(self)-W_RATIO(20)*2, HEIGHTF(self));
        bgView.backgroundColor = COLOR_FFFFFF;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(W_RATIO(20), W_RATIO(20))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        bgView.layer.mask = maskLayer;
        /**
         * UIRectCornerTopLeft
         * UIRectCornerTopRight
         * UIRectCornerBottomLeft
         * UIRectCornerBottomRight
         * UIRectCornerAllCorners
         */
    }
    return _bgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.bgView addSubview:nameLabel];
        nameLabel.font = FONT(28);
        nameLabel.textColor = COLOR_666666;
    }
    return _nameLabel;
}
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        UILabel *statusLabel = [[UILabel alloc] init];
        _statusLabel = statusLabel;
        [self.bgView addSubview:statusLabel];
        statusLabel.font = FONT(24);
        statusLabel.textAlignment = NSTextAlignmentRight;
        statusLabel.textColor = COLOR_DF463E;
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

@end
@implementation YNOrderGoodsFooterView

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.totallLabel.text = @"共计（不含邮费）：";
    self.markLabel.text = @"￥";
    self.priceLabel.text = dict[@"price"];
    
    self.status = dict[@"status"];
    
    
    
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
    
    if ([self.status isEqualToString:@"待处理"]) {
        self.rightBtn.tag = 200+1;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = NO;
        [_rightBtn setTitle:@"马上付款" forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_A4A4A4;
        [_rightBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        self.leftBtn.tag = 100+1;
        _leftBtn.hidden = NO;
        _leftBtn.enabled = YES;
        [_leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        _leftBtn.backgroundColor = COLOR_FFFFFF;
        [_leftBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        //待处理无法付款原因
        self.questionBtn.hidden = NO;
        self.questionLabel.hidden = NO;
    }else if ([self.status isEqualToString:@"待付款"]){
        self.rightBtn.tag = 200+2;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        [_rightBtn setTitle:@"马上付款" forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_DF463E;
        [_rightBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        self.leftBtn.tag = 100+2;
        _leftBtn.hidden = NO;
        _leftBtn.enabled = YES;
        [_leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        _leftBtn.backgroundColor = COLOR_FFFFFF;
        [_leftBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        
        //待处理无法付款原因
        self.questionBtn.hidden = YES;
        self.questionLabel.hidden = YES;
    }else if ([self.status isEqualToString:@"待发货"]){
        self.rightBtn.tag = 200+3;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        self.rightBtn.enabled = YES;
        [_rightBtn setTitle:@"提现发货" forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_FFFFFF;
        [_rightBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        self.leftBtn.tag = 100+3;
        _leftBtn.hidden = YES;
        _leftBtn.enabled = NO;
        //待处理无法付款原因
        self.questionBtn.hidden = YES;
        self.questionLabel.hidden = YES;
    }else if ([self.status isEqualToString:@"待收货"]){
        self.rightBtn.tag = 200+4;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        [_rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_DF463E;
        [_rightBtn setTitleColor:COLOR_FFFFFF forState:UIControlStateNormal];
        self.leftBtn.tag = 100+4;
        _leftBtn.hidden = NO;
        _leftBtn.enabled = YES;
        [_leftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        _leftBtn.backgroundColor = COLOR_FFFFFF;
        [_leftBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        //待处理无法付款原因
        self.questionBtn.hidden = YES;
        self.questionLabel.hidden = YES;
    }else if ([self.status isEqualToString:@"待评价"]){
        self.rightBtn.tag = 200+5;
        _rightBtn.hidden = NO;
        _rightBtn.enabled = YES;
        [_rightBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        _rightBtn.backgroundColor = COLOR_FFFFFF;
        [_rightBtn setTitleColor:COLOR_000000 forState:UIControlStateNormal];
        self.leftBtn.tag = 100+5;
        _leftBtn.hidden = NO;
        _leftBtn.enabled = YES;
        [_leftBtn setTitle:@"再来一单" forState:UIControlStateNormal];
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
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(W_RATIO(20), W_RATIO(20))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        bgView.layer.mask = maskLayer;
        /** 
         * UIRectCornerTopLeft
         * UIRectCornerTopRight
         * UIRectCornerBottomLeft
         * UIRectCornerBottomRight
         * UIRectCornerAllCorners
         */
        
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
    NSLog(@"handleQuestionButtonClick");
}
-(UILabel *)questionLabel{
    if (!_questionLabel) {
        UILabel *questionLabel = [[UILabel alloc] init];
        _questionLabel = questionLabel;
        [self.bgView addSubview:questionLabel];
        questionLabel.text = @"为什么不能马上付款？";
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
    if (btn.tag == 100+1) {
        NSLog(@"取消订单");
    }else if (btn.tag == 100+2){
        NSLog(@"取消订单");
    }else if (btn.tag == 100+3){
    }else if (btn.tag == 100+4){
        NSLog(@"查看物流");
    }else if (btn.tag == 100+5){
        NSLog(@"再来一单");
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
        rightBtn.frame = CGRectMake(MaxXF(_priceLabel)-W_RATIO(160), MaxYF(_priceLabel)+W_RATIO(20), W_RATIO(160), W_RATIO(64));
    }
    return _rightBtn;
}
-(void)handleRightButtonClick:(UIButton*)btn{
    if (btn.tag == 200+1) {
        NSLog(@"马上付款");
    }else if (btn.tag == 200+2){
        NSLog(@"马上付款");
    }else if (btn.tag == 200+3){
        NSLog(@"提现发货");
    }else if (btn.tag == 200+4){
        NSLog(@"确认收货");
    }else if (btn.tag == 200+5){
        NSLog(@"查看物流");
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







