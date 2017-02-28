
//  YNChangeMoneyView.h
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNChangeMoneyView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic, assign) BOOL isTapGesture;

@property (nonatomic, copy) void(^didSelectChangeWayCellBlock)(NSInteger);

-(instancetype)initWithRowHeight:(CGFloat)rowHeight width:(CGFloat)width showNumber:(NSInteger)showNumber;

- (void)showPopView:(BOOL)animated;

- (void)dismissPopView:(BOOL)animated;

@end
@interface YNChangeWayCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic,strong) NSDictionary * dict;

@end
