//
//  YNFireOrderCollectionView.h
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNFireOrderCollectionView : UICollectionView

@property (nonatomic,copy) NSString * postWay;

@property (nonatomic,copy) NSString * postMoney;

@property (nonatomic,copy) NSString * subMoney;

@property (nonatomic,strong) NSDictionary * dataDict;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,assign) NSInteger status;

@property (nonatomic,copy) void(^didSelectPostWayBlock)();

@property (nonatomic,copy) void(^didSelectAddressBlock)();

@property (nonatomic,copy) void(^didSelectDiscountBlock)(NSString*);

@end
@interface YNFireOrderCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNFireOrderHeaderView : UICollectionReusableView

@property (nonatomic,copy) void(^didSelectAddressBlock)();

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNFireOrderFooterView : UICollectionReusableView

@property (nonatomic,copy) void(^didSelectPostWayBlock)();

@property (nonatomic,copy) void(^didSelectDiscountBlock)();

@property (nonatomic,assign) NSInteger statusIndex;

@property (nonatomic,copy) NSString * postWay;

@property (nonatomic,assign) NSInteger allCount;

@property (nonatomic,copy) NSString * allPrice;

@property (nonatomic,copy) NSString * postMoney;

@property (nonatomic,copy) NSString * subMoney;

@end
