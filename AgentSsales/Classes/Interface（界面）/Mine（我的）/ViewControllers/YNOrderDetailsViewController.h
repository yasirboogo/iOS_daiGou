//
//  YNOrderDetailsViewController.h
//  AgentSsales
//
//  Created by innofive on 17/1/16.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNBaseViewController.h"

@interface YNOrderDetailsViewController : YNBaseViewController

@property (nonatomic,assign) NSInteger orderId;

@property (nonatomic,copy) NSString * postage;

@property (nonatomic,assign) MyOrderListModel * myOrderListModel;

@end
