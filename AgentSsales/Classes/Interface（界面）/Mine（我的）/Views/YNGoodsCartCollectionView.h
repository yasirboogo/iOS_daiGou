//
//  YNGoodsCartCollectionView.h
//  AgentSsales
//
//  Created by innofive on 17/1/15.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsCartCollectionView : UICollectionView

@property (nonatomic,strong) NSMutableArray * dataArrayM;

@property (nonatomic,strong) void(^didSelectOrderGoodsCell)(NSInteger,NSInteger,NSString*);

@property (nonatomic,copy) void(^didFooterViewLeftButtonBlock)(NSInteger,NSInteger,NSInteger,NSString*);

@property (nonatomic,copy) void(^didFooterViewRightButtonBlock)(NSInteger,NSInteger,NSInteger,NSString*);

@property (nonatomic,copy) void(^didFooterViewQuestionButtonBlock)();

@end
@interface YNOrderGoodsCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,strong) MyOrderGoodsModel *myOrderGoodsModel;

@end
@interface YNOrderGoodsHeaderView : UICollectionReusableView

@property (nonatomic,copy) NSString * orderStasus;

@end
@interface YNOrderGoodsFooterView : UICollectionReusableView

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,strong) NSString * status;

@property (nonatomic,copy) void(^didFooterViewQuestionButtonBlock)();

@property (nonatomic,copy) void(^didFooterViewLeftButtonBlock)(NSInteger);

@property (nonatomic,copy) void(^didFooterViewRightButtonBlock)(NSInteger);

@end
