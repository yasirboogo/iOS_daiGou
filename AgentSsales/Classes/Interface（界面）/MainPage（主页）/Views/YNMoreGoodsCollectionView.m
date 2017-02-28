//
//  YNShowMoreGoodsCell.m
//  AgentSsales
//
//  Created by innofive on 16/12/28.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "YNMoreGoodsCollectionView.h"
#import "YNHomePageCollectionView.h"

@interface YNMoreGoodsCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation YNMoreGoodsCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = W_RATIO(8);
    flowLayout.minimumInteritemSpacing = W_RATIO(8);
    flowLayout.itemSize = CGSizeMake(W_RATIO(371), W_RATIO(371)+W_RATIO(169));
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        //隐藏滑块
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = COLOR_EDEDED;
        
        [self registerClass:[YNShowGoodsCell class] forCellWithReuseIdentifier:@"goodCell"];
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
    YNShowGoodsCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodCell" forIndexPath:indexPath];
    goodsCell.backgroundColor = COLOR_FFFFFF;
    goodsCell.dict = _dataArray[indexPath.row];
    return goodsCell;
}


@end
