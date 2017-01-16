//
//  YNMineTableView.h
//  AgentSsales
//
//  Created by innofive on 16/12/29.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNMineTableView : UITableView

@property (nonatomic,copy) void(^didSelectMineTableViewCellClickBlock)(NSInteger);

@end
