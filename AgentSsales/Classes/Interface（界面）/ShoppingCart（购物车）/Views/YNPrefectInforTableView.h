//
//  YNPrefectInforTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/19.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNPrefectInforTableView : UITableView

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * phone;

@property (nonatomic,copy) NSString * locality;

@property (nonatomic,copy) NSString * details;

@property (nonatomic,copy) NSString * emial;

@property (nonatomic,copy) NSString * numberID;

@property (nonatomic,copy) void(^didSelectAddressCellBlock)();

@end
