//
//  YNGoodsCartCollectionView.h
//  AgentSsales
//
//  Created by innofive on 17/1/15.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsCartCollectionView : UICollectionView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong) void(^didSelectOrderGoodsCell)(NSString*);

@end
@interface YNOrderGoodsCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNOrderGoodsHeaderView : UICollectionReusableView

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNOrderGoodsFooterView : UICollectionReusableView

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,strong) NSString * status;

@end
