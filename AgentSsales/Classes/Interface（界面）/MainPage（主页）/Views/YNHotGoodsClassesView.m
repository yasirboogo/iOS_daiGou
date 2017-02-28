//
//  YNHotGoodsClassesView.m
//  AgentSsales
//
//  Created by innofive on 17/2/7.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNHotGoodsClassesView.h"

@interface YNHotGoodsClassesView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation YNHotGoodsClassesView
-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = W_RATIO(20);
    flowLayout.minimumInteritemSpacing = W_RATIO(20);
    flowLayout.itemSize = CGSizeMake(W_RATIO(223), W_RATIO(223)+W_RATIO(65));
    flowLayout.sectionInset = UIEdgeInsetsMake(W_RATIO(20), W_RATIO(20), W_RATIO(20), W_RATIO(20));
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = COLOR_EDEDED;
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[YNHotGoodsClassesCell class] forCellWithReuseIdentifier:@"classCell"];
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YNHotGoodsClassesCell *classCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
    classCell.backgroundColor = COLOR_FFFFFF;
    classCell.dict = _dataArray[indexPath.row];
    return classCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (self.didSelectHotGoodsClassesCellBlock) {
        self.didSelectHotGoodsClassesCellBlock(indexPath.row);
    }
}
@end
@interface YNHotGoodsClassesCell ()

@property (nonatomic,weak) UIImageView * bigImgView;

@property (nonatomic,weak) UILabel * nameLabel;

@end
@implementation YNHotGoodsClassesCell

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    [self.bigImgView sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"zhanwei1"]];
    self.nameLabel.text = dict[@"name"];
}

-(UIImageView *)bigImgView{
    if (!_bigImgView) {
        UIImageView *bigImgView = [[UIImageView alloc] init];
        _bigImgView = bigImgView;
        [self.contentView addSubview:bigImgView];
        bigImgView.frame = CGRectMake(0, 0, W_RATIO(223), W_RATIO(223));
    }
    return _bigImgView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        [self.contentView addSubview:nameLabel];
        nameLabel.font = FONT(28);
        nameLabel.textColor = COLOR_333333;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.frame = CGRectMake(XF(_bigImgView)+kMinSpace, MaxYF(_bigImgView),WIDTHF(_bigImgView)-2*kMinSpace, HEIGHTF(self)-HEIGHTF(_bigImgView));
    }
    return _nameLabel;
}
@end
