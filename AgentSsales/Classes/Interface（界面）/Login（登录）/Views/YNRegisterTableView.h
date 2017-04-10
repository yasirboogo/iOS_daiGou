//
//  YNRegisterTableView.h
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNRegisterTableView : UITableView

@property (nonatomic,copy) void(^didSelectAreaCellBlock)();

@property (nonatomic,copy) void(^didSelectSendPhoneCodeBlock)();

@property (nonatomic,strong) NSString *country;

@property (nonatomic,strong) NSString *loginphone;

@property (nonatomic,strong) NSString *checkCode;

@property (nonatomic,strong) NSString *password;

@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;

@end
