//
//  YNGoodsSubmitView.h
//  AgentSsales
//
//  Created by innofive on 17/1/18.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGoodsSubmitView : UIView

@property (nonatomic,copy) NSDictionary * dict;

@property (nonatomic,copy) void(^handleSubmitButtonBlock)(void);

@end
