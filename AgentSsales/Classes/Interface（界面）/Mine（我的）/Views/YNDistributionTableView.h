//
//  YNDistributionTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/4.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNDistributionTableView : UITableView

@property (nonatomic,strong) NSMutableArray *dataArrayM;

@end

@interface YNDistributionCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dict;

@end
