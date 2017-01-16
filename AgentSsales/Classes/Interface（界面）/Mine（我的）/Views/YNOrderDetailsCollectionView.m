//
//  YNOrderDetailsCollectionView.m
//  AgentSsales
//
//  Created by innofive on 17/1/16.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNOrderDetailsCollectionView.h"

@interface YNOrderDetailsCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    
    
//    [self registerClass:[YNOrderGoodsCell class] forCellWithReuseIdentifier:@"goodsCell"];
//    [self registerClass:[YNOrderGoodsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
//    [self registerClass:[YNOrderGoodsFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    return self;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    [self reloadData];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(WIDTHF(self)-W_RATIO(20)*2, W_RATIO(208));
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
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.backgroundColor = COLOR_FFFFFF;
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
