//
//  YNChangeMoneyTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNChangeMoneyTableView : UITableView
@property (nonatomic,copy) void(^didSelectMoneyTypeClickBlock)(NSIndexPath*);

@property (nonatomic,copy) void(^didSelectMoneyNumClickBlock)();

@property (nonatomic,copy) NSString * type1;

@property (nonatomic,copy) NSString * money1;

@property (nonatomic,copy) NSString * type2;

@property (nonatomic,copy) NSString * money2;

@property (nonatomic,copy) NSString * lastMoney;

@end

@interface YNChangeMoneyCell : UITableViewCell

@property (nonatomic,copy) void(^didSelectMoneyTypeClickBlock)();

@property (nonatomic,copy) void(^didSelectMoneyNumClickBlock)();

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * money;

@end
