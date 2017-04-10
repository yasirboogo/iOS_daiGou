//
//  YNShareThirdSelectView.m
//  AgentSsales
//
//  Created by innofive on 17/2/22.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNShareThirdSelectView.h"

@interface YNShareThirdSelectView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UILabel * titleLabel;

@property (nonatomic,weak) UICollectionView * collectionView;

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation YNShareThirdSelectView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.collectionView];
        [self addSubview:self.cancelBtn];
    }
    return self;
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@{@"image":@"weixinhaoyou_fenxiang",@"title":@"微信好友"},
                       @{@"image":@"pengyouquan_fenxiang",@"title":@"微信朋友圈"},
                       @{@"image":@"QQ_fenxiang",@"title":@"QQ好友"},
                       @{@"image":@"facebook_fenxiang",@"title":@"脸书"},
                       @{@"image":@"Gjia_fenxiang",@"title":@"Google+"},
                       @{@"image":@"msn_fenxiang",@"title":@"MSN"}];
    }
    return _dataArray;
}
- (void)showPopView:(BOOL)animated
{
    [self.baseView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.baseView];
    
    if (!animated) {
        return;
    }
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    self.alpha = 0.f;
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0,SCREEN_HEIGHT- W_RATIO(450), SCREEN_WIDTH,  W_RATIO(450));
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
    
}
- (void)dismissPopView:(BOOL)animated
{
    if (!animated) {
        [self.baseView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.baseView removeFromSuperview];
    }];
}
-(UIView *)baseView{
    if (!_baseView) {
        UIView *baseView = [[UIView alloc] init];
        _baseView = baseView;
        [baseView setFrame:[UIScreen mainScreen].bounds];
        [baseView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [baseView setUserInteractionEnabled:YES];
        
    }
    return _baseView;
}
-(void)setIsTapGesture:(BOOL)isTapGesture{
    _isTapGesture = isTapGesture;
    if (isTapGesture) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureClick:)];
        [self.baseView addGestureRecognizer:tapGesture];
    }
}

- (void)handleTapGestureClick:(UITapGestureRecognizer *)tap
{
    [self dismissPopView:YES];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self addSubview:titleLabel];
        titleLabel.text = LocalShare;
        titleLabel.backgroundColor = COLOR_FFFFFF;
        titleLabel.font = FONT(40);
        titleLabel.textColor = COLOR_333333;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, W_RATIO(100));
    }
    return _titleLabel;
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn = cancelBtn;
        [self addSubview:cancelBtn];
        cancelBtn.titleLabel.font = FONT(32);
        [cancelBtn setTitle:LocalCancel forState:UIControlStateNormal];
        [cancelBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        cancelBtn.backgroundColor = COLOR_EDEDED;
        [cancelBtn addTarget:self action:@selector(handleCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(0,W_RATIO(350), SCREEN_WIDTH, W_RATIO(100));
    }
    return _cancelBtn;
}
-(void)handleCancelButtonClick:(UIButton*)btn{
    [self dismissPopView:YES];
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, W_RATIO(100), SCREEN_WIDTH,W_RATIO(250));
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0.f;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(W_RATIO(150), W_RATIO(250));
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        [self addSubview:collectionView];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = COLOR_FFFFFF;
        [collectionView registerClass:[YNShareThirdSelectCell class] forCellWithReuseIdentifier:@"selectCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YNShareThirdSelectCell *selectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"selectCell" forIndexPath:indexPath];
    selectCell.dict = _dataArray[indexPath.row];
    return selectCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    [self dismissPopView:YES];
    if (self.didSelectShareThirdSelectBlick) {
        self.didSelectShareThirdSelectBlick(indexPath.row);
    }
}
@end
@interface YNShareThirdSelectCell()
@property (nonatomic,weak) UIImageView * selectImgView;
@property (nonatomic,weak) UILabel * selectLabel;
@end
@implementation YNShareThirdSelectCell
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.selectImgView.image = [UIImage imageNamed:dict[@"image"]];
    self.selectLabel.text = dict[@"title"];
}

-(UIImageView *)selectImgView{
    if (!_selectImgView) {
        UIImageView *selectImgView = [[UIImageView alloc] init];
        _selectImgView = selectImgView;
        [self.contentView addSubview:selectImgView];
        selectImgView.frame = CGRectMake(W_RATIO(20), W_RATIO(50), W_RATIO(110),W_RATIO(110));
        
    }
    return _selectImgView;
}
-(UILabel *)selectLabel{
    if (!_selectLabel) {
        UILabel *selectLabel = [[UILabel alloc] init];
        _selectLabel = selectLabel;
        [self.contentView addSubview:selectLabel];
        selectLabel.textColor = COLOR_999999;
        selectLabel.font = FONT(22);
        selectLabel.textAlignment = NSTextAlignmentCenter;
        selectLabel.frame = CGRectMake(0, MaxYF(_selectImgView)+W_RATIO(20), W_RATIO(150), W_RATIO(40));
    }
    return _selectLabel;
}
@end
