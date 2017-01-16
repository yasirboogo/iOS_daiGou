//
//  YNSettingTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/10.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNSettingTableView : UITableView

@end

@interface YNSettingCell : UITableViewCell

@property (nonatomic,copy) UILabel * itemLabel;

@property (nonatomic,copy) UILabel * detailLabel;

@property (nonatomic,assign) BOOL isOn;

@property (nonatomic,copy) void(^didSelectSwitchButtonClick)(BOOL);

@end
