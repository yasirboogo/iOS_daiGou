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

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) void(^didSelectPostWayBlock)();

@end
@interface YNFireOrderCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNFireOrderHeaderView : UICollectionReusableView

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNFireOrderFooterView : UICollectionReusableView

@property (nonatomic,copy) void(^didSelectPostWayBlock)();

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,copy) NSString * postWay;

@end
