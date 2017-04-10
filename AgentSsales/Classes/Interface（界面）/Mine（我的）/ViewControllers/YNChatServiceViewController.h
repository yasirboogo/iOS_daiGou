//
//  YNChatServiceViewController.h
//  AgentSsales2
//
//  Created by innofive on 17/3/17.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface YNChatServiceViewController : RCConversationViewController

/**  nav背景view */
@property (nonatomic, strong) UIView *navView;
/**  左边的button */
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end
