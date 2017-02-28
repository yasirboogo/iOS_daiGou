//
//  YNShareThirdSelectView.h
//  AgentSsales
//
//  Created by innofive on 17/2/22.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNShareThirdSelectView : UIView

@property (nonatomic,copy) void(^didSelectShareThirdSelectBlick)(NSInteger);

@property (nonatomic, assign) BOOL isTapGesture;

- (void)showPopView:(BOOL)animated;

- (void)dismissPopView:(BOOL)animated;
@end
@interface YNShareThirdSelectCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dict;
@end
