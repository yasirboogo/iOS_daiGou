//
//  YNFireOrderCollectionView.h
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNFireOrderCollectionView : UICollectionView

@property (nonatomic,strong) NSArray * dataArray;

@end
@interface YNFireOrderCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNFireOrderHeaderView : UICollectionReusableView

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNFireOrderFooterView : UICollectionReusableView

@property (nonatomic,strong) NSDictionary * dict;

@end
