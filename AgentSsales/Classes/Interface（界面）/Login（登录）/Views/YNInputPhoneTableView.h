//
//  YNInputPhoneTableView.h
//  AgentSsales1
//
//  Created by innofive on 17/2/9.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNInputPhoneTableView : UITableView
@property (nonatomic,copy) void(^didSelectAreaCellBlock)();


@property (nonatomic,strong) NSString *code;

@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;

@property (nonatomic,strong) NSMutableArray<NSString*> *textArrayM;

@end
