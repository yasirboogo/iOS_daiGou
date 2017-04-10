//
//  YNUpdatePhoneTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNUpdatePhoneTableView : UITableView

@property (nonatomic,copy) void(^didSelectAreaCellBlock)();

@property (nonatomic,copy) void(^didSelectSendPhoneCodeBlock)();

@property (nonatomic,copy) NSString * country;

@property (nonatomic,copy) NSString * checkCode;

@property (nonatomic,copy) NSString * loginphone;

@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;


@end
