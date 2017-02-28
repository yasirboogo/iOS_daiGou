//
//  YNShowAllGoodsClassView.m
//  AgentSsales
//
//  Created by innofive on 17/2/7.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNShowAllGoodsClassView.h"

@interface YNShowAllGoodsClassView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YNShowAllGoodsClassView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kMidSpace, 0, kMidSpace);
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-kMidSpace*2)/3, W_RATIO(90));
        CGRect frame = CGRectMake(0,0,SCREEN_WIDTH,flowLayout.itemSize.height*4);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        [self addSubview:collectionView];
        collectionView.backgroundColor = COLOR_FFFFFF;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [collectionView registerClass:[YNShowAllGoodsClassCell class] forCellWithReuseIdentifier:@"titleCell"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YNShowAllGoodsClassCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
    titleCell.title = _dataArray[indexPath.row][@"classname"];
    return titleCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (self.didSelectGoodsClassCellButtonBlock) {
        self.didSelectGoodsClassCellButtonBlock(indexPath.row);
    }
}
@end
@interface YNShowAllGoodsClassCell ()

@property (nonatomic,weak) UILabel * titleLabel;

@end
@implementation YNShowAllGoodsClassCell

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        titleLabel.font = FONT(30);
        titleLabel.textColor = COLOR_333333;
        titleLabel.frame = self.contentView.bounds;
    }
    return _titleLabel;
}

@end
