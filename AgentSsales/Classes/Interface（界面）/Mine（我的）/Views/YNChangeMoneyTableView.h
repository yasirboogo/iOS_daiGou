//
//  YNChangeMoneyTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNChangeMoneyTableView : UITableView
@property (nonatomic,strong) NSString *rateId;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong) NSDictionary * allTypeMoneys;

@property (nonatomic,copy) void(^didSelectMoneyTypeClickBlock)(NSInteger);

@property (nonatomic,copy) void(^didSelectMoneyNumClickBlock)();

@property (nonatomic,assign) NSInteger type1;

@property (nonatomic,copy) NSString * money1;

@property (nonatomic,assign) NSInteger type2;

@property (nonatomic,copy) NSString * money2;

@end

@interface YNChangeMoneyFooterView : UIView
@property (nonatomic,assign) NSInteger type1;
@property (nonatomic,copy) NSString * lastMoney;
@property (nonatomic,copy) void(^didSelectAllChangeMoneyBlock)(NSString*);
@end

@interface YNChangeMoneyCell : UITableViewCell

@property (nonatomic,copy) void(^didSelectMoneyTypeClickBlock)();

@property (nonatomic,copy) void(^didSelectMoneyNumClickBlock)();

@property (nonatomic,copy) NSString * name;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,copy) NSString * money;

@end
