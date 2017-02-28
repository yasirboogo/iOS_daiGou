//
//  YNHotGoodsClassesView.h
//  AgentSsales
//
//  Created by innofive on 17/2/7.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNHotGoodsClassesView : UICollectionView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,copy) void(^didSelectHotGoodsClassesCellBlock)(NSInteger);

@end
@interface YNHotGoodsClassesCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary *dict;

@end
