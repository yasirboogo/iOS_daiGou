//
//  YNNewsListTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/13.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNNewsListTableView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,copy) void(^didSelectNewsListCellBlock)(NSString*);

@end
@interface YNNewsHeaderView : UIView

@property (nonatomic,strong) NSDictionary * dict;

@end
@interface YNNewsListCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * dict;

@end
