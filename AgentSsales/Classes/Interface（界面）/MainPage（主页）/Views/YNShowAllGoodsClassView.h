//
//  YNShowAllGoodsClassView.h
//  AgentSsales
//
//  Created by innofive on 17/2/7.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNShowAllGoodsClassView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) void(^didSelectSubmitButtonBlock)();

@end
@interface YNShowAllGoodsClassCell : UICollectionViewCell

@property (nonatomic, strong) NSString *title;

@end
