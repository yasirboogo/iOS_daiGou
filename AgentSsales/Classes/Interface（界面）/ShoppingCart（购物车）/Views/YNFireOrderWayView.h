//
//  YNFireOrderWayView.h
//  AgentSsales
//
//  Created by innofive on 17/1/20.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNFireOrderWayView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic, assign) BOOL isTapGesture;

@property (nonatomic, copy) void(^didSelectOrderWayCellBlock)(NSString*);

-(instancetype)initWithRowHeight:(CGFloat)rowHeight width:(CGFloat)width showNumber:(NSInteger)showNumber;

- (void)showPopView:(BOOL)animated;

- (void)dismissPopView:(BOOL)animated;

@end
@interface YNOrderWayCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,assign) BOOL isSelect;

@end
