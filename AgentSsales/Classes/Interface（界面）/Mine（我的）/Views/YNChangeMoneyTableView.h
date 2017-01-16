//
//  YNChangeMoneyTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNChangeMoneyTableView : UITableView


@end

@interface YNChangeMoneyCell : UITableViewCell

@property (nonatomic,copy) void(^didSelectMoneyTypeClickBlock)(NSString*);

@property (nonatomic,copy) void(^didSelectMoneyNumClickBlock)(NSString*);

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,copy) NSString * money;

@end
