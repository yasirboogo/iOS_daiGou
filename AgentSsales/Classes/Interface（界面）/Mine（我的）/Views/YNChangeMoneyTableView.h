//
//  YNChangeMoneyTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNChangeMoneyTableView : UITableView

@property (nonatomic,strong) NSString *rate2Id;

@property (nonatomic,strong) NSString *rate3Id;

@property (nonatomic,strong) NSArray * dataArray;

@property (nonatomic,strong) NSDictionary * allTypeMoneys;

@property (nonatomic,copy) void(^didSelectMoneyTypeClickBlock)(void);

@property (nonatomic,copy) void(^didSelectMoneyNumClickBlock)();

@property (nonatomic,assign) NSInteger type1;

@property (nonatomic,copy) NSString * money1;

@property (nonatomic,assign) NSInteger type2;

@property (nonatomic,copy) NSString * money2;

@property (nonatomic,assign) NSInteger type3;

@property (nonatomic,copy) NSString * money3;

@end

@interface YNChangeMoneyFooterView : UIView
@property (nonatomic,assign) NSInteger type1;
@property (nonatomic,copy) NSString * lastMoney;
@property (nonatomic,copy) void(^didSelectAllChangeMoneyBlock)(NSString*);
@end

@interface YNChangeMoneyCell : UITableViewCell

@property (nonatomic,copy) void(^didSelectMoneyTypeClickBlock)();

@property (nonatomic,copy) void(^didSelectMoneyNumClickBlock)();

@property (nonatomic,assign) NSInteger nameType;

@property (nonatomic,assign) NSInteger moneyType;

@property (nonatomic,copy) NSString * money;

@end
