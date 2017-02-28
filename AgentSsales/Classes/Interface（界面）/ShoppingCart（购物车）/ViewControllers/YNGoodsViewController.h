//
//  YNGoodsViewController.h
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNBaseViewController.h"

@class YNGoodsCartTableView;
@interface YNGoodsViewController : UIViewController

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) BOOL status;

@property (nonatomic,weak) YNGoodsCartTableView * tableView;

@end
