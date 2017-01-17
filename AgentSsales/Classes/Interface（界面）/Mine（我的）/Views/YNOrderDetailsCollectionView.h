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


@interface YNManMsgCellFrame : NSObject

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,assign) CGRect nameF;
@property (nonatomic,assign) CGRect phoneF;
@property (nonatomic,assign) CGRect addresssF;
@property (nonatomic,assign) CGRect bgViewF;

+(NSMutableArray *)initWithFromDictionaries:(NSArray*)array;

@end

@interface YNDetailsManMsgCell : UICollectionViewCell

@property (nonatomic,strong) YNManMsgCellFrame * cellFrame;

@end


@interface YNDetailsOrderMsgCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary *dict;

@property (nonatomic,weak) UILabel *itemLabel;

@property (nonatomic,weak) UILabel *detailsLabel;

@end
@interface YNOrderDetailsHeaderView : UICollectionReusableView
@property (nonatomic,strong) NSDictionary *dict;

@end
