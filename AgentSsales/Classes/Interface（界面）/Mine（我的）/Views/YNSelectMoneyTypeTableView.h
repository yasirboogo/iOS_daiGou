//
//  YNSelectMoneyTypeTableView.h
//  AgentSsales
//
//  Created by innofive on 17/3/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNSelectMoneyTypeTableView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) void(^didSelectMoneyTypeCellBlock)(NSInteger);

@end
