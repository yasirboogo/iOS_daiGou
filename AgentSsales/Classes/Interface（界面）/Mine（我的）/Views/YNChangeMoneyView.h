
//  YNChangeMoneyView.h
//  AgentSsales
//
//  Created by innofive on 17/1/6.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNChangeMoneyView : UIView

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,weak) UIButton * changeTypeBtn;

@property (nonatomic,weak) UILabel * symbolLabel;

@property (nonatomic,weak) UILabel * moneyLabel;


@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * changeType;

@property (nonatomic,copy) NSString * money;

@end
