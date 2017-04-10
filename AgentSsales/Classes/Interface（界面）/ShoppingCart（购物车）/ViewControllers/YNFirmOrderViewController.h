//
//  YNFirmOrderViewController.h
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNBaseViewController.h"

@interface YNFirmOrderViewController : YNBaseViewController

@property (nonatomic,assign) NSInteger status;

@property (nonatomic,copy) NSString *shoppingId;

@property (nonatomic,copy) NSString *style;

@property (nonatomic,copy) NSString *count;

@property (nonatomic,copy) NSString *goodsId;

@property (nonatomic,copy) void(^didSelectCouponBlock)(NSString*,NSString*);

@end
