//
//  YNNewAddressTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNNewAddressTableView : UITableView

@property (nonatomic,copy) void(^didSelectAddressCellBlock)();

@property (nonatomic,strong) NSMutableDictionary * addressM;

@property (nonatomic,copy) NSString * area;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * phone;

@property (nonatomic,copy) NSString * locality;

@property (nonatomic,copy) NSString * details;

@property (nonatomic,copy) NSString * email;

@end
