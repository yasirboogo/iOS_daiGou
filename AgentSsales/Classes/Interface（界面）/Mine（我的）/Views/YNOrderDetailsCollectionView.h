//
//  YNOrderDetailsCollectionView.h
//  AgentSsales
//
//  Created by innofive on 17/1/16.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNOrderDetailsCollectionView : UICollectionView

@property (nonatomic,strong) NSDictionary *dict;

@end
@interface YNDetailsManMsgCell : UICollectionViewCell


@property (nonatomic,strong) NSDictionary *dict;

@end
@interface YNDetailsOrderMsgCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary *dict;

@end
