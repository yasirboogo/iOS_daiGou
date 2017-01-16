//
//  YNMineHeaderView.h
//  AgentSsales
//
//  Created by innofive on 16/12/29.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNMineHeaderView : UIView

@property (nonatomic,copy)void(^didSelectScrollViewButtonClickBlock)(NSInteger);

@property (nonatomic,strong)UIImage *headImg;

@property (nonatomic,copy)NSString *nickName;

@property (nonatomic,copy)NSString *restMoney;

@end
