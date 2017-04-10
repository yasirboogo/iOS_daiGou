//
//  YNForgetPwdTableView.h
//  AgentSsales
//
//  Created by innofive on 17/2/8.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNForgetPwdTableView : UITableView

@property (nonatomic,copy) void(^didSelectSendPhoneCodeBlock)();

@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;

@property (nonatomic,copy) NSString * checkCode;

@property (nonatomic,copy) NSString * firPassword;

@property (nonatomic,copy) NSString * secPassword;

@end
