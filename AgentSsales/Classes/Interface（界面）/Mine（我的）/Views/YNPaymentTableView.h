//
//  YNPaymentTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/5.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNPaymentTableView : UITableView

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,copy) void(^didSelectPaymentCellBlock)(NSInteger);

@end
@interface YNPaymentCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * dict;

@property (nonatomic,assign) BOOL isSelect;

@end
