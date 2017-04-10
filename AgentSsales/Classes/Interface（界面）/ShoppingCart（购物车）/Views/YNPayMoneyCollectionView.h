//
//  YNPayMoneyCollectionView.h
//  AgentSsales
//
//  Created by innofive on 17/1/20.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNPayMoneyCollectionView : UICollectionView

@property (nonatomic,copy) NSString *payMoney;

@property (nonatomic,strong) NSDictionary * orderDict;

@property (nonatomic,assign) NSInteger typeIndex;

@property (nonatomic,strong) NSArray<NSDictionary*> * payArray;

@property (nonatomic,copy) void(^didSelectPayWayCellBlock)(NSInteger);

@end
@interface YNPayOrderCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNPayWayCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,assign) BOOL isSelect;

@property (nonatomic,assign) BOOL isEnable;

@end
@interface YNPayHeaderView : UICollectionReusableView

@property (nonatomic,strong) NSString * tips;

@end
@interface YNPayFooterView : UICollectionReusableView

@property (nonatomic,copy) NSString * realprice;

@end
